//
//  ContentView.swift
//  stock_calculator
//
//  Created by simon.chang on 2020/9/11.
//  Copyright © 2020 simon.chang. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var price = ""
    @State private var volumn = ""
    @State private var commissionDiscount = ""
    var disCountDict: [String: Double] = ["沒折扣":1, "95折":0.95, "9折":0.9, "85折":0.85, "8折":0.8, "75折":0.75, "7折":0.7, "65折":0.65, "6折":0.6, "55折":0.55, "5折":0.5, "45折":0.45, "4折":0.4, "35折":0.35, "3折":0.3, "25折":0.25, "2折":0.2, "15折":0.15, "1折":0.1, "0.5折":0.5, "免手續費":0]
    var disCounts = ["沒折扣", "95折", "9折", "85折", "8折", "75折", "7折", "65折", "6折", "55折", "5折", "45折", "4折", "35折", "3折", "25折", "2折", "15折", "1折", "0.5折", "免手續費"]
    @State private var selectedDiscountIndex = 0
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("買入&賣出金額試算 ")) {
                    Text("請輸入買或賣的個股成交價")
                    TextField("請輸入成交價", value: $price, formatter: NumberFormatter())
                    Text("輸入購買股數(一張為1000股)")
                    TextField("請輸入股數", value: $volumn, formatter: NumberFormatter())
                    Text("選取券商手續費折扣")
                    
                    Picker(selection: $selectedDiscountIndex, label: Text("請選擇折數")) {
                       ForEach(0 ..< disCounts.count) {
                           Text(self.disCounts[$0]).tag($0)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                
                    Button(action: {
                        ResultView()
                    }) {
                        Text("計算")
                    }
                    .padding(.leading, UIScreen.main.bounds.size.width/2-40)
                
                }
            }
            .navigationBarTitle("股票機算機")
            
        }
    }
    
    func showResult() {
       
    }
}

struct ResultView: View {
    var body: some View {
        Section(header: Text("計算結果 ")) {
            Text("請輸入買或賣的個股成交價")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct RightPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        RightPersonView()
//    }
//}
