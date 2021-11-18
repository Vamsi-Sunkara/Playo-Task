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
            
            //MARK:- Checking for Network availablity
            if !NetworkState.isConnected() {
                observer.onError(RequestError.connectionError)
            }
                            
            //MARK:- Making Reuest and getting Response
            let request = AF.request(urlRequest).responseDecodable(of: T.self) { (response) in
                debugPrint("Response:-", response)
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
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

//MARK:- Making Request and getting Response
enum RequestError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}

