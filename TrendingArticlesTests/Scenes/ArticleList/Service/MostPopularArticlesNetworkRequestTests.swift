//
//  MostPopularArticlesRequestTest.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import Foundation
import XCTest
@testable import TrendingArticles

class MostPopularArticlesNetworkRequestTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: MostPopularArticlesNetworkRequest!
      
      
    // MARK: - Tests
    func testUrlRequestGeneration() {
        
        // Given
        let baseUrl = "http://test.com"
        let apiKey = "test_api_key"
        let days = 1
        let expectedUrl = URL(string: "http://test.com/svc/mostpopular/v2/viewed/1.json?api-key=test_api_key")!
        
        // When
        sut = MostPopularArticlesNetworkRequest(baseUrl: baseUrl, apiKey: apiKey, days: days)
        let actual = sut.urlRequest

        // Then
        XCTAssertEqual(actual.url!, expectedUrl)
    }
}

// MARK: - Test Data
private var testArticles: [Article] {
    return [
        Article(
            id: 1,
            title: "Test title",
            author: "By Emily",
            publishedDate: "2022-10-13",
            description: "Test description",
            source: "New York Times",
            url: "https://www.nytimes.com/2022/10/13/us/raleigh-shooting.html"
        )
    ]
}
