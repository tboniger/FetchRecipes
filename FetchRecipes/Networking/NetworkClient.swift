//
//  NetworkClient.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation

class NetworkClient {
    
    var jsonDecoder = JSONDecoder()
    var urlSession: URLSession = .shared

    func performRequest<T: Decodable>(request: Request) async throws -> T {
        
        do {
            
            let urlRequest = try request.makeURLRequest()
            let (data, response) = try await self.urlSession.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(statusCode: -1)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
            }

            let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
            return decodedResponse
            
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingFailed(decodingError)
        } catch {
            throw NetworkError.requestFailed(error)
        }

    }
}
