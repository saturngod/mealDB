//
//  APIEndPoint.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol APIEndPoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? {get}
    var header: [String: String]? { get }
}
