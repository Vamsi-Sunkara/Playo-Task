//
//  HeadlinesMapperModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

struct HeadlinesMapperModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [HeadLineArticles]
}


struct HeadLineArticles: Codable {
    let source: ArticalDetails?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct ArticalDetails: Codable  {
    let id: String?
    let name: String?
}
