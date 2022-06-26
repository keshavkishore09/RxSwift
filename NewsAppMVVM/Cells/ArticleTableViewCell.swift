//
//  ArticleTableViewCell.swift
//  NewsAppMVVM
//
//  Created by Keshav Kishore on 26/06/22.
//

import Foundation
import UIKit


class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
