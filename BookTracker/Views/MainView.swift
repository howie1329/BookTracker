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
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("OffWhite")
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        Chart{
                            ForEach(model.bookData){item in
                                BarMark(
                                    x: .value("Status", item.statusName),
                                    y: .value("Books" ,item.bookAmount)
                                )
                                .foregroundStyle(Color.blue.gradient)
                                .cornerRadius(20)
                            }
                        }
                        .background(Color("OffWhite"))
                        .frame(height: 200)
                        .cornerRadius(20)
                        .padding(.bottom)
                    }
                    VStack{
                        Text("To Read")
                            .font(.system(size: 18))
                        Picker("Books", selection: $listBookshow) {
                            ForEach(bookShowOptions, id: \.self){
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                        List(model.books){item in
                            if item.status == "In Progress" && listBookshow == "In Progress"{
                                NavigationLink(destination: BookDetailView(book: item)) {
                                    VStack{
                                        Text(item.title.capitalized)
                                            .bold()
                                        Text(item.author.capitalized)
                                            .font(.caption)
                                    }
                                }
                            }
                            else if item.status == "Finished" && listBookshow == "Finished"{
                                NavigationLink(destination: BookDetailView(book: item)) {
                                    VStack{
                                        Text(item.title.capitalized)
                                            .bold()
                                        Text(item.author.capitalized)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Book Tracker")
                .toolbar{
                    Button {
                        showProfileView.toggle()
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.black)
                    }.sheet(isPresented: $showProfileView) {
                        ProfileView()
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
