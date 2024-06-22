//
//  APIService.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import Foundation

class APIService {
    let api: GraphQLAPI = GraphQLAPI()
    
    func listRuns() async throws -> [Runs] {
        do {
            let dataResponse: RunRepsonse = try await self.api.performOperation(GraphQLOperation.LIST_RUNS)
            return dataResponse.outdoorRuns
            
        } catch {
            print("Error fetching data:", error.localizedDescription)
            throw NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        }
    }
    
    func listCategories() async throws -> [WorkoutCategories] {
        do {
            let dataResponse: CategoryResponse = try await self.api.performOperation(GraphQLOperation.GET_CAT)
            return dataResponse.categories
            
        } catch {
            print("Error fetching data:", error.localizedDescription)
            throw NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data for Categories"])
        }
    }
    
    
    
     
}
