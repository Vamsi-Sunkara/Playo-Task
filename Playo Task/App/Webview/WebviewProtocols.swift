//
//  WebviewProtocols.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

//MARK:- View Protocols
protocol WebviewViewType {
    
}

//MARK:- ViewModel Protocols
protocol WebviewViewModelType {
    var urlString: String {get set}
    func attach(view: WebviewViewType)
    
}

