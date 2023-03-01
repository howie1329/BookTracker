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
            ZStack{
                Color("Third")
                    .ignoresSafeArea()
                VStack{
                    Form{
                        Section{
                            TextField("Email", text: $email)
                        } header: {
                            Text("Email")
                                .foregroundColor(.white)
                        }
                        
                        Section{
                            TextField("Password",text: $password)
                        } header: {
                            Text("Password")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    HStack{
                        Spacer()
                        
                        Button {
                            model.signInUser(email: email, password: password)
                        } label: {
                            Text("Sign In")
                                .foregroundColor(Color("Third"))
                                .frame(width:100)
                        }
                        .tint(.white)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                    }
                }
                .toolbar{
                    HStack(spacing:120){
                        Text("Sign In")
                            .foregroundColor(.white)
                        Button {
                            model.signInCondition = .main
                            signInStatus = false
                        } label: {
                            Image(systemName: "x.circle")
                                .tint(.white)
                        }
                    }
                    
                }
            }
        }
    }
}


