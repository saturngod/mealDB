//
//  Meal.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

struct Meals: Decodable {
    var meals: [Meal]
}

struct Meal: Decodable, Equatable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String
}
