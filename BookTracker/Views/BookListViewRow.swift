//
//  BookListViewRow.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookListViewRow: View {
    var item:Book
    var showStatus = false
    
    var body: some View {
        HStack(spacing:70){
            VStack{
                Text(item.title.capitalized)
                Text(item.author.capitalized)
                    .font(.caption)
            }
            if showStatus{
                Text(item.status)
                    .font(.subheadline)
            }
           
        }
        .swipeActions {
            Button(role:.destructive) {
                print("Delete")
            } label: {
                Label("Delete", systemImage: "trash.circle.fill")
            }
            
            Button {
                print("Edit")
            } label: {
                Label("Edit", systemImage: "pencil.circle.fill")
            }
            .tint(.gray)
            
        }
    }
}

