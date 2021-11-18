//
//  HeadlinesProtocols.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

//MARK:- View Protocols
protocol HeadlinesViewType {
    func loadTableViewData()
    func displayError()
}

//MARK:- ViewModel Protocols
protocol HeadlinesViewModelType {
    func attach(view: HeadlinesViewType)
    
}

