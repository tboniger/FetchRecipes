//
//  NetworkError.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

enum NetworkError: Error {
    
    case badURL
    case requestFailed(Error)
    case invalidResponse(statusCode: Int)
    case decodingFailed(Error)
    
}
