//
//  LookUpMeal.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

struct LookUpMealUseCase {
    private let repo: MealRepo
    
    init(repo: MealRepo = MealRepoImpl()) {
        self.repo = repo
    }
    
    func exec(mealId: String) async -> Result<MealDetail,Error> {
        return await repo.lookup(mealId: mealId)
    }
}
