//
//  PrivacyViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 19/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import WebKit

class PrivacyViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var returnButton: UIBarButtonItem!
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let url = URL(string: "https://www.iubenda.com/privacy-policy/61738486")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        
        let request = URLRequest(url: url)
        self.navigationController?.navigationBar.isHidden = false
        webView.load(request)
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        let menuReturn = self.storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = menuReturn
    }
}
