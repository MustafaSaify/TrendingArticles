//
//  ArticleDetailsInteractorTests.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleDetailsInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleDetailsInteractor!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupArticleDetailsInteractor()
    }
      
    // MARK: - Test setup
    func setupArticleDetailsInteractor() {
        sut = ArticleDetailsInteractor()
    }
      
    // MARK: - Test doubles
    class ArticleDetailsPresentationLogicSpy: ArticleDetailsPresentationLogic {
        // Method call expectations
        var presentArticleDetailsCalled = false
        var article: Article!

        // Spied methods
        func presentArticleDetails(response: ArticleDetails.LoadDetails.Response) {
            article = response.article
            presentArticleDetailsCalled = true
        }
    }
      
    // MARK: - Tests
    func testLoadArticlesDetailshouldAskPresenterToFormatResult() {
        // Given
        let articleDetailsPresentationLogicSpy = ArticleDetailsPresentationLogicSpy()
        sut.presenter = articleDetailsPresentationLogicSpy
        sut.article = testArticle

        // When
        let request = ArticleDetails.LoadDetails.Request()
        sut.loadArticleDetails(request: request)

        // Then
        XCTAssertEqual(articleDetailsPresentationLogicSpy.presentArticleDetailsCalled, true)
        XCTAssertEqual(articleDetailsPresentationLogicSpy.article, testArticle)
    }
}

// MARK: - Test Data
private var testArticle: Article {
    Article(
        id: 1,
        title: "A",
        author: "test author",
        publishedDate: "test date",
        description: "test description",
        source: "test source",
        url: "test url"
    )
}
