//
//  ArticleTableViewCell.swift
//  TrendingArticles
//
//  Created by Mustafa Saify on 23/10/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(with article: ArticleList.FetchArticles.ViewModel.ArticleDisplayModel) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.date
    }
}
