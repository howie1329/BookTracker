//
//  ContentView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import SwiftUI
import Charts

struct MainView: View {
    @EnvironmentObject var model:BookModel
    let bookShowOptions = ["In Progress","Finished"]
    @State var showProfileView = false
    @State var listBookshow = "In Progress"
    
    @State var showDetail = false
    @State var presentationDetents = PresentationDetent.medium
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                VStack(spacing:25) {
                    VStack{
                        Chart{
                            ForEach(model.bookData){item in
                                BarMark(
                                    x: .value("Status", item.statusName),
                                    y: .value("Books" ,item.bookAmount)
                                )
                                .foregroundStyle(Color.white.gradient)
                                .cornerRadius(20)
                            }
                        }
                        .background(Color("Third"))
                        .frame(height: 200)
                        .cornerRadius(20)
                    }
                    VStack{
                        Text("To Read")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .bold()
                        Picker("Books", selection: $listBookshow) {
                            ForEach(bookShowOptions, id: \.self){
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                        List(model.books){item in
                            if item.status == "In Progress" && listBookshow == "In Progress"{
                                Button {
                                    showDetail.toggle()
                                } label: {
                                    VStack{
                                        Text(item.title.capitalized)
                                            .bold()
                                        Text(item.author.capitalized)
                                            .font(.caption)
                                    }
                                }
                                .sheet(isPresented: $showDetail) {
                                    BookDetailView(book: item)
                                        .presentationDetents([.medium,.large], selection: $presentationDetents)
                                }

                            }
                            else if item.status == "Finished" && listBookshow == "Finished"{
                                Button {
                                    showDetail.toggle()
                                } label: {
                                    VStack{
                                        Text(item.title.capitalized)
                                            .bold()
                                        Text(item.author.capitalized)
                                            .font(.caption)
                                    }
                                }
                                .sheet(isPresented: $showDetail) {
                                    BookDetailView(book: item)
                                        .presentationDetents([.medium,.large], selection: $presentationDetents)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .padding()
                .toolbar{
                    HStack(spacing:65){
                        Spacer()
                        Text("Book Tracker")
                            .font(Font.title)
                            .bold()
                            .foregroundColor(.white)
                        Button {
                            showProfileView.toggle()
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color.white)
                        }.sheet(isPresented: $showProfileView) {
                            ProfileView()
                        }
                    }
                }
            }
        }
        .onAppear(){
            model.getAllBooks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BookModel())
    }
}
