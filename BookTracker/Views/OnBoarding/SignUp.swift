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
            Button {
                model.createUser(email: email, password: password)
                model.signInCondition = .main
                
            } label: {
                Text("Sign Up")
            }
        }
        .navigationTitle("Sign Up")
    }
}

