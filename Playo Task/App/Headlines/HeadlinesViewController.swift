//
//  HeadlinesViewController.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import UIKit
import RxSwift

class HeadlinesViewController: UIViewController, HeadlinesViewType {
    
    @IBOutlet weak var headLinesTableView: UITableView!
    
    var viewModel: HeadlinesViewModelType? = HeadlinesViewModel(manager: HeadlinesManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Attaching View with ViewModel
        viewModel?.attach(view: self)
        configureTableView()
    }
    
    func configureTableView() {
        
        headLinesTableView.delegate = self
        headLinesTableView.dataSource = self
        headLinesTableView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        headLinesTableView.register(UINib(nibName: NewsTableViewCell.cellIdentiier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.cellIdentiier)
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

extension HeadlinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = viewModel?.headlinesMapperModel?.articles else {
            return 0
        }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellIdentiier, for: indexPath) as! NewsTableViewCell
        if let articles = viewModel?.headlinesMapperModel?.articles {
            cell.headline = articles[indexPath.row]
        }
        return cell
    }
    
    
}

extension HeadlinesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.headlineSelected(index: indexPath.row)
    }
}
