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
    @Binding var signInStatus:Bool
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        TextField("Email", text: $email)
                        TextField("Password",text: $password)
                    } header: {
                        Text("Start Here")
                    }
                    
                }
                HStack{
                    Spacer()
                    
                    Button {
                        model.signInUser(email: email, password: password)
                    } label: {
                        Text("Sign In")
                    }.buttonStyle(.borderedProminent)
                    
                   Spacer()
                }
            }
            .toolbar{
                Button {
                    model.signInCondition = .main
                    signInStatus = false
                } label: {
                    Image(systemName: "x.circle")
                        .tint(.gray)
                }

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Sign In")
            
        }
    }
}


