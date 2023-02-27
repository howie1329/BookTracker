//
//  OnboardView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/26/23.
//

import SwiftUI

struct OnboardView: View {
    @EnvironmentObject var model:BookModel
    @State var email:String = ""
    @State var password:String = ""
    
    let tabPic = ["test1","test2","test3"]
    
    var body: some View {
        NavigationView {
            if model.signInCondition == .signIn{
                SignIn()
            }
            else if model.signInCondition == .signUp{
                SignUp()
            }
            else if model.signInCondition == .inApp{
                MainTabView()
            }
            else{
                VStack{
                    Text("Home Library Tracker")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top,50)
                    TabView {
                        ForEach(tabPic,id: \.self){item in
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.gray)
                                VStack{
                                    Text(item)
                                }
                                
                            }
                            .frame(width:350,height: 500)
                            .cornerRadius(20)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                            
                        }
                    }
                    .tabViewStyle(.page)
                    HStack(spacing:20){
                        Button {
                            model.signInCondition = .signIn
                        } label: {
                            Text("Sign In")
                                .frame(width: 100)
                        }
                        .buttonStyle(.borderedProminent)
                        Button {
                            model.signInCondition = .signUp
                            print("Sign Up")
                        } label: {
                            Text("Sign Up")
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
            .environmentObject(BookModel())
    }
}
