//
//  MealEndPoint.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

enum MealEndPoint: APIEndPoint {
    
    case lookup(mealId: String)
    
    var path: String {
        switch self {
        case .lookup(mealId: let mealId):
            "/lookup.php?i=\(mealId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .lookup(_):
            .get
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var header: [String : String]? {
        return nil
    }
    
}
