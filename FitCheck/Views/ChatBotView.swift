//
//  ChatBotView.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import SwiftUI

struct ChatBotView: View {
    @StateObject var chatBotVM = ChatBotViewModel(chatBotService: ChatBotServiceImpl())

    var body: some View {
        NavigationSplitView{
            VStack {
                Menu {
                    Picker("Select Chat Type", selection: $chatBotVM.selectedChatType) {
                        ForEach(chatBotVM.chatOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                } label: {
                    HStack {
                        Text(chatBotVM.selectedChatType)
                        Spacer()
                        Image(systemName: "chevron.down").resizable().frame(width: 10, height: 5)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                }
                .padding()
                ScrollView {
                    ForEach(chatBotVM.messages, id: \.content) { chatMessage in
                        HStack {
                            if chatMessage.sender == .user {
                                Spacer()
                                messageView(chatMessage)
                            } else {
                                if chatMessage.jsonObject {
                                    NavigationLink(destination: WorkoutDetailView(workoutModel: chatMessage.workoutObject)) {
                                        messageView(chatMessage)
                                    }
                                                            
                                }
                                else{
                                    messageView(chatMessage)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)

                HStack {
                    TextField("Type your message here...", text: $chatBotVM.inputText)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        Task {
                            if chatBotVM.selectedChatType == "Create Workout"{
                                chatBotVM.isWorkoutRequest = true
                            }
                            else{
                                chatBotVM.isWorkoutRequest = false
                            }
                            await chatBotVM.sendMessage(message: chatBotVM.inputText)
                            chatBotVM.inputText = ""
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        } detail: {
            Text("Select something")
        }
    }
}

@ViewBuilder
func messageView(_ message: ChatMessage) -> some View {
    Text(message.content)
        .padding()
        .background(message.sender == .user ? Color.blue : Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
}


#Preview {
    ChatBotView()
}
