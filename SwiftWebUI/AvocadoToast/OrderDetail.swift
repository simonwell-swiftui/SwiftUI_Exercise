//
//  OrderDetail.swift
//  AvocadoToast
//
//  Created by simon.chang on 2022/1/18.
//

import SwiftWebUI

struct OrderDetail: View {
  let order : CompletedOrder

  var body: some View {
    VStack {
      Text(order.summary).font(.title)

      VStack(alignment: .leading) {
        Text(order.purchaseDate)
      
        HStack {
          if order.includeSalt {
            SaltIcon()
          }
          else {}
          if order.includeRedPepperFlakes {
            RedPepperFlakesIcon()
          }
          else {}
        }
        
        Spacer()
        
        Image.unsplash(size  : UXSize(width: 480, height: 320),
                       terms : order.summary
                               .components(separatedBy: " ")
                               .filter { $0 != "with" })
      }
    }
  }
}
