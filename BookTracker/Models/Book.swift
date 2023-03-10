//
//  Book.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import Foundation

struct Book: Hashable, Identifiable{
    
    var id:String
    var userID:String
    var title:String
    var author:String
    var pages:Int
    var status:String
    var rating:Int
    var description:String
    
}

struct BookChart: Identifiable{
    
    var id = UUID()
    var statusName:String
    var bookAmount:Int
}
