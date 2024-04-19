//
//  MealError.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

enum MealError : Error {
    case notFound
}

extension MealError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("The requested meal was not found.", comment: "Meal not found error")
        }
    }
}
