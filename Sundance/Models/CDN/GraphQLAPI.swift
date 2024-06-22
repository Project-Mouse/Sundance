//
//  GraphQLAPI.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import Foundation

struct GraphQLOperation : Encodable {
    var operationString: String
    
    private let url = URL(string: "https://eu-west-2.cdn.hygraph.com/content/clxemjiza02r907w8xnsfjdty/master")!
    
    enum CodingKeys: String, CodingKey {
        case variables
        case query
    }
    
    init(_ operationString: String) {
        self.operationString = operationString
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(operationString, forKey: .query)
    }
    
    func getURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(self)
    
        return request
    }
}


class GraphQLAPI {

    func performOperation<Output: Decodable>(_ operation: GraphQLOperation) async throws -> Output {
        let request: URLRequest = try operation.getURLRequest()

        let (data, _) = try await URLSession.shared.getData(from: request)

        let result = try JSONDecoder().decode(GraphQLResult<Output>.self, from: data)
        guard let object = result.object else {
            print(result.errorMessages.joined(separator: "\n"))
            throw NSError(domain: "Error", code: 1)
        }

        return object
    }
}
