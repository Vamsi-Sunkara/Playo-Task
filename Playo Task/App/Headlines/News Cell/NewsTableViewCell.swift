//
//  NewsTableViewCell.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Getting Data and Updating to Cell
    var headline: HeadLineArticles? {
        didSet {
            if let headlineData = headline {
                titleLabel.text = headlineData.title
                authorLabel.text = headlineData.author
                descriptionLabel.text = headlineData.description
                
                var headlinesImage: UIImage?
                let url = URL(string: headlineData.urlToImage ?? "") ?? nil
                if let data = try? Data(contentsOf: url!) {
                    headlinesImage = UIImage(data: data) ?? UIImage(named: "defaultImage")
                }
                
                newsImageView.image = headlinesImage
            }
        }
    }
    
    static let cellIdentiier = "NewsTableViewCell"
}
