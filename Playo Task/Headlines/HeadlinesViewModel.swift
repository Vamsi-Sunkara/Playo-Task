//
//  HeadlinesViewModel.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

class HeadlinesViewModel:  HeadlinesViewModelType {

    var headlinesView: HeadlinesViewType?
    
    func attach(view: HeadlinesViewType) {
        self.headlinesView = view
    }

}
