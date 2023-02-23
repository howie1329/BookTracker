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
        VStack {
            Chart{
                ForEach(model.bookData){item in
                    BarMark(
                        x: .value("Status", item.statusName),
                        y: .value("Books" ,item.bookAmount)
                    )
                }
            }
            .padding()
            .frame(height: 250)
            List(model.books){
                Text($0.author)
            }
            Text("Hello, world!")
            Button {
                print(model.books)
            } label: {
                Text("Press Me")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BookModel())
    }
}
