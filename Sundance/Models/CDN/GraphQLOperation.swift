//
//  GraphQLOperation.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//

import Foundation

//MARK: - Get Workouts
extension GraphQLOperation {
    static var LIST_RUNS: Self {
        GraphQLOperation(
            """
            {
                outdoorRuns {
                    id
                    runIdent
                    thumbnail
                    runType
                    coachUrl
                    releaseDate
                    workoutUrl
                    trainer
                }
            }
            """
        )
    }
}


//MARK: - Categories

extension GraphQLOperation {
    static var GET_CAT: Self {
        GraphQLOperation(
            """
            {
                categories {
                    id
                    categoryName
                    tileUrl
                }
            }
            """
        )
    }
}

