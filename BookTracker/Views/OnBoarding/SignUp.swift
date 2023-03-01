//
//  SignUp.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/26/23.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var model:BookModel
    
    @Binding var signUpStatus: Bool
    
    @State var email:String = ""
    @State var password:String = ""
    @State var name:String = ""
    @State var bookGoal:Int = 0
    var body: some View {
        NavigationView{
            ZStack{
                Color("Third")
                    .ignoresSafeArea()
                VStack{
                    Form{
                        Section{
                            TextField("First Name",text: $name)
                        } header: {
                            Text("Start Here")
                        }
                        
                        Section{
                            TextField("Book Goal",value: $bookGoal,format: .number)
                        } header: {
                            Text("Book Goal")
                        }
                        
                        Section{
                            TextField("Email", text: $email)
                            TextField("Password",text: $password)
                        } header: {
                            Text("Important Info")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    HStack{
                        Spacer()
                        Button {
                            model.createUser(email: email, password: password,user: User(id: name, name: name, bookGoal: bookGoal,email: email))
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(Color("Third"))
                        }.buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                    }
                }
                .toolbar{
                    Button {
                        model.signInCondition = .main
                        signUpStatus = false
                    } label: {
                        Image(systemName: "x.circle")
                            .tint(Color("Third"))
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Sign Up")
                .foregroundColor(.white)
            }
        }
    }
}

