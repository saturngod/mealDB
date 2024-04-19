//
//  MealRepo.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol MealRepo {
    func lookup(mealId: String) async -> Result<MealDetail,Error>
}
