//
//  GraphQLResults.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import Foundation

struct GraphQLResult<T: Decodable>: Decodable {
    let object: T?
    let errorMessages: [String]
    
    enum CodingKeys: String, CodingKey {
        case data
        case errors
    }
    
    struct Error: Decodable {
        let message: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let data = try container.decodeIfPresent(T.self, forKey: .data) {
            // If data is successfully decoded, assign it to object
            self.object = data
        } else {
            // If data cannot be decoded, assign nil to object
            self.object = nil
        }
        
        var errorMessages: [String] = []
        
        if let errors = try container.decodeIfPresent([Error].self, forKey: .errors) {
            errorMessages.append(contentsOf: errors.map { $0.message })
        }
        
        self.errorMessages = errorMessages
    }
}
