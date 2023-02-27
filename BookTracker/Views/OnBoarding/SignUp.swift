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
    @State var name:String = ""
    @State var bookGoal:Int = 0
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("First Name",text: $name)
                    TextField("Book Goal",value: $bookGoal,format: .number)
                } header: {
                    Text("Start Here")
                }
                
                Section{
                    TextField("Email", text: $email)
                    SecureField("Password",text: $password)
                } header: {
                    Text("Important Info")
                }
                
                
            }
            HStack{
                Button {
                    model.createUser(email: email, password: password,user: User(id: name, name: name, bookGoal: bookGoal,email: email))
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

