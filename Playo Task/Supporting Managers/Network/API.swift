//
//  API.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

protocol API {
    var domain: String { get }
    func buildRequest(http: HTTP, additionalHeaders: [String: String]?) -> URLRequest
}

extension API {
    
    func buildRequest(http: HTTP, additionalHeaders: [String: String]? = nil) -> URLRequest {
        
        let urlString: String
        let encodedPath = http.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        urlString = domain + encodedPath
        
        var urlComps = URLComponents(string: urlString)
        var queryList = http.queryList
        if let dic = additionalHeaders {
            queryList?.merge(dic){(current, _) in current }
        }
        
        if let querys = queryList {
            urlComps?.setQueryItems(with: querys)
        }
               
        let url = (urlComps?.url)!
        var urlRequest = URLRequest(url: url)
        
        //Http method and body
        urlRequest.httpMethod = http.method.text
        urlRequest.httpBody = http.method.body
       
        //Handled only json type
        if let type = http.method.bodyType {
            urlRequest.setValue(type.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
            urlRequest.setValue(type.rawValue, forHTTPHeaderField: HttpHeaderField.acceptType.rawValue)
        }
        
        //adding additional headers if available
        if let additionalHeaders = additionalHeaders {
            additionalHeaders.forEach { (key, value) in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
    
        print(urlRequest)
        
        return urlRequest
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
