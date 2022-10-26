//
//  ArticleDetailsRouter.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

protocol ArticleDetailsRoutingLogic {
    var dataStore: ArticleDetailsDataStore? { get set }
}

final class ArticleDetailsRouter: ArticleDetailsRoutingLogic {
    var viewController: ArticleDetailsViewController?
    var dataStore: ArticleDetailsDataStore?
}
