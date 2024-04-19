//
//  MealRepoImpl.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation



class MealRepoImpl: MealRepo, BaseRepo {
    var apiService: APIService
    
    init(apiService: APIService = APIService.shared) {
        self.apiService = apiService
    }
    
    func lookup(mealId: String) async -> Result<MealDetail,Error> {
        let result: Result<MealDetaiInfo, Error> = await self.apiService.request(endPoint: MealEndPoint.lookup(mealId: mealId))
        
        switch result {
        case .success(let info):
            if let meal = info.meals.first {
                return .success(meal)
            }
            else {
                return .failure(MealError.notFound)
            }
        case .failure(let error):
            return .failure(error)
        }

    }
    
    
}
