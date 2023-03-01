//
//  BookDetailView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var model:BookModel
    var book:Book
    @State var editMode: Bool = false
    private let readingStatus = ["Not Started","In Progress","Finished","Want"]
    
    @State var editPages = 0
    @State var editStatus = "Not Started"
    @State var editRating = 0
    @State var editDescription = ""
    var body: some View {
        ZStack{
            Color("Third")
                .ignoresSafeArea()
            VStack(alignment:.center){
                
                Spacer()
                
                Text("\(book.title)")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Author: \(book.author)")
                    .font(.headline)
                    .foregroundColor(Color.white)
                
                VStack(alignment:.leading, spacing: 15){
                    
                    if editMode{
                        VStack{
                            Form{
                                Section{
                                    TextField("Pages", value: $editPages, format:.number)
                                } header: {
                                    Text("Pages")
                                        .foregroundColor(Color.white)
                                }
                                Section{
                                    Picker("Status", selection: $editStatus) {
                                        ForEach(readingStatus, id: \.self){item in
                                            Text(item)
                                        }
                                    }.pickerStyle(.segmented)
                                } header: {
                                    Text("Book Status")
                                        .foregroundColor(Color.white)
                                }
                                
                                Section{
                                    Stepper("Rating: \(editRating)", value: $editRating,in: 0...5)
                                } header: {
                                    Text("Book Rating")
                                        .foregroundColor(Color.white)
                                }
                                Section{
                                    TextField("Description", text: $editDescription)
                                } header: {
                                    Text("Book Description")
                                        .foregroundColor(Color.white)
                                }
                            }
                            .scrollContentBackground(.hidden)
                            Button {
                                model.updateBook(book: Book(id: book.id, userID: model.currentUserID, title: book.title, author: book.author, pages: editPages, status: editStatus, rating: editRating, description: editDescription))
                                model.getAllBooks()
                                editMode.toggle()
                            } label: {
                                Text("Submit Changes")
                                    .foregroundColor(Color("Primary"))
                            }
                            .tint(Color.white)
                            .buttonStyle(.borderedProminent)
                            
                        }
                        
                    }else{
                        VStack(alignment:.center,spacing: 25){
                            VStack(alignment:.leading,spacing:15){
                                Text("Pages: \(book.pages)")
                                Text("Book Status: \(book.status)")
                                Text("Book Rating: \(book.rating)")
                                Text("\(book.description.capitalized)")
                            }
                            .foregroundColor(Color.white)
                            Button {
                                editPages = book.pages
                                editStatus = book.status
                                editRating = book.rating
                                editDescription = book.description
                                editMode.toggle()
                            } label: {
                                Text("Edit Book")
                                    .foregroundColor(Color("Primary"))
                                
                                
                            }
                            .tint(Color.white)
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                    
                    
                }
                Spacer()
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(book.title)'s Details")
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(id: "test123",userID: "test", title: "Test", author: "ME", pages: 234, status: "Not Started", rating: 3,description: "Great book about life"))
            .environmentObject(BookModel())
    }
}
