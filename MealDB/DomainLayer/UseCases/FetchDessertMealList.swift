//
//  FetchDessertMealList.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

class FetchDessertMealList {
    private let repo: CategoryRepo
    
    init(repo: CategoryRepo = CategoryRepoImpl()) {
        self.repo = repo
    }
    
    func exec() async -> Result<[Meal],Error> {
        return await repo.getMealListFromCategory(name: "Dessert")
    }
}
