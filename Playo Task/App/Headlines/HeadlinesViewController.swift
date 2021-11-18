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
        configureTableView()
        addRefresh()
    }
    
    //MARK:- Method to configure TableView
    func configureTableView() {
        
        headLinesTableView.delegate = self
        headLinesTableView.dataSource = self
        headLinesTableView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        headLinesTableView.register(UINib(nibName: NewsTableViewCell.cellIdentiier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.cellIdentiier)
    }
    
    //MARK:- Method to add refresh when tableview pull down
    func addRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        if #available(iOS 10.0, *) {
            headLinesTableView.refreshControl = refreshControl
        } else {
            headLinesTableView.backgroundView = refreshControl
        }
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.viewModel?.getHeadlines()
        refreshControl.endRefreshing()
    }

}

//MARK:- UITableViewDelegate Methods
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
            cell.displayImage = viewModel?.healineImagesList[indexPath.row]
        }
        return cell
    }
    
}

extension HeadlinesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.headlineSelected(index: indexPath.row)
    }
}


extension HeadlinesViewController {
    
    func loadTableViewData() {
        headLinesTableView.reloadData()
    }
    
    //MARK:- Method to display an error alert
    func displayError() {
        let alert = UIAlertController(title: "Error", message: "We have an error while getting response", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Navigating to Web View on selection of Cell
    func navigateToWebView(urlString: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WebviewViewController") as! WebviewViewController
        viewController.viewModel?.urlString = urlString
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
        
    }
}
