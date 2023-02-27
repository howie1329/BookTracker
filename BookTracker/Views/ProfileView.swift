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
            VStack{
                Grid(horizontalSpacing:10,verticalSpacing: 20){
                    Text("Stats")
                        .font(.title)
                    GridRow{
                        ZStack{
                            Rectangle()
                                .cornerRadius(20)
                                .frame(width: 170,height: 150)
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
                                .frame(width: 170,height: 150)
                                .foregroundColor(.gray)
                            VStack(spacing:15){
                                Text("In Progress")
                                    .bold()
                                Text("\(model.progressBook)")
                            }
                        }
                        
                    }
                    GridRow{
                        ZStack{
                            Rectangle()
                                .cornerRadius(20)
                                .frame(width: 170,height: 150)
                                .foregroundColor(.gray)
                            VStack(spacing:15){
                                Text("Need To Read")
                                    .bold()
                                Text("\(model.wantBook)")
                            }
                        }
                        ZStack{
                            Rectangle()
                                .cornerRadius(20)
                                .frame(width: 170,height: 150)
                                .foregroundColor(.gray)
                            VStack(spacing:15){
                                Text("Pages Collected")
                                    .bold()
                                Text("\(model.totalPagesCollected)")
                            }
                        }
                    }
                    GridRow{
                        ZStack{
                            Rectangle()
                                .cornerRadius(20)
                                .frame(width: 170,height: 150)
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
                                .frame(width: 170,height: 150)
                                .foregroundColor(.gray)
                            VStack(spacing:15){
                                Text("Avg. Rating")
                                    .bold()
                                Text("\(model.avgBookRating)")
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(model.currentUserName)'s Profile")
            .toolbar {
                Button {
                    model.signOutUser()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.black)
                }

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(BookModel())
    }
}
