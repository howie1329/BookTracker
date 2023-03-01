//
//  AddBookView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct AddBookView: View {
    
    @EnvironmentObject var model:BookModel
    @Binding var isPresented:Bool
    @State var bookTitle:String = ""
    @State var bookAuthor:String = ""
    @State var bookPages:Int = 0
    @State var bookStatus:String = "Not Started"
    @State var bookRating:Int = 0
    @State var bookDescription:String = ""
    
    
    
    private let readingStatus = ["Not Started","In Progress","Finished","Want"]
    private let ratingNumbers = [0,1,2,3,4,5]
    
    var body: some View {
        ZStack{
            Color("Third")
                .ignoresSafeArea()
            Spacer()
            VStack{
                Text("New Book")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                
                Form{
                    Section{
                        TextField("Book Title", text: $bookTitle)
                    } header: {
                        Text("Title")
                            .foregroundColor(.white)
                    }
                    Section{
                        TextField("Enter Book Author", text: $bookAuthor)
                    } header: {
                        Text("Author")
                            .foregroundColor(.white)
                    }
                    Section{
                        TextField("Enter # Of Pages", value: $bookPages,format: .number)
                    } header: {
                        Text("# of Pages")
                            .foregroundColor(.white)
                    }
                    Section{
                        TextField("What's The Book About", text: $bookDescription)
                    } header: {
                        Text("Book Description")
                            .foregroundColor(.white)
                    }
                    Section{
                        Picker("Reading Status:", selection: $bookStatus) {
                            ForEach(readingStatus, id: \.self){
                                Text($0)
                            }
                        }
                    } header: {
                        Text("Reading Status")
                            .foregroundColor(.white)
                    }
                    
                    Section{
                        Picker("Book Rating:", selection: $bookRating) {
                            ForEach(ratingNumbers, id: \.self){
                                Text("\($0)")
                            }
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("Book Rating")
                            .foregroundColor(.white)
                    }
                }
                .scrollContentBackground(.hidden)
                HStack{
                    Spacer()
                    Button {
                        model.createBook(book: Book(id: bookTitle,userID: model.currentUserID, title: bookTitle, author: bookAuthor, pages: bookPages, status: bookStatus, rating: bookRating, description: bookDescription))
                        model.getAllBooks()
                        isPresented = false
                    } label: {
                        Text("Submit")
                            .foregroundColor(Color("Third"))
                    }
                    .tint(.white)
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
            .padding()
            Spacer()
        }
    }
    
}

