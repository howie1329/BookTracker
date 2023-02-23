//
//  WishListView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct WishListView: View {
    @EnvironmentObject var model:BookModel
    var body: some View {
        NavigationView {
            VStack{
                Text("Book List")
                    .bold()
                    .font(.title)
                List(){
                    ForEach(model.books){ item in
                        if item.status == "Want"{
                            NavigationLink(destination: BookDetailView()) {
                                BookListViewRow(item: item)
                            }
                        }
                        
                    }
                }
            }
            .padding()
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(BookModel())
    }
}
