//
//  PopularArticlesInteractor.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 22/10/2022.
//

import Foundation

protocol ArticleListBusinessLogic {
    func fetchArticles(request: ArticleList.FetchArticles.Request)
}

final class ArticleListInteractor: ArticleListDataStore {
    var presenter: ArticleListPresentationLogic?
    var worker: ArticleListWorkerLogic?
    
    // DataStore
    var articles: [Article] = []
}

extension ArticleListInteractor: ArticleListBusinessLogic {
    func fetchArticles(request: ArticleList.FetchArticles.Request) {
        worker?.getArticles(days: request.duration.rawValue, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.presenter?.presentArticles(
                        response: ArticleList.FetchArticles.Response(articles: articles)
                    )
                case .failure(let error):
                    self?.presenter?.presentError(error: error)
                }
            }
        })
    }
}
