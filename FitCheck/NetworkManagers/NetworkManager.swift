//
//  NetworkManager.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import Foundation

protocol NetworkManager{
    func fetchData(source: URL, _ message: String) async throws -> Data
}

class NetworkManagerImpl: NetworkManager{
    
    static let shared = NetworkManagerImpl()
    
    private init(){}
    
    enum NetworkError: Error{
        case invalidBodyData
        case invalidResponse
    }
    
    func fetchData(source: URL, _ message: String) async throws -> Data {
        /** Things to Note:
                1. Handling url so it's not empty or is a valid url
         */
        
        var request = URLRequest(url:source)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": message]
            ]
        ]
        let jsonBody = try JSONSerialization.data(withJSONObject: body, options: [])
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonBody)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkError.invalidResponse
        }
        
        return data
        
        
        
        //let (data, response) = try await URLSession.shared.data(from: source)
    }
    
}
