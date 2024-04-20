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
    @Published var actualSearch: String = ""
    
    private var useCase: FetchDessertMealListUseCaseProtocol
    private var delay: Delay = Delay()
    
    init(useCase: FetchDessertMealListUseCaseProtocol = FetchDessertMealListUseCase()) {
        self.useCase = useCase
    }
    
    var search: String = "" {
        didSet {
            delay.cancel()
            delay.performWork { [weak self] in
                DispatchQueue.main.async {
                    self?.actualSearch = self?.search ?? ""
                }
            }
        }
    }
    
    var filteredMeals: [Meal] {
        if actualSearch.isEmpty {
            return meals
        } else {
            return meals.filter { meal in
                meal.strMeal?.localizedCaseInsensitiveContains(actualSearch) ?? false
            }
        }
    }
    
    func loadMeals() async {
        self.viewState = .loading
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
