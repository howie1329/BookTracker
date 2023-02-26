//
//  ProfileView.swift
//  BookTracker
//
//  Created by Howard Thomas on 2/24/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var model:BookModel
    var body: some View {
        NavigationView{
            VStack(){
                Text("Stats")
                    .font(.title)
                HStack(alignment: .top){
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 150,height: 150)
                            .foregroundColor(.gray)
                        VStack(spacing:15){
                            Text("Goals")
                                .bold()
                            Text("\(model.currentRead) / \(model.goal)")
                        }
                        
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 150,height: 150)
                            .foregroundColor(.gray)
                        VStack(spacing:15){
                            Text("In Progress")
                                .bold()
                            Text("\(model.progressBook)")
                        }
                    }
                    
                    }
                HStack{
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 150,height: 150)
                            .foregroundColor(.gray)
                        VStack(spacing:15){
                            Text("Not Started")
                                .bold()
                            Text("\(model.notStartedBook)")
                        }
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 150,height: 150)
                            .foregroundColor(.gray)
                        VStack(spacing:15){
                            Text("Need To Read")
                                .bold()
                            Text("\(model.wantBook)")
                        }
                    }
                }
                
                Button {
                    print("Sign out")
                } label: {
                    Text("Sign Out")
                }
                .buttonStyle(.borderedProminent)
                

            }
            .padding()
            .navigationTitle("Profile View")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(BookModel())
    }
}
