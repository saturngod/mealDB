//
//  APIService.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

class APIService {
    
    public static let shared = APIService()
    
    private let baseURL = "https://themealdb.com/api/json/v1/1"
    private let network: NetworkService
    
    private init(network: NetworkService = NetworkServiceImpl()) {
        self.network = network
    }
    
    func request<T:Decodable>(endPoint: APIEndPoint) async -> Result<T,Error> {
        guard let url = URL(string: "\(baseURL)\(endPoint.path)") else { return .failure(URLError(.badURL)) }
        
        do {
            let result: T = try await network.request(url: url, method: endPoint.method,body: endPoint.body ,headers: endPoint.header)
            return .success(result)
        }
        catch {
            return .failure(error)
        }
    }
}
