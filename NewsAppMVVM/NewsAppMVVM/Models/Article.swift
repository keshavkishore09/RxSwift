//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Keshav Kishore on 26/06/22.
//

import Foundation




struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
