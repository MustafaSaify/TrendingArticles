//
//  PopularArticlesWorker.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 22/10/2022.
//

import Foundation

protocol ArticleListWorkerLogic {
    func getArticles(days: Int, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class ArticleListWorker {
    private var articlesService: ArticlesService
    init(articlesService: ArticlesService) {
        self.articlesService = articlesService
    }
}

extension ArticleListWorker: ArticleListWorkerLogic {
    func getArticles(days: Int, completion: @escaping (Result<[Article], Error>) -> Void) {
        articlesService.fetchArticles(days: days, completion: { result in
            switch result {
            case .success(let response):
                completion(Result.success(response.results))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}
