//
//  HTTP.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

//MARK:- HTTP API Router Protocol
protocol HTTP {
    var method: HTTPMethod { get }
    var path: String { get }
    var customURL: String? { get }
    var queryList:[String: String]? { get }
}

extension HTTP {
    var customURL: String? {
        return nil
    }
}

//MARK:- HTTP Methods
enum HTTPMethod {
    case get
    case post(_: Data?, _: BodyType)
    
    var body: Data? {
        switch self {
        case .get: return nil
        case .post(let data, _): return data
        }
    }

    var bodyType: BodyType? {
        switch self {
        case .get: return nil
        case .post(_, let type): return type
        }
    }
    
    var text: String {
        switch self {
        case .get: return "GET"
        case .post(_, _): return "POST"
        }
    }
}

enum BodyType: String {
    case json = "application/json"
}

//MARK:- HTTP Headers
enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case cookie = "Cookie"
}
