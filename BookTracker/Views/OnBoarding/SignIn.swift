//
//  SignIn.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/26/23.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var model:BookModel
    @State var email:String = ""
    @State var password:String = ""
    var body: some View {
        VStack{
            Form{
                TextField("Email", text: $email)
                TextField("Password",text: $password)
            }
            Button {
                model.signInUser(email: email, password: password)
                model.signInCondition = .main
            } label: {
                Text("Sign In")
            }
        }
        .navigationTitle("Sign In")
        
        
    }
}
