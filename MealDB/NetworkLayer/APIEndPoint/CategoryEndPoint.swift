//
//  CategoryEndPoint.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

enum CategoryEndPoint: APIEndPoint {

    case list(name: String)
    
    
    var path: String {
        switch self {
        case .list(name: let name):
            "/filter.php?c=\(name)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list(_):
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
