//
//  User.swift
//  OutdoorSpaces
//
//  Created by Daniel Budziwojski on 9/19/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import Foundation

class User {
    
    // MARK: Properties
    
    //User Details
    var firstName: String
    var lastName: String
    var osPoints: Int
    var tier: String
    
    var reviewedOS: [Int]
    
    //Create User
    init(_ firstName: String, _ lastName: String, _ osPoints: Int, _ tier:String, _ reviewedOS:[Int]) {
        self.firstName = firstName
        self.lastName = lastName
        self.osPoints = osPoints
        self.tier = tier
        self.reviewedOS = reviewedOS
    }
    
}
