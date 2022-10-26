//
//  MostPopularArticlesAPITest.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import Foundation
import XCTest
@testable import TrendingArticles

class MostPopularArticlesServiceTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: MostPopularArticlesService!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupMostPopularArticlesAPI()
    }
      
    // MARK: - Test setup
    func setupMostPopularArticlesAPI() {
        sut = MostPopularArticlesService(
            baseUrl: "test_base_url",
            apiKey: "test_api_key",
            networkManager: NetworkManagerSpy(withMockFile: "most_popular_articles_response")
        )
    }
      
    // MARK: - Test doubles
    class NetworkManagerSpy: NetworkContractor {
        
        private var mockFile: String

        init(withMockFile mockFile: String) {
            self.mockFile = mockFile
        }
        
        func sendRequest<T>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {

            let bundle = Bundle(for: NetworkManagerSpy.self)
            
            guard let filePath = bundle.path(forResource: mockFile, ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
                  let result = try? JSONDecoder().decode(T.self, from: data) else {
                return
            }
            completion(.success(result))
        }
    }
      
    // MARK: - Tests
    func testFetchArticlesShouldReturnResponseWithArticles() {
        
        // When
        var actual: ArticleListResponse!
        let expect = XCTestExpectation(description: "Wait for fetchArticles() to return")
        sut.fetchArticles(days: 1) { result in
            switch result {
                case .success(let response):
                    actual = response
                default:
                    break
            }
            expect.fulfill()
        }

        // Then
        wait(for: [expect], timeout: 0.1)
        XCTAssertEqual(actual.results, testArticles)
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
