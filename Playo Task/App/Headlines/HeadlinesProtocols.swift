//
//  HeadlinesProtocols.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import UIKit

//MARK:- View Protocols
protocol HeadlinesViewType {
    func loadTableViewData()
    func displayError()
    func navigateToWebView(urlString: String)
}

//MARK:- ViewModel Protocols
protocol HeadlinesViewModelType {
    func attach(view: HeadlinesViewType)
    var headlinesMapperModel: HeadlinesMapperModel? { get set }
    var healineImagesList: [UIImage] { get set }
    func headlineSelected(index: Int)
    func getHeadlines()
}

