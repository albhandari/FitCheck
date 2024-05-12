//
//  ChatBotViewModel.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import Foundation

class ChatBotViewModel: ObservableObject{
    @Published var chatResponse: ChatResponse?
    @Published var chatMessage: String?
    
    var chatBotService: ChatBotService
    
    init(chatBotService: ChatBotService) {
        self.chatBotService = chatBotService
    }
    
    
    @MainActor
    func fetchMessage(message: String) async{
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {return}
        
        let chatBotResponse = try? await chatBotService.getChatResponse(url: url, userInput: message)
        if let chatBotResponse = chatBotResponse{
            self.chatResponse = chatBotResponse
            self.chatMessage = chatBotResponse.choices[0].message.content
            print(self.chatMessage ?? "Empty string in fetchMessage()")
        }
        
        else{
            print("System error, as the response cannot be found")
        }
    }
}
