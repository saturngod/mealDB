//
//  MealView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI
import Kingfisher

struct MealViewCell: View {
    
    let meal: Meal
    var body: some View {
        HStack {
            if let mealThumb = meal.strMealThumb, let url = URL(string: mealThumb) {
                KFImage(url)
                    .placeholder({ _ in
                        Color(.lightGray)
                    })
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(.trailing, 8)
            }
            else {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 22)
            }
            
            Text(meal.strMeal ?? "N/A")
            Spacer()
            
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    MealViewCell(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049"))
}
