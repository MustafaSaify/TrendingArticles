//
//  PopularArticlesPresenter.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 22/10/2022.
//

import Foundation

protocol ArticleListPresentationLogic {
    func presentArticles(response: ArticleList.FetchArticles.Response)
    func presentError(error: Error?)
}

final class ArticleListPresenter: ArticleListPresentationLogic {
    weak var viewController: ArticleListDisplayLogic?
    
    func presentArticles(response: ArticleList.FetchArticles.Response) {
        let articleDisplayModels = response.articles.map({ article in
            return ArticleList.FetchArticles.ViewModel.ArticleDisplayModel(
                id: article.id,
                title: article.title,
                author: article.author,
                date: article.publishedDate
            )
        })
        viewController?.displayArticles(
            viewModel: ArticleList.FetchArticles.ViewModel(articleDisplayModels: articleDisplayModels)
        )
    }
    
    func presentError(error: Error?) {
        viewController?.displayError(message: "Something went wrong. Please try again.")
    }
}
