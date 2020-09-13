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
    
    @State var price:Double = 0.0
    @State var volumn:Int = 0
    @State var commissionDiscount = ""
    var disCountDict: [String: Double] = ["沒折扣":1, "95折":0.95, "9折":0.9, "85折":0.85, "8折":0.8, "75折":0.75, "7折":0.7, "65折":0.65, "6折":0.6, "55折":0.55, "5折":0.5, "45折":0.45, "4折":0.4, "35折":0.35, "3折":0.3, "25折":0.25, "2折":0.2, "15折":0.15, "1折":0.1, "0.5折":0.5, "免手續費":0]
    var disCounts = ["沒折扣", "95折", "9折", "85折", "8折", "75折", "7折", "65折", "6折", "55折", "5折", "45折", "4折", "35折", "3折", "25折", "2折", "15折", "1折", "0.5折", "免手續費"]
    @State var selectedDiscountIndex = 0
    @State var showResultDetail = false
    var buyCommission: Int = 0
    var sellCommission: Int = 0
    mutating func calculateBuyCommission() {
        let disKey = self.disCounts[self.selectedDiscountIndex]
        let disNumber = self.disCountDict[disKey]
        let v1 = self.price*Double(self.volumn)
        let v2 = v1*disNumber!
        let v3 = v2*0.001425
        var v4 = v1 + v3
//        var v5: Int = v4.round()
//        self.buyCommission = v5
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("買入&賣出金額試算 ")) {
                    Text("請輸入買或賣的個股成交價")
                    TextField("請輸入成交價", value: $price, formatter: NumberFormatter())
                        .foregroundColor(.blue)
                    Text("輸入購買股數(一張為1000股)")
                    TextField("請輸入股數", value: $volumn, formatter: NumberFormatter())
                        .foregroundColor(.blue)
                    Text("選取券商手續費折扣")
                    
                    Picker(selection: $selectedDiscountIndex, label: Text("請選擇折數")) {
                        ForEach(0 ..< disCounts.count) {
                            Text(self.disCounts[$0]).tag($0)
                                .foregroundColor(.blue)
                        }
                    }.pickerStyle(DefaultPickerStyle())

                    Button(action: {
                        self.showResultDetail.toggle()
                    }) {
                        Text("計算")
                    }
                    .padding(.leading, UIScreen.main.bounds.size.width/2-40)

                    if showResultDetail {
                        calculateBuyCommission()
                        Text("買入需券商手續費 \(self.buyCommission)")
                    }

                }
            }
            .navigationBarTitle("股票機算機")
        }
    }


}

//struct ResultDetailText: View {
//    var buyCommission: Int = 0
//    var sellCommission: Int = 0
//
//
//    var body: some View {
//        calculateBuyCommission()
//        Text("買入需券商手續費 \(buyCommission)")
//    }
//    func calculateBuyCommission() {
//        var disKey = self.disCounts[self.selectedDiscountIndex]
//        var disNumber = self.disCountDict[disKey]
//        var buyResult = self.price*self.volumn + (self.price*self.volumn*disNumber*0.001425)
//        self.buyCommission = Int(buyResult.round())
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


