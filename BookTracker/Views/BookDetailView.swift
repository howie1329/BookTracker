//
//  BookDetailView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookDetailView: View {
     var book:Book
    var body: some View {
            VStack(alignment:.leading){
                VStack(alignment:.leading, spacing: 15){
                    Text("Book Title: \(book.title)")
                        .font(.largeTitle)
                    Text("Author: \(book.author)")
                        .font(.headline)
                    Text("Pages: \(book.pages)")
                    Text("Book Status: \(book.status)")
                    Text("Book Description: \(book.description)")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("\(book.title)'s Details")
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(id: "test123", title: "Test", author: "ME", pages: 234, status: "Not Started", rating: 3,description: "Great book about life"))
    }
}
