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
                HStack(spacing:20){
                    Button {
                        model.signInCondition = .signIn
                    } label: {
                        Text("Sign In")
                    }
                    .buttonStyle(.borderedProminent)
                    Button {
                        model.signInCondition = .signUp
                        print("Sign Up")
                    } label: {
                        Text("Sign Up")
                    }
                    .buttonStyle(.borderedProminent)
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
