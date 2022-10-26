//
//  ArticleDetailsConfigurator.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 24/10/2022.
//

import Foundation

struct ArticleDetailsConfigurator {
    
    static func configure(_ viewController: ArticleDetailsViewController) {
        let presenter = ArticleDetailsPresenter()
        presenter.viewController = viewController
        
        let interactor = ArticleDetailsInteractor()
        interactor.presenter = presenter
        
        let router = ArticleDetailsRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
