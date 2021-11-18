//
//  HeadlinesResponseModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

struct HeadlinesResponseModel: Codable {
    let status: Int?
    
    func toMapperModel() -> HeadlinesMapperModel {
        return HeadlinesMapperModel(status: self.status)
    }
}
