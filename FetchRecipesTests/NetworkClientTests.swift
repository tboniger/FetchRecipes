//
//  NetworkClientTests.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/20/24.
//

import XCTest
@testable import FetchRecipes

final class NetworkClientTests: XCTestCase {
    
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkClient = NetworkClient(session: mockSession)
    }

    override func tearDown() {
        networkClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testPerformRequest_SuccessfulResponse() async throws {
    
        let expectedResponse = MockResponse(id: 1, name: "Test")
        let responseData = try JSONEncoder().encode(expectedResponse)
        mockSession.data = responseData

        let httpResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockSession.response = httpResponse

        let mockRequest = MockRequest(path: "somepath")

        let response: MockResponse = try await networkClient.performRequest(request: mockRequest)

        XCTAssertEqual(response, expectedResponse)
        
    }
    
    func testPerformRequest_HTTPErrorResponse() async {

        mockSession.data = Data()
        let httpResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        mockSession.response = httpResponse

        let mockRequest = MockRequest(path: "somepath")

        do {
            let _: MockResponse = try await networkClient.performRequest(request: mockRequest)
            XCTFail("Expected to throw, but did not")
        } catch let error as NetworkError {
            if case let .invalidResponse(statusCode) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("Expected invalidResponse error, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    
    }
    
    func testPerformRequest_DecodingFailure() async {

        let invalidJSON = """
        {
            "unexpected_key": "unexpected_value"
        }
        """
        mockSession.data = invalidJSON.data(using: .utf8)
        let httpResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockSession.response = httpResponse

        let mockRequest = MockRequest(path: "somepath")

        do {
            let _: MockResponse = try await networkClient.performRequest(request: mockRequest)
            XCTFail("Expected to throw, but did not")
        } catch let error as NetworkError {
            if case let .decodingFailed(decodingError) = error {
                XCTAssertTrue(decodingError is DecodingError)
            } else {
                XCTFail("Expected decodingFailed error, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func testPerformRequest_NetworkRequestFailure() async {

        let networkError = URLError(.notConnectedToInternet)
        mockSession.error = networkError

        let mockRequest = MockRequest(path: "somepath")

        do {
            let _: MockResponse = try await networkClient.performRequest(request: mockRequest)
            XCTFail("Expected to throw, but did not")
        } catch let error as NetworkError {
            if case let .requestFailed(underlyingError) = error {
                XCTAssertEqual((underlyingError as? URLError)?.code, .notConnectedToInternet)
            } else {
                XCTFail("Expected requestFailed error, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
}


