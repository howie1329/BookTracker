//
//  ContentView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/22/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model:BookModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button {
                model.getAllBooks()
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
