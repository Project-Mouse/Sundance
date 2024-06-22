//
//  WorkoutModel.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import Foundation
import SwiftData


@Model
class WorkoutModel{
    let workoutId: Int
    let workoutDuration: Int
    let workoutType: String
    let workoutTrainer: String
    let workoutDate: Date
    
    init(workoutId: Int, workoutDuration: Int, workoutType: String, workoutTrainer: String, workoutDate: Date) {
        self.workoutId = workoutId
        self.workoutDuration = workoutDuration
        self.workoutType = workoutType
        self.workoutTrainer = workoutTrainer
        self.workoutDate = workoutDate
    }
}
