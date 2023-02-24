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
        BookChart(statusName: "Not Started", bookAmount: 0),
        BookChart(statusName: "In Progress", bookAmount: 0),
        BookChart(statusName: "Finished", bookAmount: 0)
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
                    
                    if status == "Not Started"{
                        self.bookData[0].bookAmount += 1
                    }
                    else if status == "In Progress"{
                        self.bookData[1].bookAmount += 1
                    }
                    else if status == "Finished"{
                        self.bookData[2].bookAmount += 1
                    }
                    else{
                        
                    }
                    
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
    
    func searchBook(){
        
        let urlString = "https://openlibrary.org/search/authors.json?q=j%20k%20rowling"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                
                do{
                    print(data)
                    print(response)
                }catch{
                    print(error)
                }
            }
            
        }
        dataTask.resume()
    }
    
}
