//
//  DataResponse.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import Foundation


// MARK: - Workouts
struct RunDataResponse: Codable{
    let data: RunRepsonse
}

struct RunRepsonse: Codable{
    let outdoorRuns: [Runs]
    
}

struct Runs: Codable, Identifiable, Hashable{
    let id = UUID().uuidString
    let runIdent: Int
    let thumbnail: String
    let runType: String
    let coachUrl: String
    let releaseDate: String
    let workoutUrl: String
    let trainer: String
    
    // Conformance to Hashable
    static func == (lhs: Runs, rhs: Runs) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//MARK: - Category

struct CategoryDataResponse: Codable {
    let data: CategoryResponse
}

struct CategoryResponse: Codable {
    let categories: [WorkoutCategories]
}

struct WorkoutCategories: Codable, Identifiable, Hashable {
    let id = UUID().uuidString
    let categoryName: String
    let tileUrl: String
    
    // Conformance to Hashable
    static func == (lhs: WorkoutCategories, rhs: WorkoutCategories) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

