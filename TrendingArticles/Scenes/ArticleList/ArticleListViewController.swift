//
//  PopularArticlesViewController.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 22/10/2022.
//

import UIKit

protocol ArticleListDisplayLogic: AnyObject {
    func displayArticles(viewModel: ArticleList.FetchArticles.ViewModel)
    func displayError(message: String)
}

final class ArticleListViewController: UITableViewController {
    
    var interactor: ArticleListBusinessLogic?
    var router: ArticleListRoutingLogic?
    
    private var displayedArticles: [ArticleList.FetchArticles.ViewModel.ArticleDisplayModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // TODO: To have a UI to select the duration the user wants to view the articles for.
    private var duration: ArticleList.FetchArticles.Request.Duration {
        return .week
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ArticleListConfigurator.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchArticles(request: ArticleList.FetchArticles.Request(duration: duration))
    }
}

extension ArticleListViewController: ArticleListDisplayLogic {
    func displayArticles(viewModel: ArticleList.FetchArticles.ViewModel) {
        self.displayedArticles = viewModel.articleDisplayModels
    }
    
    func displayError(message: String) {
        let errorAlert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.interactor?.fetchArticles(request: ArticleList.FetchArticles.Request(duration: self.duration))
        })
        errorAlert.addAction(retry)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        errorAlert.addAction(cancel)
        
        self.present(errorAlert, animated: true)
    }
}

extension ArticleListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as! ArticleTableViewCell
        let article = displayedArticles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
}

extension ArticleListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleId = displayedArticles[indexPath.row].id
        router?.routeToArticleDetails(articleId: articleId)
    }
}
