//
//  MealDetailViewModel.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    
    @Published var mealDetail: MealDetail?
    @Published var viewState: ViewState = .idle
    @Published var ingredientsArray: [Measurement] = []
    
    private let lookUpMealUseCase: LookUpMealUseCaseProtocol
    
    init(lookUpMealUseCase: LookUpMealUseCaseProtocol = LookUpMealUseCase()) {
        self.lookUpMealUseCase = lookUpMealUseCase
    }
    
    func loadDetail(mealId: String) async {
        viewState = .loading
        
        let result = await lookUpMealUseCase.exec(mealId: mealId)
        switch result {
        case .success(let detail):
            self.ingredientsArray = generateIngredient(mealDetail: detail)
            self.mealDetail = detail
            viewState = .idle
        case .failure(let error):
            viewState = .error(error: error)
        }
    }
    
    private func generateIngredient(mealDetail: MealDetail) -> [Measurement] {
        var result = [Measurement]()
        let mirror = Mirror(reflecting: mealDetail)
        for case let (label?, value) in mirror.children {
            if label.starts(with: "strIngredient"), let ingredient = value as? String, !ingredient.isEmpty {
                let index = label.dropFirst("strIngredient".count)
                if let measure = mirror.descendant("strMeasure\(index)") as? String {
                    result.append(Measurement(ingredient: ingredient, measurement: measure))
                }
            }
        }
        return result
    }
    
}
