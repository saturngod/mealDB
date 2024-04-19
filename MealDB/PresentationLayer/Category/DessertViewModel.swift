//
//  DessertViewModel.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

@MainActor
class DessertViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var viewState: ViewState = .idle
    
    
    func loadMeals() async {
        self.viewState = .loading
        let useCase = FetchDessertMealList()
        let result = await useCase.exec()
        self.handleMealsResult(result: result)
    }
    
    private func handleMealsResult(result: Result<[Meal],Error>) {
        switch result {
        case .success(let meals):
            self.meals = meals
            self.viewState = .idle
            break
        case .failure(let err):
            self.viewState = .error(error: err)
        }
    }
    
    
}
