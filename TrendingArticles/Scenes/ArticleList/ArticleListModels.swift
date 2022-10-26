//
//  Article.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 22/10/2022.
//

import Foundation

enum ArticleList {
    
    struct FetchArticles {
        
        struct Request {
            enum Duration: Int {
                case daily = 1
                case weekly = 7
                case monthly = 30
            }
            var duration: Duration
        }
        
        struct Response: Codable {
            var articles: [Article]
        }
        
        struct ViewModel {
            struct ArticleDisplayModel {
                var id: Double
                var title: String
                var author: String
                var date: String
            }
            var articleDisplayModels: [ArticleDisplayModel]
        }
    }
}
