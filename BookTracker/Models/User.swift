//
//  User.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/27/23.
//

import Foundation

struct User: Hashable, Identifiable {
    
    var id: String
    var name:String
    var bookGoal:Int
    var email:String
}
