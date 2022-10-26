//
//  PopularArticlesRouter.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation
import UIKit

protocol ArticleListRoutingLogic {
    func routeToArticleDetails(articleId: Double)
}

protocol ArticleListDataPassing {
    var dataStore: ArticleListDataStore? { get }
}

final class ArticleListRouter: ArticleListRoutingLogic, ArticleListDataPassing {
    
    weak var viewController: ArticleListViewController?
    var dataStore: ArticleListDataStore?
    
    func routeToArticleDetails(articleId: Double) {
        let articleDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
        let sourceDataStore = dataStore
        var destinationDataStore = articleDetailsViewController.router?.dataStore
        passDataToArticleDetails(selectedArticleId: articleId, sourceDataStore: sourceDataStore, destinationDataStore: &destinationDataStore)
        viewController?.navigationController?.pushViewController(articleDetailsViewController, animated: true)
    }
}

// MARK: Data Passing
extension ArticleListRouter {
    func passDataToArticleDetails(
        selectedArticleId: Double,
        sourceDataStore: ArticleListDataStore?,
        destinationDataStore: inout ArticleDetailsDataStore?)
    {
        destinationDataStore?.article = sourceDataStore?.articles.first{ $0.id == selectedArticleId }
    }
}
