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
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The requested URL is invalid."
        case .requestFailed(let error):
            return error.localizedDescription
        case .invalidResponse(let statusCode):
            return "Received invalid response from server \(statusCode)."
        case .decodingFailed:
            return "Failed to decode the response from the server."
        case .unknown:
            return "An unknown error occurred."
        }
    }
    
}
