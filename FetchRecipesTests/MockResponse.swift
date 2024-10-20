//
//  MockResponse.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import Foundation

struct MockResponse: Decodable, Encodable, Equatable {
    let id: Int
    let name: String
}
