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
    var body: some View {
        VStack {
            TabView {
                BuySellView()
                    .tabItem {
                        NavigationLink(destination: BuySellView()) {
                            Image(systemName: "square.and.pencil")
                            Text("買賣金額試算") }.tag(1)
                }
                ProfitLossView()
                    .tabItem {
                        NavigationLink(destination: ProfitLossView()) {
                            Image(systemName: "pencil.circle")
                            Text("損益獲利率試算") }.tag(2)
                }
            }
        }
    }
}

struct BuySellView: View {
    
    @State private var price = ""
    @State private var volumn = ""
    @State private var commissionDiscount = ""
    @State private var selectedDiscountIndex = 0
    @State private var showResultDetail = false
    
    var disCountDict: [String: Double] = ["沒折扣":1, "95折":0.95, "9折":0.9, "85折":0.85, "8折":0.8, "75折":0.75, "7折":0.7, "65折":0.65, "6折":0.6, "55折":0.55, "5折":0.5, "45折":0.45, "4折":0.4, "35折":0.35, "3折":0.3, "28折":0.28, "25折":0.25, "2折":0.2, "15折":0.15, "1折":0.1, "0.5折":0.05, "免手續費":0]
    var disCounts = ["沒折扣", "95折", "9折", "85折", "8折", "75折", "7折", "65折", "6折", "55折", "5折", "45折", "4折", "35折", "3折", "28折", "25折", "2折", "15折", "1折", "0.5折", "免手續費"]
    
    @State var commission = 0
    @State var stockTax = 0
    @State var buyPrice = 0
    @State var sellPrice = 0
    
    func calculateFee() {
        guard price != "", volumn != "" else {
            return
        }
        
        let disKey = self.disCounts[self.selectedDiscountIndex]
        let disNumber = self.disCountDict[disKey]
        let v1 = Double(self.price)! * Double(self.volumn)!
        let v2 = v1 * disNumber!
        
        //買和賣的手續費
        let v3 = round(v2 * 0.001425)
        if v3 <= 20 {
            commission = 20
        } else {
            commission = Int(v3)
        }
        //買價
        let v4 = round(v1 + v3)
        buyPrice = Int(v4)
        //賣價
        let s1 = v1 - Double(commission)
        //證交稅
        let s2 = round(v1 * 0.003)
        stockTax = Int(s2)
        let s3 = round(s1 - s2)
        sellPrice = Int(s3)
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("買入&賣出金額試算")) {
                    //買入或賣出資料
                    Text("請輸入買或賣的個股成交價")
                    TextField("請輸入成交價", text: $price)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.blue)
                    .modifier(ClearButton(text: $price))
                    
                    Text("請輸入購買股數(一張為1000股)")
                    TextField("請輸入股數", text: $volumn)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.blue)
                    .modifier(ClearButton(text: $volumn))
                    
                    Picker(selection: $selectedDiscountIndex, label: Text("選取券商手續費折扣")) {
                        ForEach(0 ..< disCounts.count) {
                            Text(self.disCounts[$0]).tag($0)
                                .foregroundColor(.blue)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                }
                
                Section(header: Text("計算結果"), footer: Text("※此計算的手續費以0.1425%,證交稅0.3%為基準")) {
                    //計算
                    Button(action: {
                        self.hideKeyboard()
                        self.showResultDetail.toggle()
                        self.calculateFee()
                    }) {
                        Text("計算")
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, UIScreen.main.bounds.size.width/2-40)
                    
                    if self.showResultDetail {
                        Text("買入或賣出需券商手續費 $\(self.commission)")
                            .foregroundColor(.red)
                        Text("賣出需證所稅費用 $\(self.stockTax)")
                            .foregroundColor(.red)
                        Text("買入價格 $\(self.buyPrice)")
                            .foregroundColor(.red)
                        Text("賣出價格 $\(self.sellPrice)")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("買入&賣出金額試算")
            .navigationBarItems(trailing:
                Button(action: {
                    self.price = ""
                    self.volumn = ""
                    self.commissionDiscount = ""
                    self.selectedDiscountIndex = 0
                    self.commission = 0
                    self.stockTax = 0
                    self.buyPrice = 0
                    self.sellPrice = 0
                    
                    if self.showResultDetail {
                        self.showResultDetail.toggle()
                    }
                }, label: {
                    Text("清空")
                    Image(systemName: "trash")
                })
            )
                .keyboardManagment()
        }
    }
}

struct ProfitLossView: View {
    @State private var bPrice = ""
    @State private var bVolumn = ""
    @State private var bCommissionDiscount = ""
    @State private var bIndex = 0
    
    @State private var sPrice = ""
    @State private var sVolumn = ""
    @State private var sCommissionDiscount = ""
    @State private var sIndex = 0
    
    @State private var showResultDetail = false
    
    var disCountDict: [String: Double] = ["沒折扣":1, "95折":0.95, "9折":0.9, "85折":0.85, "8折":0.8, "75折":0.75, "7折":0.7, "65折":0.65, "6折":0.6, "55折":0.55, "5折":0.5, "45折":0.45, "4折":0.4, "35折":0.35, "3折":0.3, "28折":0.28, "25折":0.25, "2折":0.2, "15折":0.15, "1折":0.1, "0.5折":0.05, "免手續費":0]
    var disCounts = ["沒折扣", "95折", "9折", "85折", "8折", "75折", "7折", "65折", "6折", "55折", "5折", "45折", "4折", "35折", "3折", "28折", "25折", "2折", "15折", "1折", "0.5折", "免手續費"]
    
    @State var bCommission = 0 //買入手續費
    @State var bPriceTotal = 0 //買入總付款
    
