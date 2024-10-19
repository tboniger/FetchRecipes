//
//  Server.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation

struct Server {
    
    static var baseURL: URL? {
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/")
    }
    
    static var headers: [String: String] {
        return [:]
    }
    
}
