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
    var body: some View {
        NavigationView{
            ZStack{
                Color("OffWhite")
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Spacer()
                        Text("Book Tracker")
                            .bold()
                            .font(.title)
                            .padding(.leading,25)
                        Spacer()
                        Button {
                            print("profile button")
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    Chart{
                        ForEach(model.bookData){item in
                            BarMark(
                                x: .value("Status", item.statusName),
                                y: .value("Books" ,item.bookAmount)
                            )
                        }
                    }
                    .foregroundColor(Color("BlueMain"))
                    .background(Color("OffWhite"))
                    .frame(height: 175)
                    .cornerRadius(20)
                    Text("To Read")
                        .font(.system(size: 18))
                    List(model.books){item in
                        if item.status == "In Progress"{
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
                    .background(Color.black)
                    
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BookModel())
    }
}
