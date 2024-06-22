//
//  SegementModel.swift
//  Sundance
//
//  Created by Imran razak on 14/06/2024.
//
/*
 Abstract
 
 This model defines the local presistence for profile.
 */

import Foundation
import SwiftData

@Model
class ProfileModel{
    let profileName: String
    let profileAvatar: String //URL for Profile Avatar
    let profileAge: Int
    let profileGender: String
    let profileHeight: Double
    let profileWeight: Double
    
    init(profileName: String, profileAvatar: String, profileAge: Int, profileGender: String, profileHeight: Double, profileWeight: Double) {
        self.profileName = profileName
        self.profileAvatar = profileAvatar
        self.profileAge = profileAge
        self.profileGender = profileGender
        self.profileHeight = profileHeight
        self.profileWeight = profileWeight
    }
}
