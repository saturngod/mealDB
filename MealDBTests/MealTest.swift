//
//  MealTest.swift
//  MealDBTests
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import XCTest

final class MealTest: XCTestCase {

    func testMealDetail() async throws {
        let useCase = LookUpMealUseCase()
        let result = await useCase.exec(mealId: "52768")
        switch result {
        case .success(let meal):
            XCTAssertNotNil(meal.idMeal)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testMealEmpty() async throws {
        let useCase = LookUpMealUseCase()
        let result = await useCase.exec(mealId: "")
        switch result {
        case .success(let meal):
            XCTAssertNil(meal)
        case .failure(let error):
            XCTAssertNotEqual(error.localizedDescription, "")
        }
    }

}
