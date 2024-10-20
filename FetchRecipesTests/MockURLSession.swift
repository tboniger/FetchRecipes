//
//  MockURLSession.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }

        let response = self.response ?? URLResponse()
        let data = self.data ?? Data()
        return (data, response)
    }

}
