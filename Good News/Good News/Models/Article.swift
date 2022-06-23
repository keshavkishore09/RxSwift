//
//  ArticleModel.swift
//  Good News
//
//  Created by Keshav Kishore on 22/06/22.
//

import Foundation



struct ArticlesList: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
    let source: Source
    let author: String?
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    enum CodingKeys: String, CodingKey { // Our Saviour
            case title
            case description
            case source
            case author
            case url
            case urlToImage
            case publishedAt
            case content
        }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        source = try values.decode(Source.self, forKey: .source)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        url = try values.decode(String.self, forKey: .url)
        urlToImage = try values.decode(String.self, forKey: .urlToImage)
        publishedAt = try values.decode(String.self, forKey: .publishedAt)
        content = try values.decode(String.self, forKey: .content)
    }
        
}

struct Source: Decodable {
    let id: String?
    let name: String
    
    enum CodingKeys: String, CodingKey { // Our Saviour
            case id
            case name
        }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}


extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apikey=1de78ab6990446e2a9a970ad484c5662")!
        return Resource(url: url) 
    }()
}
