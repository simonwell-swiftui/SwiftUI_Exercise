//
//  SemanticUIView1.swift
//  AvocadoToast
//
//  Created by simon.chang on 2022/1/18.
//

import SwiftWebUI

struct SemanticUIView1: View {
    
    var body: some View {
        VStack {
            SUICards {
              SUICard(Image.unsplash(size: UXSize(width: 200, height: 200),
                                     "Zebra", "Animal"),
                      Text("Some Zebra"),
                      meta: Text("Roaming the world since 1976"))
              {
                Text("A striped animal.")
              }
              SUICard(Image.unsplash(size: UXSize(width: 200, height: 200),
                                     "Cow", "Animal"),
                      Text("Some Cow"),
                      meta: Text("Milk it"))
              {
                Text("Holy cow!.")
              }
            }
        }
    }
}
