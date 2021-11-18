//
//  NetworkManager.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Codable> (_ urlRequest: URLRequest) ->  Observable<T>  {
        
        return Observable<T>.create { observer in
            
            if !NetworkState.isConnected() {
                observer.onError(RequestError.connectionError)
            }
                            
            let request = AF.request(urlRequest).responseDecodable(of: T.self) { (response) in
                
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}

class NetworkState {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}

