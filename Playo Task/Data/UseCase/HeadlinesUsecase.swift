//
//  HeadlinesUsecase.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import RxSwift

typealias RequestParams = [String: Any]

protocol HeadlinesUsecase {
    func getHeadlines(request : RequestParams, additionalQuery: [String: String]?) -> Observable<HeadlinesMapperModel>
}
