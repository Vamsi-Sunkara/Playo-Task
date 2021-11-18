//
//  HeadlinesViewController.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import UIKit

class HeadlinesViewController: UIViewController, HeadlinesViewType {

    @IBOutlet weak var headLinesTableView: UITableView!
    
    var viewModel: HeadlinesViewModelType = HeadlinesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Attaching View with ViewModel
        viewModel.attach(view: self.view)
    }


}
