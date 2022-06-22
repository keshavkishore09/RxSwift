//
//  ArticleModel.swift
//  Good News
//
//  Created by Keshav Kishore on 22/06/22.
//

import Foundation



struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    
    let title: String
    let description: String
    
    
}
