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
    
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                VStack{
                    if showSearch{
                        Section{
                                TextField("Search", text: $searchBar)
                                    .background(Color.white)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.horizontal,.top])
                    }
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
                    .scrollContentBackground(.hidden)
                }
                .toolbar{
                    HStack(spacing:100){
                        Button {
                            showSearch.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }

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
