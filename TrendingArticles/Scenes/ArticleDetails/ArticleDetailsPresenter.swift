//
//  ArticleDetailsPresenter.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 24/10/2022.
//

import Foundation

protocol ArticleDetailsPresentationLogic {
    func presentArticleDetails(response: ArticleDetails.LoadDetails.Response)
}

final class ArticleDetailsPresenter: ArticleDetailsPresentationLogic {
    
    weak var viewController: ArticleDetailsDisplayLogic?
    
    func presentArticleDetails(response: ArticleDetails.LoadDetails.Response) {
        let displayModel = ArticleDetails.LoadDetails.ViewModel.ArticleDetailsDisplayModel(
            title: response.article.title,
            description: response.article.description,
            url: response.article.url,
            source: response.article.source
        )
        viewController?.displayArticleDetails(viewModel: ArticleDetails.LoadDetails.ViewModel(articleDetails: displayModel))
    }
}
