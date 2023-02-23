//
//  BookModel.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import Foundation
import Firebase

class BookModel: ObservableObject {
    
    @Published var books: [Book] = []
    
    func getAllBooks(){
        
        let db = Firestore.firestore()
        
        let collection = db.collection("Main")
        
        collection.getDocuments { (snapShot, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let snapShot = snapShot {
                
                var allBooks : [Book] = []
                for doc in snapShot.documents{
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let pages = data["pages"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 1
                    
                    allBooks.append(Book(id: id, title: title, author: author, pages: pages, status: status, rating: rating))
                    
                }
                self.books = allBooks
                
            } else{
                print("no data")
            }
        }
        
    }
    
}
