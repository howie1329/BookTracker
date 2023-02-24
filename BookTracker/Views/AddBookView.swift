//
//  AddBookView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct AddBookView: View {
    @EnvironmentObject var model:BookModel
    @State var bookTitle:String = ""
    @State var bookAuthor:String = ""
    @State var bookPages:Int = 0
    @State var bookStatus:String = "Not Started"
    @State var bookrating:Int = 0
    
    private var readingStatus = ["Not Started","In Progress","Finished","Want"]
    private var ratingNumbers = [0,1,2,3,4,5]
    var body: some View {
        Spacer()
        VStack{
            Text("New Book")
            Form{
                Section(header:Text("Title")){
                    TextField("Book Title", text: $bookTitle)
                }
                Section(header:Text("Author")){
                    TextField("Enter Book Author", text: $bookAuthor)
                }
                Section(header:Text("# of Pages")){
                    TextField("Enter # Of Pages", value: $bookPages,format: .number)
                }
                Section(header:Text("Reading Status")){
                    Picker("Reading Status:", selection: $bookStatus) {
                        ForEach(readingStatus, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section(header:Text("Book Rating")){
                    Picker("Book Rating:", selection: $bookrating) {
                        ForEach(ratingNumbers, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
                
            }
            HStack{
                Spacer()
                Button {
                    model.createBook(book: Book(id: bookTitle, title: bookTitle, author: bookAuthor, pages: bookPages, status: bookStatus, rating: bookrating))
                    model.getAllBooks()
                } label: {
                    Text("Submit")
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .padding([.bottom])
        Spacer()
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environmentObject(BookModel())
    }
}
