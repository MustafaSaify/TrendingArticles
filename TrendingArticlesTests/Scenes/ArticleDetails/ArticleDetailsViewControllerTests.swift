//
//  ArticleDetailsViewControllerTests.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleDetailsViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleDetailsViewController!
    var window: UIWindow!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        window = UIWindow()
        setupArticleDetailsViewController()
    }
      
    // MARK: - Test setup
    func setupArticleDetailsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
      
    // MARK: - Test doubles
    class ArticleDetailsBusinessLogicSpy: ArticleDetailsBusinessLogic {
        // Method call expectations
        var loadArticleDetailsCalled = false
        
        // Spied methods
        func loadArticleDetails(request: ArticleDetails.LoadDetails.Request) {
            loadArticleDetailsCalled = true
        }
    }
      
    // MARK: - Tests
    func testShouldLoadArticleDetailsOnViewLoad() {
        
        // Given
        let articleDetailsBusinessLogicSpy = ArticleDetailsBusinessLogicSpy()
        sut.interactor = articleDetailsBusinessLogicSpy
        
        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(articleDetailsBusinessLogicSpy.loadArticleDetailsCalled, "Should load article details right after the view loads")
    }
    
    func testShouldDisplayArticleDetails() {
        // Give
        let articleDetailsBusinessLogicSpy = ArticleDetailsBusinessLogicSpy()
        sut.interactor = articleDetailsBusinessLogicSpy
        loadView()
        
        // When
        let viewModel = ArticleDetails.LoadDetails.ViewModel(articleDetails: testArticleDetailsDisplayModel)
        sut.displayArticleDetails(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.titleLabel.text, "test title")
        XCTAssertEqual(sut.sourceLabel.text, "test source")
        XCTAssertEqual(sut.descriptionLabel.text, "test description")
        XCTAssertEqual(sut.urlLabel.text, "test url")
    }
}

// MARK: - Test Data
private var testArticleDetailsDisplayModel: ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel {
    return ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel(
        title: "test title",
        description: "test description",
        url: "test url",
        source: "test source"
    )
}
