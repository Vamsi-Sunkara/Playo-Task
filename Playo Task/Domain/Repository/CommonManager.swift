//
//  CommonManager.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation

class CommonManager: API {
    
    let domain: String
    
    init() {
        //MARK:- Base URL
        domain = "https://newsapi.org/v2/top-headlines?"
    }
}
