//
//  PopularArticlesService.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

protocol ArticlesService {
    func fetchArticles(days: Int, completion: @escaping (Result<ArticleListResponse, Error>) -> Void)
}

struct MostPopularArticlesService: ArticlesService {
    
    private var baseUrl: String
    private var apiKey: String
    private var networkManager: NetworkContractor
    
    init(baseUrl: String = NetworkConstants.host,
         apiKey: String = NetworkConstants.apiKey,
         networkManager: NetworkContractor = NetworkManager()) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.networkManager = networkManager
    }
    
    func fetchArticles(days: Int, completion: @escaping (Result<ArticleListResponse, Error>) -> Void) {
        let request = MostPopularArticlesNetworkRequest(baseUrl: baseUrl, apiKey: apiKey, days: days)
        networkManager.sendRequest(request: request, completion: completion)
    }
}
