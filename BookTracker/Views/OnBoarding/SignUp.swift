//
//  SignUp.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/26/23.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var model:BookModel
    @State var email:String = ""
    @State var password:String = ""
    var body: some View {
        VStack{
            Form{
                TextField("Email", text: $email)
                TextField("Password",text: $password)
            }
            HStack{
                Button {
                    model.createUser(email: email, password: password)
                } label: {
                    Text("Sign Up")
                }.buttonStyle(.borderedProminent)
                
                Button {
                    model.signInCondition = .main
                } label: {
                    Text("Cancel")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Sign Up")
    }
}

