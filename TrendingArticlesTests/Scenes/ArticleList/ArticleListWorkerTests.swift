//
//  ArticleListWorkerTest.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 24/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleListWorkerTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleListWorker!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupArticleListWorker()
    }
      
    // MARK: - Test setup
    func setupArticleListWorker() {
        sut = ArticleListWorker(articlesService: ArticlesServiceSpy())
    }
      
    // MARK: - Test doubles
    class ArticlesServiceSpy: ArticlesService {
        
        // Spied methods
        func fetchArticles(days: Int, completion: @escaping (Result<ArticleListResponse, Error>) -> Void) {
            completion(.success(ArticleListResponse(results: testArticles)))
        }
    }
      
    // MARK: - Tests
    func testGetArticlesShouldCallFetchArticlesOnArticlesStore() {
        
        // When
        var fetchedArticles: [Article] = []
        let expect = XCTestExpectation(description: "Wait for getArticles() to return")
        sut.getArticles(days: 1) { result in
            switch result {
                case .success(let articles):
                    fetchedArticles = articles
                default:
                    break
            }
            expect.fulfill()
        }

        // Then
        wait(for: [expect], timeout: 0.1)
        XCTAssertEqual(fetchedArticles, testArticles)
    }
}

// MARK: - Test Data
private var testArticles: [Article] {
    return [
        Article(
            id: 1,
            title: "A",
            author: "test author",
            publishedDate: "test date",
            description: "test description",
            source: "test source",
            url: "test url"
        )
    ]
}
