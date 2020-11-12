//
//  ContentView.swift
//  SwiftUI_Test
//
//  Created by simon.chang on 2020/10/27.
//

import SwiftUI

struct ContentView: View {
    
    func configureBackground() {
        let barAppearance = UINavigationBarAppearance()
//        barAppearance.backgroundColor = UIColor.red
        barAppearance.backgroundImage = UIImage(named: "speech-bubbles")
        UINavigationBar.appearance().standardAppearance = barAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
    }
    
    init() {
        configureBackground()
    }
    
    var body: some View {
        NavigationView {
            Image("kid")
                .resizable()
                //.scaledToFill()
                .frame(width: 300, height: 300, alignment: .center)
                //.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("emotions")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            Text("Peter")
                                .font(.title)
                        }
                        .offset(y: 30)
                    }
                })
            //                .navigationTitle("Agatha Christie")
            //                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
