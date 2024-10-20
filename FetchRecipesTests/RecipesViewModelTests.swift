//
//  RecipesViewModelTests.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import XCTest
@testable import FetchRecipes

@MainActor
final class RecipesViewModelTests: XCTestCase {
    
    var viewModel: RecipesViewModel!
    var mockNetworkClient: MockNetworkClient!

    override func setUp() async throws {
        try await super.setUp()
        mockNetworkClient = MockNetworkClient()
        viewModel = RecipesViewModel(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testFetchRecipes_Success() async throws {

        let mockRecipes = [
            Recipe(cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "1", sourceUrl: nil, youtubeUrl: nil),
            Recipe(cuisine: "Mexican", name: "Tacos", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "2", sourceUrl: nil, youtubeUrl: nil)
        ]
        let mockResponse = RecipeResponse(recipes: mockRecipes)
        let responseData = try JSONEncoder().encode(mockResponse)
        mockNetworkClient.result = .success(responseData)

        await viewModel.recipes()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.recipes, mockRecipes)
    
    }
    
    func testFetchRecipes_NetworkError() async throws {

        let networkError = NetworkError.invalidResponse(statusCode: 500)
        mockNetworkClient.result = .failure(networkError)

        await viewModel.recipes()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, networkError.errorDescription)
        
    }
    
    func testFetchRecipes_DecodingError() async throws {

        let invalidData = "Invalid JSON".data(using: .utf8)!
        mockNetworkClient.result = .success(invalidData)

        await viewModel.recipes()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to decode the response from the server.")
        
    }

}
