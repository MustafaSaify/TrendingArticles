//
//  PopularArticlesRequest.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

struct MostPopularArticlesNetworkRequest: NetworkRequest {
    var baseUrl: String
    var days: Int
    var apiKey: String
    
    init(baseUrl: String, apiKey: String, days: Int = 7) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.days = days
    }
    
    var urlRequest: URLRequest {
        return URLRequest(baseURL: URL(string: baseUrl)!,
                          path: "svc/mostpopular/v2/viewed/\(days).json",
                          parameters: queryParams)!
    }
    
    private var queryParams: [String : AnyObject] {
        return ["api-key" : apiKey] as [String : AnyObject]
    }
}
