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
    
    var viewModel: HeadlinesViewModelType? = HeadlinesViewModel(manager: HeadlinesManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Attaching View with ViewModel
        viewModel?.attach(view: self)
    }
    
    func loadTableViewData() {
        headLinesTableView.reloadData()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Error", message: "We have a error while getting response", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
