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
                Section{
                    TextField("Email", text: $email)
                    SecureField("Password",text: $password)
                } header: {
                    Text("Start Here")
                }
               
            }
            HStack{
                Button {
                    model.signInUser(email: email, password: password)
                } label: {
                    Text("Sign In")
                }.buttonStyle(.borderedProminent)
                
                Button {
                    model.signInCondition = .main
                } label: {
                    Text("Cancel")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Sign In")
        
        
    }
}


