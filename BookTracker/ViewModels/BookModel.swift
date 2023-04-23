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
    @Published var goal:Int = 0
    @Published var progressBook:Int = 0
    @Published var notStartedBook:Int = 0
    @Published var wantBook:Int = 0
    @Published var totalPagesCollected:Int = 0
    
    @Published var currentBookSelected:Book = Book(id: "", userID: "", title: "", author: "", pages: 0, status: "", rating: 0, description: "")
    
    @Published var avgBookRating:Int = 0
    @Published var currentUserID:String = ""
    @Published var signInStatus:Bool = false
    @Published var signInError:String = ""
    @Published var currentUserName:String = ""
    
    
    @Published var signInCondition:signInState = .main
    
    init(){
    }
    
    func getAllBooks(){
        let db = Firestore.firestore()
        
        let collection = db.collection("Main").whereField("userID", isEqualTo: "AgxCatYT5CakPBsrv0PsLD1XXM03")
        
        collection.getDocuments { (snapShot, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let snapShot = snapShot {
                
                var allBooks : [Book] = []
                var ratingTotal: Int = 0
                var totalbooks: Int = 0
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
                    
                    ratingTotal += rating
                    totalbooks += 1
                    
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
                if totalbooks != 0 {
                    self.avgBookRating = ratingTotal/totalbooks
                }
                else{
                    self.avgBookRating = 0
                }
                
                
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
        
        collection.document(book.id).setData(["title":book.title,"author":book.author,"pages":book.pages,"status":book.status,"rating":book.rating,"description":book.description,"userID":book.userID])
    }
    
    func signInUser(email:String,password:String) {
        
        Auth.auth().signIn(withEmail: email, password: password){result,error in
            
            if error == nil{
                self.signInStatus.toggle()
                self.currentUserID = (result?.user.uid)!
                self.signInCondition = .inApp
                
                let db = Firestore.firestore()
                let collection = db.collection("Users")
                collection.getDocuments { (snapShot, error) in
                    
                    if let error = error{
                        print(error.localizedDescription)
                    } else if let snapShot = snapShot {
                        for doc in snapShot.documents{
                            
                            let data = doc.data()
                            
                            if data["email"] as! String == email{
                                self.goal = data["goal"] as? Int ?? 0
                                self.currentUserName = data["name"] as? String ?? ""
                            }
                        }
                    }
                    
                }
                
            }
            else{
                self.signInError = error?.localizedDescription ?? "Email or Password was Incorrect"
            }
        }
        
    }
    
    func createUser(email:String,password:String, user:User){
        Auth.auth().createUser(withEmail: email, password: password)
        self.signInCondition = .main
        
        let db = Firestore.firestore()
        let collection = db.collection("Users")
        collection.document().setData(["name":user.name,"goal":user.bookGoal,"email":user.email])
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
