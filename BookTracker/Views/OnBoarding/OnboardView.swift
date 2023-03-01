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
    
    @State var showLoginView = false
    @State var showSignupView = false
    
    @State var loginViewPresentationDetent = PresentationDetent.medium
    @State var signupViewPresentationDetent = PresentationDetent.medium
    
    let tabPic = ["test1","test2","test3"]
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Primary")
                    .ignoresSafeArea()
                if model.signInCondition == .inApp{
                    MainTabView()
                }
                else if model.signInCondition == .main{
                    VStack{
                        Text("Home Library Tracker")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top,50)
                        TabView {
                            ForEach(tabPic,id: \.self){item in
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.black)
                                    Image(item).resizable()
                                    
                                }
                                .frame(width:350,height: 500)
                                .cornerRadius(20)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                
                            }
                        }
                        .tabViewStyle(.page)
                        HStack(spacing:20){
                            Button {
                                showLoginView.toggle()
                            } label: {
                                Text("Sign In")
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            .tint(Color.white)
                            .buttonStyle(.borderedProminent)
                            .sheet(isPresented: $showLoginView) {
                                SignIn(signInStatus: $showLoginView)
                                    .presentationDetents([.medium], selection: $loginViewPresentationDetent)
                            }
                            
                            Button {
                                showSignupView.toggle()
                            } label: {
                                Text("Sign Up")
                                    .foregroundColor(.black)
                            }
                            .tint(Color.white)
                            .buttonStyle(.borderedProminent)
                            .sheet(isPresented: $showSignupView) {
                                SignUp(signUpStatus: $showSignupView)
                                    .presentationDetents([.medium,.large], selection: $signupViewPresentationDetent)
                            }
                        }
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
