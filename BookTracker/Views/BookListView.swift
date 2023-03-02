//
//  BookListView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var model:BookModel
    @State var showView = false
    
    @State var showDetail = false
    
    @State var presentationDetents = PresentationDetent.medium
    
    @State var searchBar = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                VStack{
                    List{
                        ForEach(model.books){ item in
                            
                            if item.title.contains(searchBar){
                                Button {
                                    model.currentBookSelected = item
                                    showDetail.toggle()
                                } label: {
                                    BookListViewRow(item: item,showStatus: true)
                                }
                                .sheet(isPresented: $showDetail) {
                                    BookDetailView(book: model.currentBookSelected)
                                        .presentationDetents([.medium,.large], selection: $presentationDetents)
                                }
                            }
                            else if searchBar == ""{
                                Button {
                                    model.currentBookSelected = item
                                    showDetail.toggle()
                                } label: {
                                    BookListViewRow(item: item,showStatus: true)
                                }
                                .sheet(isPresented: $showDetail) {
                                    BookDetailView(book: model.currentBookSelected)
                                        .presentationDetents([.medium,.large], selection: $presentationDetents)
                                }
                            }  
                        }
                    }
                    .searchable(text:$searchBar)
                    .scrollContentBackground(.hidden)
                }
                .toolbar{
                    HStack(spacing:100){
                        
                        Text("Book List")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                        Button {
                            showView.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }.sheet(isPresented: $showView) {
                            AddBookView(isPresented: $showView)
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
