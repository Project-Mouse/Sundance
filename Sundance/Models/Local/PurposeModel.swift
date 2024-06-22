//
//  PurposeModel.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import Foundation
import SwiftData

@Model
class PurposeModel {
    let purpose: String
    let date: Date
    
    init(purpose: String, date: Date) {
        self.purpose = purpose
        self.date = date
    }
}
