//
//  HeadlinesViewModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import RxSwift

class HeadlinesViewModel:  HeadlinesViewModelType {

    private var headlinesView: HeadlinesViewType?
    private let headlinesManager: HeadlinesUsecase
    var headlinesMapperModel: HeadlinesMapperModel?
    
    lazy var disposeBag = DisposeBag()
    
    init(manager: HeadlinesUsecase) {
        headlinesManager = manager
        getHeadlines()
    }
    
    func attach(view: HeadlinesViewType) {
        self.headlinesView = view
    }
    
    func getHeadlines() {
        let request : [String: Any] = [:]
        let additionalQuery: [String: String] = [:]
        
        headlinesManager.getHeadlines(request: request, additionalQuery: additionalQuery)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self, let view = self.headlinesView else {return}
                self.headlinesMapperModel = response
                view.loadTableViewData()
            }, onError: { [weak self] (error) in
                guard let self = self, let view = self.headlinesView else {return}
                view.displayError()
            }).disposed(by: disposeBag)
    }
    
    func headlineSelected(index: Int) {
        guard let selectedArticle = headlinesMapperModel?.articles[index] else {
            return
        }
        print(selectedArticle)
        
    }

}
