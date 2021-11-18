//
//  WebviewViewController.swift
//  Playo Task
//
//  Created by Sunkara Krishna on 18/11/21.
//

import Foundation
import UIKit
import WebKit
import ProgressHUD

class WebviewViewController: UIViewController, WebviewViewType {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: WebviewViewModelType? = WebviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Attaching View with ViewModel
        viewModel?.attach(view: self)
        initialSetup()
    }
    
    func initialSetup() {
        webView.navigationDelegate = self
        addBackButton()
        loadUrl()
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "close_button"), for: .normal)
        backButton.addTarget(self, action: #selector(self.cancelWebViewTapped(_:)), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @IBAction func cancelWebViewTapped(_ sender: UIButton) {
        let _ = self.dismiss(animated: true, completion: nil)
    }
    
    func loadUrl() {
        if let urlString = viewModel?.urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}


extension WebviewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //MARK:- will call after Url failed loading
        ProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //MARK:- will call after every Url started loading
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //MARK:- will call after every Url finished loading
        ProgressHUD.dismiss()
    }
}
