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
                ViewListHeader(title: "Book List", buttonImage: "square.grid.3x1.folder.badge.plus")
                List(){
                    ForEach(model.books){ item in
                        NavigationLink(destination: BookDetailView(book: item)) {
                            BookListViewRow(item: item,showStatus: true)
                        }
                    }
                }
            }
            .padding([.horizontal])
        }
        
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
            .environmentObject(BookModel())
    }
}
