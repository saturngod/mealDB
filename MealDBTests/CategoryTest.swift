//
//  MealDBTests.swift
//  MealDBTests
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import XCTest
@testable import MealDB

class MockCategoryRepoImpl: CategoryRepo {
    func getMealListFromCategory(name: String) async -> Result<[Meal], any Error> {
        let meals = [
            Meal(strMeal: "c", strMealThumb: "", idMeal: ""),
            Meal(strMeal: "d", strMealThumb: "", idMeal: ""),
            Meal(strMeal: "a", strMealThumb: "", idMeal: ""),
            Meal(strMeal: "b", strMealThumb: "", idMeal: ""),
        ]
        return .success(meals)
    }
    
}

final class CategoryTest: XCTestCase {
    
    func testMealsList() async throws {
        let useCase = FetchDessertMealListUseCase()
        let result = await useCase.exec()
        switch result {
        case .success(let data):
            XCTAssertGreaterThan(data.count, 0)
            break
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
    }
    
    func testMealsListSorted() async throws {
        let useCase = FetchDessertMealListUseCase(repo: MockCategoryRepoImpl())
        let result = await useCase.exec()
        switch result {
        case .success(let data):
            let sorted = ["a","b","c","d"]
            for i in 0..<data.count {
                if sorted[i] != data[i].strMeal {
                    XCTFail("Wrong sorted order")
                }
            }
            break
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
    }
    
    func testOtherCategory() async throws {
        let repo = CategoryRepoImpl()
        let result = await repo.getMealListFromCategory(name: "Dinner")
        
        switch result {
        case .success(let data):
            XCTAssertEqual(data.count, 0)
            break
        case .failure(let err):
            XCTAssertNotEqual(err.localizedDescription, "")
        }
        
    }
    
    
    
    
    
}
