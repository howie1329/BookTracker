//
//  Book.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import Foundation

struct Book: Hashable, Identifiable{
    
    var id:String
    var title:String
    var author:String
    var pages:Int
    var status:String
    var rating:Int
    
}
