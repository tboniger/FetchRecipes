//
//  NetworkClientProtocol.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

protocol NetworkClientProtocol {
    func performRequest<T: Decodable>(request: Request) async throws -> T
}
