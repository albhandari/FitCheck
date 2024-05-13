//
//  ChatResponseModel.swift
//  FitCheck
//
//  Created by Alex Bhandari on 3/29/24.
//

import Foundation

struct ChatResponse: Codable{
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    //let systemFingerprint: String
    
    enum CodingKeys: String, CodingKey {
        case id, object, created, model, choices, usage
        //case systemFingerprint = "system_fingerprint"
    }
    
}

struct Choice: Codable {
    let index: Int
    let message: Message
    //let logprobs: idk this shit is showing null
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index, message
        case finishReason = "finish_reason"
    }
}

struct Message: Codable{
    let role: String
    let content: String
}

struct Usage: Codable {
    let promptTokens, completionTokens, totalTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}










/**
 
 {
     "id": "chatcmpl-98L1IUno0MXAQTZjODqSBe5Pc0oHW",
     "object": "chat.completion",
     "created": 1711774452,
     "model": "gpt-3.5-turbo-0125",
     "choices": [
         {
             "index": 0,
             "message": {
                 "role": "assistant",
                 "content": "The weather in Albany, CA today is partly cloudy with a high of 68°F and a low of 54°F. There is a slight chance of rain showers later in the day."
             },
             "logprobs": null,
             "finish_reason": "stop"
         }
     ],
     "usage": {
         "prompt_tokens": 16,
         "completion_tokens": 38,
         "total_tokens": 54
     },
     "system_fingerprint": "fp_3bc1b5746c"
 }
 */
