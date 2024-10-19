//
//  Request.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation

protocol Request {
    
    var path: String { get }
    var httpMethod: String { get }
    var body: Data? { get }
    func makeURLRequest() throws -> URLRequest

}

extension Request {
    
    var httpMethod: String { "GET" }
    var headers: [String: String]? { Server.headers }
    var body: Data? { nil }


    func makeURLRequest() throws -> URLRequest {
        
        guard let baseUrl = Server.baseURL else {
            throw NetworkError.badURL
        }
            
        let url = baseUrl.appendingPathComponent(self.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod
        urlRequest.httpBody = self.body
        
        if let headers = self.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
        
    }
    
}
