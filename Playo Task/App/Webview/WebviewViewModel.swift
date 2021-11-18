//
//  WebviewViewModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import RxSwift

class WebviewViewModel:  WebviewViewModelType {

    private var webView: WebviewViewType?
    var urlString: String = ""
    
    func attach(view: WebviewViewType) {
        self.webView = view
    }
}
