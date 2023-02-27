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
    
    enum signInState{
        case signIn, signUp, main, inApp
    }
    
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
    @Published var totalPagesCollected:Int = 0
    
    @Published var currentUserID:String = ""
    @Published var signInStatus:Bool = false
    @Published var signInError:String = ""
    
    
    @Published var signInCondition:signInState = .main
    
    init(){
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
                self.totalPagesCollected = 0
                for doc in snapShot.documents{
                    let data = doc.data()
                    
                    if data["userID"] as? String ?? "" == self.currentUserID {
                        let id = doc.documentID
                        let userID = data["userID"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let author = data["author"] as? String ?? ""
                        let status = data["status"] as? String ?? ""
                        let pages = data["pages"] as? Int ?? 0
                        let rating = data["rating"] as? Int ?? 1
                        let description = data["description"] as? String ?? ""
                        
                        allBooks.append(Book(id: id,userID: userID, title: title, author: author, pages: pages, status: status, rating: rating, description: description))
                        
                        self.totalPagesCollected += pages
                        
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
        
        collection.document().setData(["userID":book.userID,"title":book.title,"author":book.author,"pages":book.pages,"status":book.status,"rating":book.rating,"description":book.description])
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
    
    func signInUser(email:String,password:String) {
        
        Auth.auth().signIn(withEmail: email, password: password){result,error in
            
            if error == nil{
                self.signInStatus.toggle()
                self.currentUserID = (result?.user.uid)!
                self.signInCondition = .inApp
            }
            else{
                self.signInError = error?.localizedDescription ?? "Email or Password was Incorrect"
            }
        }
        
    }
    
    func createUser(email:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password)
        self.signInCondition = .main
    }
    
    func signOutUser(){
        do{
            try Auth.auth().signOut()
            self.currentUserID = ""
            self.signInStatus.toggle()
            self.signInCondition = .main
        }
        catch{
            print(error)
        }
        
        
    }
    
    
    
}
