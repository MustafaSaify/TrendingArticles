//
//  Article.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

struct Article: Codable, Equatable {
    var id: Double
    var title: String
    var author: String
    var publishedDate: String
    var description: String
    var source: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author = "byline"
        case publishedDate = "published_date"
        case description = "abstract"
        case source
        case url
    }
}
