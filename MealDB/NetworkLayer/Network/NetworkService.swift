//
//  NetworkService.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(url: URL, method: HTTPMethod, body: Data?, headers: [String: String]?) async throws -> T
}


class NetworkServiceImpl: NetworkService {
    

    func request<T: Decodable>(url: URL, method: HTTPMethod, body: Data? = nil, headers: [String: String]? = nil) async throws -> T {

        let request = createRequest(url: url, method: method, body: body, headers: headers)
        let data = try await performRequest(request: request)
        return try decodeResponse(data: data)
        
    }
    
    
    private func createRequest(url: URL, method: HTTPMethod, body: Data?, headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
   
    private func performRequest(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
