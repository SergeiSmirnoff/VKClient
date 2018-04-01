//
//  ViewController.swift
//  VKClient
//
//  Created by albert on 31.03.2018.
//  Copyright © 2018 albert. All rights reserved.
//

import UIKit
import WebKit
var theGlobalToken:String?

class AuthViewController: UIViewController {
  let userDefolts = UserDefaults.standard
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=6244609&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=token&v=5.68") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension AuthViewController {
    @IBAction func getFriendList() {
        
    }  
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
  
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        decisionHandler(.cancel)
        theGlobalToken = token
        UserDefaults.setValue(token, forKey: "theGlobalToken")
    }
}

/////
//some shit


//TODO: 1) Разобраться с UserDefaults
// 2) Разобраться с alamofire
// 3) Codable протокол
// 4) ООП - наследование, полифморфизм, инкапсуляция
// 5) чистый код - роберт мартин
