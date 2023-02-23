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
    var body: some View {
        HStack(){
            Spacer()
            Text(title)
                .bold()
                .font(.title)
                .padding(.leading,25)
            Spacer()
            Button {
                AddBookView()
            } label: {
                Image(systemName: buttonImage)
            }
        }
    }
}

