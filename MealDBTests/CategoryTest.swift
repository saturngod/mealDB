//
//  MealDBTests.swift
//  MealDBTests
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import XCTest
@testable import MealDB

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
