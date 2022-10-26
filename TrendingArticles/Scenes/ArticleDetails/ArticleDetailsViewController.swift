//
//  ArticleDetailsViewController.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 23/10/2022.
//

import UIKit

protocol ArticleDetailsDisplayLogic: AnyObject {
    func displayArticleDetails(viewModel: ArticleDetails.LoadDetails.ViewModel)
}

final class ArticleDetailsViewController: UIViewController {
    
    var router: ArticleDetailsRoutingLogic?
    var interactor: ArticleDetailsBusinessLogic?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ArticleDetailsConfigurator.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadArticleDetails(request: ArticleDetails.LoadDetails.Request())
    }
}

extension ArticleDetailsViewController: ArticleDetailsDisplayLogic {
    func displayArticleDetails(viewModel: ArticleDetails.LoadDetails.ViewModel) {
        let articleDetails = viewModel.articleDetails
        titleLabel.text = articleDetails.title
        descriptionLabel.text = articleDetails.description
        sourceLabel.text = articleDetails.source
        urlLabel.text = articleDetails.url
    }
}
