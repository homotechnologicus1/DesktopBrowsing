//
//  ViewController.swift
//  DesktopBrowsing
//
//  Created by joe_mac on 05/22/2020.
//  Copyright © 2020 Joe K. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        // https://movie.daum.net/boxoffice/yearly
        // https://www.quora.com
        if let url = URL(string: "https://movie.daum.net/boxoffice/yearly") {
            load(url: url)
        }
    }
    
    private func createWebView() {
        let config = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"
        webview.uiDelegate = self
        webview.navigationDelegate = self
        self.webview = webview
//        self.view.addSubview(webview)
        self.view = self.webview
    }

    private func load(url: URL) {
        var request = URLRequest(url: url)
        /*
//        let userAgent = "Version/13.0.1 Safari/605.1.15"
//        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"
        request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
 */
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        webview.load(request)
    }

}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webview.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (html, error) in
            
            if let source = html {
                print(source)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
}

extension ViewController: WKUIDelegate {
    
}

