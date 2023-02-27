//
//  WishListView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct WishListView: View {
    @EnvironmentObject var model:BookModel
    @State var showView = false
    var body: some View {
        NavigationView {
            VStack{
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Wish List")
            .toolbar{
                Button {
                    showView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }.sheet(isPresented: $showView) {
                    AddBookView(isPresented: $showView)
                }
            }
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(BookModel())
    }
}
