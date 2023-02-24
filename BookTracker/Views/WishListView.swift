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
                ViewListHeader(title: "Wish List", buttonImage: "plus")
                List(){
                    ForEach(model.books){ item in
                        if item.status == "Want"{
                            NavigationLink(destination: BookDetailView(book: item)) {
                                BookListViewRow(item: item)
                            }
                        }
                        
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(BookModel())
    }
}
