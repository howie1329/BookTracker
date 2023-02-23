//
//  BookListView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var model:BookModel
    var body: some View {
        NavigationView {
            VStack{
                Text("Book List")
                    .bold()
                    .font(.title)
                List(model.books){item in
                    NavigationLink(destination: BookDetailView()) {
                        HStack(spacing:70){
                            VStack{
                                Text(item.title.capitalized)
                                Text(item.author.capitalized)
                                    .font(.caption)
                            }
                            Text(item.status)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
            .environmentObject(BookModel())
    }
}
