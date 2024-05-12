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
        Button("Click me"){
            Task{
                await chatBotVM.fetchMessage(message: "Put an emoji next to each word with appropriate emoji: Never stop gambling. Alright? You are one spin away from GENERATIONAL wealth. Your DAUGHTER'S college tuition is one spin away. Put your life savings on black. Remember that. Just go to Vegas, and if you lose just keep getting loans. Remember this. Just keep spinning. Keep spinning. Just keep gambling. Keep gambling. You CANT LOSE...You literally CANT LOSE. You can only QUIT.")
            }
            
        }
    }
}

#Preview {
    ChatBotView()
}
