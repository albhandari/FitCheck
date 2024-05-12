//
//  ChatBotService.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import Foundation

protocol ChatBotService{
    
    func getChatResponse(url: URL, userInput: String) async throws -> ChatResponse

    
}


class ChatBotServiceImpl: ChatBotService{
    func getChatResponse(url: URL, userInput: String) async throws -> ChatResponse {
        let data = try await NetworkManagerImpl.shared.fetchData(source: url, userInput)
        let chatBotResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        return chatBotResponse
    
    }
}
