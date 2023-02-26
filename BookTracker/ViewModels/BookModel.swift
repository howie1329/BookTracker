//
//  BookModel.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import Foundation
import Firebase
import FirebaseAuth

class BookModel: ObservableObject {
    
    @Published var books: [Book] = []
    @Published var bookData: [BookChart]  =
    [
        BookChart(statusName: "Not Started", bookAmount: 0),
        BookChart(statusName: "In Progress", bookAmount: 0),
        BookChart(statusName: "Finished", bookAmount: 0)
    ]
    @Published var currentRead:Int = 0
    @Published var goal:Int = 5
    @Published var progressBook:Int = 0
    @Published var notStartedBook:Int = 0
    @Published var wantBook:Int = 0
    @Published var currentUserID:String = ""
    @Published var signInStatus:Bool = false
    @Published var signInError:String = ""
    
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
                self.bookData[0].bookAmount = 0
                self.bookData[1].bookAmount = 0
                self.bookData[2].bookAmount = 0
                self.currentRead = 0
                self.progressBook = 0
                self.notStartedBook = 0
                self.wantBook = 0
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
                        self.notStartedBook += 1
                    }
                    else if status == "In Progress"{
                        self.bookData[1].bookAmount += 1
                        self.progressBook += 1
                    }
                    else if status == "Finished"{
                        self.bookData[2].bookAmount += 1
                        self.currentRead += 1
                    }else if status == "Want"{
                        self.wantBook += 1
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
    
    func signInUser(email:String,password:String) {
        
        Auth.auth().signIn(withEmail: email, password: password){result,error in
            
            if error == nil{
                self.signInStatus.toggle()
                self.currentUserID = (result?.user.uid)!
            }
            else{
                self.signInError = error?.localizedDescription ?? "Email or Password was Incorrect"
            }
        }
        
    }
    
    
    
}