    @State var sCommission = 0 //賣出手續費
    @State var sPriceTotal = 0 //賣出總收款
    
    @State var stockTax = 0 //證所稅
    @State var profitLoss = 0 //獲利
    @State var profitLossMargin = "" //獲利率
    
    
    func calculateFee() {
        guard bPrice != "", bVolumn != "", sPrice != "", sVolumn != "" else {
            return
        }
        
        //買入
        let bKey = self.disCounts[self.bIndex]
        let bDisNumber = self.disCountDict[bKey]
        let b1 = Double(self.bPrice)! * Double(self.bVolumn)!
        let b2 = b1 * bDisNumber!
        
        //買入手續費
        let b3 = round(b2 * 0.001425)
        if b3 <= 20 {
            bCommission = 20
        } else {
            bCommission = Int(b3)
        }
        
        //買入總付款
        let b4 = round(b1 + b3)
        let b5 = Int(b4)
        bPriceTotal = b5
        
        //賣出
        let sKey = self.disCounts[self.sIndex]
        let sDisNumber = self.disCountDict[sKey]
        let s1 = Double(self.sPrice)! * Double(self.sVolumn)!
        let s2 = s1 * sDisNumber!
        
        //賣出手續費
        let s3 = round(s2 * 0.001425)
        if s3 <= 20 {
            sCommission = 20
        } else {
            sCommission = Int(s3)
        }
        
        //賣出總收款
        let s4 = s1-Double(sCommission)
        //證交稅
        let s5 = round(s1*0.003)
        stockTax = Int(s5)
        let s6 = round(s4-s5)
        let s7 = Int(s6)
        sPriceTotal = s7
        //獲利
        let s8 = s7-b5
        profitLoss = s8
        //獲利率 小/大 想要有小數點需要用CGFloat
        let s9 = CGFloat(s8)/CGFloat(b5)
        let s10 = s9*100
        profitLossMargin = String(format: "%.2f", s10)
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("買入試算")) {
                    Group {
                        //買入資料
                        Text("請輸入買入個股成交價")
                        TextField("請輸入成交價", text: $bPrice)
                            .keyboardType(.decimalPad)
                            .foregroundColor(.blue)
                        .modifier(ClearButton(text: $bPrice))
                        
                        Text("請輸入購買股數(一張為1000股)")
                        TextField("請輸入股數", text: $bVolumn)
                            .keyboardType(.decimalPad)
                            .foregroundColor(.blue)
                        .modifier(ClearButton(text: $bVolumn))
                        
                        Picker(selection: $bIndex, label: Text("選取券商手續費折扣")) {
                            ForEach(0 ..< disCounts.count) {
                                Text(self.disCounts[$0]).tag($0)
                                    .foregroundColor(.blue)
                            }
                        }.pickerStyle(DefaultPickerStyle())
                    }
                }
                
                Section(header: Text("賣出試算")) {
                    Group {
                        //賣出資料
                        Text("請輸入賣出個股成交價")
                        TextField("請輸入成交價", text: $sPrice)
                            .keyboardType(.decimalPad)
                            .foregroundColor(.blue)
                        .modifier(ClearButton(text: $sPrice))
                        
                        Text("請輸入購買股數(一張為1000股)")
                        TextField("請輸入股數", text: $sVolumn)
                            .keyboardType(.decimalPad)
                            .foregroundColor(.blue)
                        .modifier(ClearButton(text: $sVolumn))
                        
                        Picker(selection: $sIndex, label: Text("選取券商手續費折扣")) {
                            ForEach(0 ..< disCounts.count) {
                                Text(self.disCounts[$0]).tag($0)
                                    .foregroundColor(.blue)
                            }
                        }.pickerStyle(DefaultPickerStyle())
                    }
                }
                
                Section(header: Text("計算結果"), footer: Text("※此計算的手續費以0.1425%,證交稅0.3%為基準")) {
                    //計算
                    Button(action: {
                        self.hideKeyboard()
                        self.showResultDetail.toggle()
                        self.calculateFee()
                    }) {
                        Text("計算")
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, UIScreen.main.bounds.size.width/2-40)
                    
                    if self.showResultDetail {
                        Text("買入總付款 $\(self.bPriceTotal)")
                            .foregroundColor(.red)
                        Text("賣出總收款 $\(self.sPriceTotal)")
                            .foregroundColor(.red)
                        Text("獲利 $\(self.profitLoss)")
                            .foregroundColor(.red)
                        Text("獲利率 \(self.profitLossMargin)%")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("買賣損益獲利率試算")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.bPrice = ""
                        self.bVolumn = ""
                        self.bCommissionDiscount = ""
                        self.bIndex = 0
                        self.bPriceTotal = 0 //買入總付款
                        self.sPrice = ""
                        self.sVolumn = ""
                        self.sCommissionDiscount = ""
                        self.sIndex = 0
                        self.sPriceTotal = 0 //賣出總收款
                        self.stockTax = 0 //證所稅
                        self.profitLoss = 0 //獲利
                        self.profitLossMargin = "" //獲利率
                        
                        if self.showResultDetail {
                            self.showResultDetail.toggle()
                        }
                    }, label: {
                        Text("清空")
                        Image(systemName: "trash")
                    })
                )
            .keyboardManagment()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct KeyboardManagment: ViewModifier {
    @State private var offset: CGFloat = 0
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            self.offset = keyboardFrame.height - geo.safeAreaInsets.bottom
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                        withAnimation(Animation.easeOut(duration: 0.1)) {
                            self.offset = 0
                        }
                    }
            }
            .padding(.bottom, self.offset)
        }
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func keyboardManagment() -> some View {
        self.modifier(KeyboardManagment())
    }
}
#endif

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


