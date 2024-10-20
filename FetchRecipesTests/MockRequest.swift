//
//  MockRequest.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

struct MockRequest: Request {
    
    var path: String
    var httpMethod: String { "GET" }
    var headers: [String: String]? { Server.headers }
    var body: Data? { nil }

    func makeURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "https://example.com")!)
    }
    
}
