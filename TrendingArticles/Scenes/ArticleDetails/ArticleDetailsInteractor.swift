//
//  ArticleDetailsInteractor.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

protocol ArticleDetailsBusinessLogic {
    func loadArticleDetails(request: ArticleDetails.LoadDetails.Request)
}

final class ArticleDetailsInteractor: ArticleDetailsBusinessLogic, ArticleDetailsDataStore {
    
    var article: Article!
    var presenter: ArticleDetailsPresentationLogic?
    
    func loadArticleDetails(request: ArticleDetails.LoadDetails.Request) {
        presenter?.presentArticleDetails(response: ArticleDetails.LoadDetails.Response(article: article))
    }
}
