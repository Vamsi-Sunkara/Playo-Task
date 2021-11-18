//
//  HeadlinesRouter.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

enum HeadlinesRouter: HTTP {
    
    case getHeadLines(model: RequestParams)
   
    var method: HTTPMethod {
        switch self {
        case .getHeadLines :
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHeadLines:
            return ""
        }
    }
    
    var queryList: [String: String]? {
        return ["sources": "techcrunch", "apiKey" : "935ef7e436794482b90c46554f8cf974"]
    }
}
