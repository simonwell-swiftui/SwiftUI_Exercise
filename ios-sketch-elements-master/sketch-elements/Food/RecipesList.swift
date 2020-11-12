//
//  RecipesList.swift
//  sketch-elements
//
//  Created by Filip Molcik on 29/02/2020.
//  Copyright © 2020 Filip Molcik. All rights reserved.
//

import SwiftUI

struct RecipesListView: View {
    
    var category: Category
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(userData.recipes) {recipe in
                NavigationLink(
                    destination: RecipeDetail(recipe: recipe, category: self.category.title)
                ) {
                    CardWithBackground(title: recipe.title, subTitle: nil, height: 160.0, pictureUrl: recipe.picture.uri, description: "\(recipe.people) people · \(recipe.minutes) minutes")
                }
            }
        }
        .navigationBarColor(UIColor(named: "BrandPrimary"))
        .background(Color("Gray"))
        .navigationBarTitle(Text(category.title), displayMode: .inline)
    }
}


struct RecipesList_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(category: recipeCategoriesData[0])
            .environmentObject(UserData())
            .environment(\.colorScheme, .light)
    }
}
