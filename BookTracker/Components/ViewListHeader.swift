//
//  ViewListHeader.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/23/23.
//

import SwiftUI

struct ViewListHeader: View {
    var title:String
    var buttonImage:String
    @State private var showView = false
    var body: some View {
        HStack(){
            Spacer()
            Text(title)
                .bold()
                .font(.title)
                .padding(.leading,25)
            Spacer()
            Button {
                showView.toggle()
            } label: {
                Image(systemName: buttonImage)
                    .foregroundColor(.black)
            }.sheet(isPresented: $showView) {
                AddBookView()
            }
        }
    }
}

