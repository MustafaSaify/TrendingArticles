//
//  ArticleDetailsPresenterTests.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleDetailsPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleDetailsPresenter!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        setupArticleDetailsPresenter()
    }
      
    // MARK: - Test setup
    func setupArticleDetailsPresenter() {
        sut = ArticleDetailsPresenter()
    }
      
    // MARK: - Test doubles
    class ArticleDetailsDisplayLogicSpy: ArticleDetailsDisplayLogic {
        // Method call expectations
        var displayArticleDetailsCalled =  false
        var displayModel: ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel!

        // Spied methods
        func displayArticleDetails(viewModel: ArticleDetails.LoadDetails.ViewModel) {
            displayArticleDetailsCalled = true
            displayModel = viewModel.articleDetails
        }
    }
      
    // MARK: - Tests
    func testPresentArticleDetailsShouldAskViewControllerToDisplayArtcileDetails() {
        // Given
        let articleDetailsDisplayLogicSpy = ArticleDetailsDisplayLogicSpy()
        sut.viewController = articleDetailsDisplayLogicSpy

        // When
        let response = ArticleDetails.LoadDetails.Response(article: testArticle)
        sut.presentArticleDetails(response: response)

        // Then
        XCTAssertTrue(articleDetailsDisplayLogicSpy.displayArticleDetailsCalled)
        XCTAssertEqual(articleDetailsDisplayLogicSpy.displayModel, testArticleDetailsDisplayModel)
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

private var testArticleDetailsDisplayModel: ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel {
    ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel(
        title: "A",
        description: "test description",
        url: "test url",
        source: "test source"
    )
}
