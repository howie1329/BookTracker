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
    @State var isEditing = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                VStack{
                    if showSearch{
                        HStack{
                            TextField("Search", text: $searchBar)
                                .padding(7)
                                .padding(.horizontal,25)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .transition(.move(edge: .top))
                                .animation(.default)
                                .onTapGesture {
                                    isEditing = true
                                }
                            
                            if isEditing {
                                Button {
                                    isEditing = false
                                    showSearch.toggle()
                                } label: {
                                    Text("Cancel")
                                }
                                .padding(10)
                                .transition(.move(edge: .trailing))
                                .animation(.default)

                            }
                        }
                        .padding()
                        
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
                            isEditing = false
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
