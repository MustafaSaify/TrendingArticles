//
//  ArticleListViewControllerTests.swift
//  TrendingArticlesTests
//
//  Created by Mustafa Saify on 25/10/2022.
//

import XCTest
@testable import TrendingArticles

class ArticleListViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: ArticleListViewController!
    var window: UIWindow!
      
    // MARK: - Test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        window = UIWindow()
        setupArticleListViewController()
    }
      
    // MARK: - Test setup
    func setupArticleListViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController
    }
    
    func loadView() {
        //window.addSubview(sut.view)
        window.rootViewController = sut
        RunLoop.current.run(until: Date())
    }
      
    // MARK: - Test doubles
    class ArticleListBusinessLogicSpy: ArticleListBusinessLogic {
        // Method call expectations
        var fetchArticlesCalled = false
        
        // Spied methods
        func fetchArticles(request: ArticleList.FetchArticles.Request) {
            fetchArticlesCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        //Method call expectations
        var reloadDataCalled = false

        //Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }
      
    // MARK: - Tests
    func testShouldFetchArticlesOnViewLoad() {
        
        // Given
        let articleListBusinessLogicSpy = ArticleListBusinessLogicSpy()
        sut.interactor = articleListBusinessLogicSpy
        
        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(articleListBusinessLogicSpy.fetchArticlesCalled, "Should fetch articles right after the view loads")
    }
    
    func testShouldDisplayFetchedArticles() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        // When
        let displayedArticles = testDisplayArticles
        let viewModel = ArticleList.FetchArticles.ViewModel(articleDisplayModels: displayedArticles)
        sut.displayArticles(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "TableView should be reloaded to display the fetched articles")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        let tableView = sut.tableView
        
        // When
        let numberOfSections = sut.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInSectionShouldEqaulNumberOfArticlesToDisplay() {
        // Given
        let tableView = sut.tableView
        
        // When
        sut.displayArticles(
            viewModel: ArticleList.FetchArticles.ViewModel(articleDisplayModels: testDisplayArticles)
        )
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayArticles.count, "The number of table view rows should equal the number of articles to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayArticle() {
        // Given
        let tableView = sut.tableView
        sut.displayArticles(
            viewModel: ArticleList.FetchArticles.ViewModel(articleDisplayModels: testDisplayArticles)
        )
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath) as! ArticleTableViewCell
        
        // Then
        XCTAssertEqual(cell.titleLabel.text, "A")
        XCTAssertEqual(cell.authorLabel.text, "test author")
        XCTAssertEqual(cell.dateLabel.text, "test date")
    }
    
    func testShouldDisplayError() {
        // Given
        let errorMessage = "Test error message"
        
        // When
        sut.displayError(message: errorMessage)
        
        // Then
        XCTAssertNotNil(sut.presentedViewController is UIAlertController)
    }
}

// MARK: - Test Data
private var testDisplayArticles: [ArticleList.FetchArticles.ViewModel.ArticleDisplayModel] {
    return [
        ArticleList.FetchArticles.ViewModel.ArticleDisplayModel(
            id: 1,
            title: "A",
            author: "test author",
            date: "test date"
        )
    ]
}
