//
//  MealView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI
import NukeUI

struct MealViewCell: View {
    
    let meal: Meal
    var body: some View {
        HStack {
            if let mealThumb = meal.strMealThumb, let url = URL(string: mealThumb) {
                LazyImage(url: url)
                    .processors([.resize(width:22)])
                    .padding(.trailing, 8)
            }
            else {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 22)
            }
            
            Text(meal.strMeal ?? "N/A")
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    MealViewCell(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049"))
}
