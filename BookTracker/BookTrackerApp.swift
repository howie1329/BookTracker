//
//  BookTrackerApp.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import SwiftUI
import Firebase

@main
struct BookTrackerApp: App {
    
    init(){
        FirebaseApp.configure()
        start()
    }
    
    func start(){
        let db = Firebase.Firestore.firestore()
        
        let collection = db.collection("Main")
        
        collection.document("test123").setData(["title":"the selection","author":"howard thomas","pages":278,"status":true,"rating":3])
    
        
    }
    
    func find(){
        let db = Firestore.firestore()
        
        let collection = db.collection("Home")
        
        collection.getDocuments { (snapShot, error) in
            
            if let error = error{
                print(error.localizedDescription)
            }
            else if let snapShot = snapShot{
                
                for doc in snapShot.documents{
                    print(doc.documentID)
                }
            }
        }
        
        
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(BookModel())
        }
    }
}
