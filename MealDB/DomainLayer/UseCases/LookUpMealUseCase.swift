//
//  LookUpMeal.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol LookUpMealUseCaseProtocol {
    var repo: MealRepo { get }
    func exec(mealId: String) async -> Result<MealDetail,Error>
}

struct LookUpMealUseCase: LookUpMealUseCaseProtocol {
    var repo: any MealRepo
    
    init(repo: MealRepo = MealRepoImpl()) {
        self.repo = repo
    }
    
    func exec(mealId: String) async -> Result<MealDetail,Error> {
        return await repo.lookup(mealId: mealId)
    }
}
