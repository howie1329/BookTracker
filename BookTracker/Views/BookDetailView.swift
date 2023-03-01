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
        VStack(alignment:.center){
            
            Spacer()
            
            Text("\(book.title)")
                .font(.largeTitle)
            Text("Author: \(book.author)")
                .font(.headline)
            
            VStack(alignment:.leading, spacing: 15){
                
                if editMode{
                    VStack{
                        Form{
                            Section{
                                TextField("Pages", value: $editPages, format:.number)
                            } header: {
                                Text("Pages")
                            }
                            Section{
                                Picker("Status", selection: $editStatus) {
                                    ForEach(readingStatus, id: \.self){item in
                                        Text(item)
                                    }
                                }.pickerStyle(.segmented)
                            } header: {
                                Text("Book Status")
                            }
                            
                            Section{
                                Stepper("Rating: \(editRating)", value: $editRating,in: 0...5)
                            } header: {
                                Text("Book Rating")
                            }
                            Section{
                                TextField("Description", text: $editDescription)
                            } header: {
                                Text("Book Description")
                            }
                        }
                        Button {
                            model.updateBook(book: Book(id: book.id, userID: model.currentUserID, title: book.title, author: book.author, pages: editPages, status: editStatus, rating: editRating, description: editDescription))
                            model.getAllBooks()
                            editMode.toggle()
                        } label: {
                            Text("Submit Changes")
                        }

                    }
                    
                }else{
                    VStack(alignment:.center,spacing: 15){
                        VStack(alignment:.leading,spacing:15){
                            Text("Pages: \(book.pages)")
                            Text("Book Status: \(book.status)")
                            Text("Book Rating: \(book.rating)")
                            Text("Book Description: \(book.description)")
                        }
                        Button {
                            editPages = book.pages
                            editStatus = book.status
                            editRating = book.rating
                            editDescription = book.description
                            editMode.toggle()
                        } label: {
                            Text("Edit Book")
                        }
                    }
                }
                
                
            }
            Spacer()
            Spacer()
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
