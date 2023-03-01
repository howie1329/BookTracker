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
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                VStack{
                    List(){
                        ForEach(model.books){ item in
                            Button {
                                showDetail.toggle()
                            } label: {
                                BookListViewRow(item: item,showStatus: true)
                            }
                            .sheet(isPresented: $showDetail) {
                                BookDetailView(book: item)
                                    .presentationDetents([.medium,.large], selection: $presentationDetents)
                            }
                            
                            
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .navigationBarTitleDisplayMode(.inline)
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
