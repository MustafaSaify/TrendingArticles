//
//  PopularArticlesConfigurator.swift
//  TrendingStories
//
//  Created by Mustafa Saify on 23/10/2022.
//

import Foundation

struct ArticleListConfigurator {
    
    static func configure(viewController: ArticleListViewController) {
        
        let presenter = ArticleListPresenter()
        presenter.viewController = viewController
        
        let mostPopularArticlesService = MostPopularArticlesService()
        let worker = ArticleListWorker(articlesService: mostPopularArticlesService)
        
        let interactor = ArticleListInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
        
        let router = ArticleListRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
