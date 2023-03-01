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
            ZStack{
                Color("Third")
                    .ignoresSafeArea()
                VStack(spacing:50){
                    Text("Stats")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Grid(horizontalSpacing:10,verticalSpacing: 20){
                        GridRow{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("Goals")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.currentRead) / \(model.goal)")
                                        .foregroundColor(.white)
                                }
                                
                            }
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("In Progress")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.progressBook)")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        
                        GridRow{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("Need To Read")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.wantBook)")
                                        .foregroundColor(.white)
                                }
                            }
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("Pages Collected")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.totalPagesCollected)")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        GridRow{
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("Not Started")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.notStartedBook)")
                                        .foregroundColor(.white)
                                }
                            }
                            ZStack{
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 170,height: 150)
                                    .foregroundColor(Color("Primary"))
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5,y: 5)
                                VStack(spacing:15){
                                    Text("Avg. Rating")
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("\(model.avgBookRating)")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    HStack(spacing:70){
                        Text("\(model.currentUserName)'s Profile")
                            .foregroundColor(.white)
                            .bold()
                        Button {
                            model.signOutUser()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.white)
                        }
                    }
                    
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
