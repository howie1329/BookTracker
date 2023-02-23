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
    @Published var bookData: [BookChart]  =
    [
        BookChart(statusName: "Not Started", bookAmount: 5),
        BookChart(statusName: "In Progress", bookAmount: 8),
        BookChart(statusName: "Finished", bookAmount: 4)
    ]
    
    init(){
        getAllBooks()
    }
    
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
    
    func createBook(book:Book){
        
        let db = Firestore.firestore()
        
        let collection = db.collection("Main")
        
        collection.document().setData(["title":book.title,"author":book.author,"pages":book.pages,"status":book.status,"rating":book.rating])
    }
    
    func deleteBook(id:String){
        
        let db = Firestore.firestore()
        
        let collection = db.collection("Main")
        
        collection.document(id).delete()
    }
    
    func updateBook(book:Book){
        
        let db = Firestore.firestore()
        
        let collection = db.collection("Main")
        
        collection.document(book.id).setData(["title":book.title,"author":book.author,"pages":book.pages,"status":book.status,"rating":book.rating])
    }
    
}
