//
//  FetchDessertMealList.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol FetchDessertMealListUseCaseProtocol {
    var repo : CategoryRepo { get }
    func exec() async -> Result<[Meal],Error>
}

class FetchDessertMealListUseCase: FetchDessertMealListUseCaseProtocol {
    var repo: CategoryRepo
    
    init(repo: CategoryRepo = CategoryRepoImpl()) {
        self.repo = repo
    }
    
    func exec() async -> Result<[Meal],Error> {
        let result =  await repo.getMealListFromCategory(name: "Dessert")
        
        switch result {
        case .success(let meals):
            return .success(meals.sorted { $0.strMeal ?? "" < $1.strMeal ?? ""})
        case .failure(let error):
            return .failure(error)
        }
    }
}
