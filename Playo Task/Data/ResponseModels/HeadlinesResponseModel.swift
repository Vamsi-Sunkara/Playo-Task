//
//  HeadlinesResponseModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

struct HeadlinesResponseModel: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [HeadLineArticles]
    
    func toMapperModel() -> HeadlinesMapperModel {
        return HeadlinesMapperModel(status: status, totalResults: totalResults, articles: articles)
    }
}
