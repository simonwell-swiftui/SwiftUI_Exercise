//
//  MainPage.swift
//  AvocadoToast
//
//  Created by simon.chang on 2022/1/18.
//

import SwiftWebUI

struct MainPage: View {
  
  var body: some View {
    TabView {
      
      OrderPage()
        .tabItem(Text("Order"))
      
      OrderHistory(previousOrders: previousOrders)
        .tabItem(Text("History"))
    }
    .padding()
    .relativeWidth(0.95)
    .relativeHeight(0.95)
  }
}
