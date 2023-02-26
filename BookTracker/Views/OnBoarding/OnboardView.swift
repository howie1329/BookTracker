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
    @State var showSignIn:Bool = false
    var body: some View {
        NavigationView {
            if showSignIn{
                SignIn(showSignIn: $showSignIn)
            }else{
                HStack(spacing:20){
                    Button {
                        showSignIn.toggle()
                        print("Sign In")
                    } label: {
                        Text("Sign In")
                    }
                    .buttonStyle(.borderedProminent)
                    Button {
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
    }
}
