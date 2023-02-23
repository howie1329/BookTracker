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
                List(){
                    ForEach(model.books){ item in
                        NavigationLink(destination: BookDetailView()) {
                            BookListViewRow(item: item,showStatus: true)
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
