//
//  HeadlinesViewModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import RxSwift
import ProgressHUD
import UIKit

class HeadlinesViewModel:  HeadlinesViewModelType {

    //MARK:- Variables & Properties
    private var headlinesView: HeadlinesViewType?
    private let headlinesManager: HeadlinesUsecase
    var headlinesMapperModel: HeadlinesMapperModel?
    lazy var healineImagesList: [UIImage] = []
    
    lazy var disposeBag = DisposeBag()
    
    //MARK:- Initializing Usecase
    init(manager: HeadlinesUsecase) {
        headlinesManager = manager
        getHeadlines()
    }
    
    //MARK:- Attching View
    func attach(view: HeadlinesViewType) {
        self.headlinesView = view
    }
    
    //MARK:- Method to get Headlines by API call
    func getHeadlines() {
        let request : [String: Any] = [:]
        let additionalQuery: [String: String] = [:]
        
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.show()
        headlinesManager.getHeadlines(request: request, additionalQuery: additionalQuery)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self else {return}
                self.headlinesMapperModel = response
                self.getImagesArray()
            }, onError: { [weak self] (error) in
                guard let self = self, let view = self.headlinesView else {return}
                view.displayError()
            }).disposed(by: disposeBag)
    }
    
    //MARK:- Method to fetch data of selected cell
    func headlineSelected(index: Int) {
        guard let selectedArticle = headlinesMapperModel?.articles[index], let naviagteToURL = selectedArticle.url, let view = self.headlinesView else {
            return
        }
        
        view.navigateToWebView(urlString: naviagteToURL)
    }
    
    //MARK:- Method that will call all images and store in local
    // This is extra function is done because getting images while loading cell is making app struck on every cell load. Now while we download all the images at once and store.
    
    // But this method will not work when we have more number of records.As we are delaying with only 10 records this will work well 
    func getImagesArray() {
        
        guard let articles = self.headlinesMapperModel?.articles, let view = self.headlinesView else {
            return
        }
        
        for data in articles {
            let url = URL(string: data.urlToImage ?? "")
            if let data = try? Data(contentsOf: url!), let image = UIImage(data: data) {
                healineImagesList.append(image)
            }
        }
        ProgressHUD.dismiss()
        view.loadTableViewData()
    }

}
