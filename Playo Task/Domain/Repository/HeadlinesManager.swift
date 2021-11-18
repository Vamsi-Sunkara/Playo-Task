//
//  HeadlinesManager.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import RxSwift

class HeadlinesManager: CommonManager, HeadlinesUsecase {
    
    func getHeadlines(request: RequestParams, additionalQuery: [String : String]?) -> Observable<HeadlinesMapperModel> {
        let request = buildRequest(http: HeadlinesRouter.getHeadLines(model: request), additionalHeaders: additionalQuery)
        let response: Observable<HeadlinesResponseModel> = NetworkManager.shared.request(request)
        return response.map{$0.toMapperModel()}
    }

}
