//
//  BookListViewRow.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookListViewRow: View {
    @EnvironmentObject var model:BookModel
    var item:Book
    var showStatus = false
    
    var body: some View {
            HStack(){
                VStack{
                    Text(item.title.capitalized)
                    Text(item.author.capitalized)
                        .font(.caption)
                }
                Spacer()
                if showStatus{
                    Text(item.status)
                        .font(.subheadline)
                }
                
            }
            .swipeActions {
                Button(role:.destructive) {
                    model.deleteBook(id: item.id)
                    model.getAllBooks()
                } label: {
                    Label("Delete", systemImage: "trash.circle.fill")
                }
            }
        }
}

