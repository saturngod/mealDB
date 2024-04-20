//
//  DessertViewModelTest.swift
//  MealDBTests
//
//  Created by Htain Lin Shwe on 20/04/2024.
//

import XCTest

class MockDessertUseCase: FetchDessertMealListUseCaseProtocol {
    var repo: any CategoryRepo
    var result: Result<[Meal], Error>?
    
    init(repo: any CategoryRepo = CategoryRepoImpl()) {
        self.repo = repo
    }
    
    func exec() async -> Result<[Meal], Error> {
        return result ?? .failure(NSError(domain: "No result set", code: 0, userInfo: nil))
    }
}

final class DessertViewModelTest: XCTestCase {
    
    @MainActor
    func testLoadMealsSuccess() async {
        let mockUseCase = MockDessertUseCase()
        let viewModel = DessertViewModel(useCase: mockUseCase)
        let meals = [Meal(strMeal: "Chocolate Cake", strMealThumb: "", idMeal: ""),Meal(strMeal: "Pie", strMealThumb: "", idMeal: "")]
        mockUseCase.result = .success(meals)
        
        await viewModel.loadMeals()
        
        XCTAssertEqual(viewModel.meals, meals, "The meals array should match the mock data.")
        
    }
    @MainActor
    func testLoadMealsFailure() async {
        let mockUseCase = MockDessertUseCase()
        let viewModel = DessertViewModel(useCase: mockUseCase)
        let error = NSError(domain: "TestError", code: -1, userInfo: nil)
        mockUseCase.result = .failure(error)
        
        await viewModel.loadMeals()
        
        XCTAssertTrue(viewModel.meals.isEmpty, "The meals array should be empty on fetch failure.")
        if case .error(let err as NSError) = viewModel.viewState, err.domain == "TestError" && err.code == -1 {
            // Test passes for this case
        } else {
            XCTFail("ViewState should be .error with the correct error information.")
        }
    }
    @MainActor
    func testFilteredMeals() {
        let viewModel = DessertViewModel(useCase: MockDessertUseCase())
        let meals = [Meal(strMeal: "Chocolate Cake", strMealThumb: "", idMeal: ""),Meal(strMeal: "Apple Pie", strMealThumb: "", idMeal: "")]
        viewModel.meals = meals
        viewModel.actualSearch = "apple"
        
        let filtered = viewModel.filteredMeals
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.strMeal, "Apple Pie", "The filtered meals should contain only 'Apple Pie'.")
    }
    
    
}
