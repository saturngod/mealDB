//
//  MealDetailModelTest.swift
//  MealDBTests
//
//  Created by Htain Lin Shwe on 20/04/2024.
//

import XCTest

final class MealDetailModelTest: XCTestCase {
    
    @MainActor
    func testLoadDetailSuccess() async {
        let mockUseCase = MockLookUpMealUseCase()
        let viewModel = MealDetailViewModel(lookUpMealUseCase: mockUseCase)
        let mealId = "123"
        
        mockUseCase.result = .success(MealDetail(idMeal: "123", strMeal: "Test", strArea: "", strInstructions: "Instruction", strMealThumb: "", strIngredient1: "ing1", strIngredient2: "ing2", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "1 measure", strMeasure2: "2 measure", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: ""))
        
        await viewModel.loadDetail(mealId: mealId)
        
        XCTAssertNotNil(viewModel.mealDetail)
        switch viewModel.viewState {
        case .idle:
            XCTAssert(true)
        case .error(let error):
            XCTFail(error.localizedDescription)
        case .loading:
            XCTFail("Shouldn't loading anymore")
        }
        XCTAssertFalse(viewModel.ingredientsArray.isEmpty) // Adjust this based on what you expect
    }
    @MainActor
    func testLoadDetailFailure() async {
        let mockUseCase = MockLookUpMealUseCase()
        let viewModel = MealDetailViewModel(lookUpMealUseCase: mockUseCase)
        let mealId = "123"
        
        mockUseCase.result = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        await viewModel.loadDetail(mealId: mealId)
        
        XCTAssertNil(viewModel.mealDetail)
        
        if case .error(let err as NSError) = viewModel.viewState, err.domain == "TestError" && err.code == -1 {
            // Test passes for this case
        } else {
            XCTFail("ViewState should be .error with the correct error information.")
        }
        
    }
    
}

class MockLookUpMealUseCase: LookUpMealUseCaseProtocol {
    
    var repo: any MealRepo
    var result: Result<MealDetail, Error>?
    
    init(repo: any MealRepo = MealRepoImpl()) {
        self.repo = repo
    }
    
    func exec(mealId: String) async -> Result<MealDetail, Error> {
        return result ?? .failure(NSError(domain: "Test", code: 0, userInfo: nil))
    }
}
