//
//  MockNetworkClient.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

class MockNetworkClient: NetworkClientProtocol {
    
    var result: Result<Data, Error>?
    var decoder: JSONDecoder = JSONDecoder()
    
    func performRequest<T: Decodable>(request: Request) async throws -> T {
        
        guard let result = result else {
            fatalError("Result not set")
        }
        
        switch result {
        case .success(let data):
            do {
                return try decoder.decode(T.self, from: data)
            } catch let decodingError as DecodingError {
                throw NetworkError.decodingFailed(decodingError)
            } catch {
                throw error
            }
        case .failure(let error):
            throw error
        }
    }
    
}
