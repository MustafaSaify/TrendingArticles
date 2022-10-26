//
//  ArticleListPresenterTest.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 24/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleListPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleListPresenter!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupArticleListPresenter()
    }
      
    // MARK: - Test setup
    func setupArticleListPresenter() {
        sut = ArticleListPresenter()
    }
      
    // MARK: - Test doubles
    class ArticleListDisplayLogicSpy: ArticleListDisplayLogic {
        // Method call expectations
        var displayArticlesCalled =  false
        var displayErrorCalled = false

        // Spied methods
        func displayArticles(viewModel: ArticleList.FetchArticles.ViewModel) {
            displayArticlesCalled = true
        }
        
        func displayError(message: String) {
            displayErrorCalled =  true
        }
    }
      
    // MARK: - Tests
    func testPresentArticlesShouldCallDisplayArticlesOnViewControllerOnReceivingResponse() {
        // Given
        let articleListDisplayLogicSpy = ArticleListDisplayLogicSpy()
        sut.viewController = articleListDisplayLogicSpy

        // When
        let response = ArticleList.FetchArticles.Response(articles: testArticles)
        sut.presentArticles(response: response)

        // Then
        XCTAssertTrue(articleListDisplayLogicSpy.displayArticlesCalled)
    }
    
    func testPresentArticlesShouldCallDisplayErrorOnViewControllerOnReceivingError() {
        // Given
        let articleListDisplayLogicSpy = ArticleListDisplayLogicSpy()
        sut.viewController = articleListDisplayLogicSpy

        // When
        sut.presentError(error: nil)

        // Then
        XCTAssertTrue(articleListDisplayLogicSpy.displayErrorCalled)
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
