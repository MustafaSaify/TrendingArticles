//
//  ArticleDetailsModels.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 24/10/2022.
//

import Foundation

enum ArticleDetails {
    
    struct LoadDetails {
        
        struct Request {}
        
        struct Response {
            let article: Article
        }
        
        struct ViewModel {
            struct ArticleDetailsDisplayModel: Equatable {
                var title: String
                var description: String
                var url: String
                var source: String
            }
            let articleDetails: ArticleDetailsDisplayModel
        }
        
    }
}
