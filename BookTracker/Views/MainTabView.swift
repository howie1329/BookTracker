//
//  MainTabView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var model:BookModel
    var body: some View {
        TabView{
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            BookListView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Book List")
                }
            WishListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Wish List")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(BookModel())
    }
}
