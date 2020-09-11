//
//  ContentView.swift
//  SwiftUI_Button
//
//  Created by simon.chang on 2020/9/10.
//  Copyright © 2020 simon.chang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
//            Button(action: {
//                print("AAA Tapped!")
//            }) {
//                Text("AAA")
//                    .background(Color.purple)
//                    .foregroundColor(.white)
//                    .font(.title)
//            }
//
//            Button(action: {
//                print("BBB Tapped!")
//            }) {
//                Text("BBB")
//                    .padding()
//                    .background(Color.purple)
//                    .foregroundColor(.white)
//                    .font(.title)
//            }
            
            Button(action: {
                print("CCC Tapped!")
            }) {
                Text("CCC")
                    .foregroundColor(.purple)
                    .font(.title)
                    .padding()
                    .border(Color.purple, width: 5)
            }
            
            Button(action: {
                print("DDD Tapped!")
            }) {
                Text("DDD")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .padding(10)
                    .border(Color.purple, width: 5)
            }
            
            Button(action: {
                print("EEE Tapped!")
            }) {
                Text("EEE")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.purple, lineWidth: 5)
                )
                
            }
            
            Button(action: {
                print("FFF Tapped!")
            }) {
                Image(systemName: "trash")
                    .font(.largeTitle)
                    .foregroundColor(Color.red)
                
            }
            
            Button(action: {
                print("GGG Tapped!")
                   
            }) {
                Image(systemName: "plus")
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .font(.largeTitle)
                .foregroundColor(Color.white)
                
                
            }
            
            Button(action: {
                print("HHH Tapped!")
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.red)
            .cornerRadius(40)
            
            Button(action: {
                print("III Tapped!")
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            
            Button(action: {
                print("Share tapped!")
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    Text("Share")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())

            Button(action: {
                print("Edit tapped!")
            }) {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                    Text("Edit")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())

            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
            .buttonStyle(GradientBackgroundStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GradientBackgroundStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
