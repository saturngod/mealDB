//
//  CategoryRepoImpl.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

class CategoryRepoImpl: CategoryRepo, BaseRepo {

    var apiService: APIService
    
    init(apiService: APIService = APIService.shared) {
        self.apiService = apiService
    }
    
    
    func getMealListFromCategory(name: String) async -> Result<[Meal],Error> {
        let result: Result<Meals,Error> = await self.apiService.request(endPoint: CategoryEndPoint.list(name: name))
        
        switch result {
        case .success(let resp):
            return .success(resp.meals)
        case .failure(let err):
            return .failure(err)
        }
    }
    
}
