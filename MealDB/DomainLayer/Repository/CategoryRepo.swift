//
//  CategoryRepo.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol CategoryRepo {
    func getMealListFromCategory(name: String) async -> Result<[Meal],Error> 
}
