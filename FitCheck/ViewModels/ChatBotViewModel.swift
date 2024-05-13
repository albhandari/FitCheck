//
//  ChatBotViewModel.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import Foundation

class ChatBotViewModel: ObservableObject{
    //@Published var chatResponse: ChatResponse?
    //@Published var chatMessage: String?
    
    @Published var messages: [ChatMessage] = []
    
    @Published var inputText: String = ""
    @Published var isWorkoutRequest: Bool = false
    
    @Published var selectedChatType: String = "General ChatBot"
    let chatOptions = ["General Questions", "Create Workout"]
    
    var chatBotService: ChatBotService
    
    init(chatBotService: ChatBotService) {
        self.chatBotService = chatBotService
    }
    
    
    @MainActor
    func sendMessage(message: String) async{
        
        let jsonScript = """
        {"message":"Your intro response","workout_title":"Title of the workout","workout_schedule":[{"day":"Day of the week","workout_description":"Workout Description","workout":[{"exercise_name":"Exercise Name","exercise_description":"Exercise Description","exercise_sets":"type string","exercise_reps":"type string"}]}]}
        """
        
        let fullMessage = isWorkoutRequest ? "\(message). Respond to my request, strictly in this json format: \(jsonScript)" : message
        
        let userMessage = ChatMessage(sender: .user, jsonObject: isWorkoutRequest, content: message)
        messages.append(userMessage)
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {return}
        
        let chatBotResponse = try? await chatBotService.getChatResponse(url: url, userInput: fullMessage)
        
//        if let chatBotResponse = chatBotResponse{
//            self.chatResponse = chatBotResponse
//            self.chatMessage = chatBotResponse.choices[0].message.content
//            print(self.chatMessage ?? "Empty string in fetchMessage()")
        
        if let response = chatBotResponse{
            var botMessage = ChatMessage(sender: .bot, jsonObject: isWorkoutRequest, content: response.choices[0].message.content)
            if(isWorkoutRequest == true){
                let workoutModel = self.decodeWorkoutSchedule(from: response.choices[0].message.content)
                botMessage = ChatMessage(sender: .bot, jsonObject: isWorkoutRequest, content: workoutModel?.message ?? "Error", workoutObject: workoutModel)
                
            }
            messages.append(botMessage)
        }
        else{
            let errorMessage = ChatMessage(sender: .bot, jsonObject: false, content: "Error retrieving response.")
            messages.append(errorMessage)
        }
        
//        else{
//            print("System error, as the response cannot be found")
//        }
    }
    
    func toggleRequestType(){
        isWorkoutRequest.toggle()
    }
    
    func decodeWorkoutSchedule(from jsonString: String) -> WorkoutModel? {
        print(jsonString)
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()

        do {
            let workoutModel = try decoder.decode(WorkoutModel.self, from: jsonData)
            return workoutModel
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

enum Sender {
    case user
    case bot
}

struct ChatMessage {
    let sender: Sender
    let jsonObject: Bool
    let content: String
    var workoutObject: WorkoutModel?
}




/*
 {
   "message": "Your intro response",
   "workout_schedule": [
     {
       "day": "Day of the week",
       "workout_description": "Workout Description",
       "workout": [
         {
           "exercise_name": "Exercise Name",
           "exercise_description": "Exercise Description",
           "exercise_sets": #type int,
           "exercise_reps": #type int
         }
       ]
     }
   ]
 }

 **/
