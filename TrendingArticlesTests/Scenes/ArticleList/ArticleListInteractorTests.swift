//
//  ArticleListInteractorTests.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 24/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleListInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleListInteractor!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupArticleListInteractor()
    }
      
    // MARK: - Test setup
    func setupArticleListInteractor() {
        sut = ArticleListInteractor()
    }
      
    // MARK: - Test doubles
    class ArticleListPresentationLogicSpy: ArticleListPresentationLogic {
        // Method call expectations
        var presentArticlesCalledExpectation: XCTestExpectation
        var presentErrorCalledExpectation: XCTestExpectation
        var articles: [Article] = []
        var error: Error?
        
        init(presentArticlesCalledExpectation: XCTestExpectation = XCTestExpectation(description: "Present articles called expectatin"),
             presentErrorCalledExpectation: XCTestExpectation = XCTestExpectation(description: "Present error called expectatin")
        ) {
            self.presentArticlesCalledExpectation = presentArticlesCalledExpectation
            self.presentErrorCalledExpectation = presentErrorCalledExpectation
        }

        // Spied methods
        func presentArticles(response: ArticleList.FetchArticles.Response) {
            articles = response.articles
            presentArticlesCalledExpectation.fulfill()
        }
        
        func presentError(error: Error?) {
            self.error = error
            presentErrorCalledExpectation.fulfill()
        }
    }

    class ArticleListWorkerLogicSpy: ArticleListWorkerLogic {
        
        // Method call expectations
        var getArticlesCalledExpectation: XCTestExpectation
        var mockedResult: Result<[Article], Error>
        
        init(getArticlesCalledExpectation: XCTestExpectation = XCTestExpectation(description: "Get articles called expectation"),
             mockedResult: Result<[Article], Error>)
        {
            self.getArticlesCalledExpectation = getArticlesCalledExpectation
            self.mockedResult = mockedResult
        }

        // Spied methods
        func getArticles(days: Int, completion: @escaping (Result<[Article], Error>) -> Void) {
            completion(mockedResult)
            getArticlesCalledExpectation.fulfill()
        }
    }
      
    // MARK: - Tests
    func testLoadArticlesShouldAskArticlesWorkerToFetchArticlesAndPresenterToFormatResult() {
        // Given
        let articleListPresentationLogicSpy = ArticleListPresentationLogicSpy()
        sut.presenter = articleListPresentationLogicSpy
        let articlesWorkerSpy = ArticleListWorkerLogicSpy(mockedResult: .success(testArticles))
        sut.worker = articlesWorkerSpy

        // When
        let request = ArticleList.FetchArticles.Request(duration: .day)
        sut.fetchArticles(request: request)

        // Then
        wait(for: [articlesWorkerSpy.getArticlesCalledExpectation,
                   articleListPresentationLogicSpy.presentArticlesCalledExpectation],
             timeout: 1,
             enforceOrder: true
        )
        XCTAssertEqual(articleListPresentationLogicSpy.articles, testArticles)
    }
    
    func testLoadArticlesShouldAskPresenterToPresentErrorWhenArticlesWorkerFailsToFetchArticles() {
        // Given
        let articleListPresentationLogicSpy = ArticleListPresentationLogicSpy()
        sut.presenter = articleListPresentationLogicSpy
        let articlesWorkerSpy = ArticleListWorkerLogicSpy(mockedResult: .failure(NSError(domain: "mock_error", code: 500)))
        sut.worker = articlesWorkerSpy

        // When
        let request = ArticleList.FetchArticles.Request(duration: .day)
        sut.fetchArticles(request: request)

        // Then
        wait(for: [articlesWorkerSpy.getArticlesCalledExpectation,
                   articleListPresentationLogicSpy.presentErrorCalledExpectation],
             timeout: 0.1,
             enforceOrder: true
        )
        XCTAssertNotNil(articleListPresentationLogicSpy.error)
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
