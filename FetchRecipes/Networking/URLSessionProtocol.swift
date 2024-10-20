//
//  URLSessionProtocol.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
