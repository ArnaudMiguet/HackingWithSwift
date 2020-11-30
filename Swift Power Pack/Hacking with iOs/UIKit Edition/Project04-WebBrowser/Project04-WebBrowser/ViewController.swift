//
//  ViewController.swift
//  Project04-WebBrowser
//
//  Created by Arnaud Miguet on 30.11.20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    var website: String!
    
    // Legacy because of challenge 3
    // var websites = ["arnaudmiguet.ch", "hackingwithswift.com", "apple.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Legacy because of challenge 3
        // let url = URL(string: "https://" + websites[0])!
        let url = URL(string: "https://" + website)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        // Legacy because of challenge 3
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))

        toolbarItems = [backButton, forwardButton, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    // Legacy because of challenge 3
//    @objc
//    func openTapped() {
//        let ac = UIAlertController(title: "Open page :", message: nil, preferredStyle: .actionSheet)
//        for website in websites {
//            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
//        ac.addAction((UIAlertAction(title: "Cancel", style: .cancel)))
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(ac, animated: true)
//    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://"+action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if let host = url.host {
                // Legacy because of challenge 3
                // for website in websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                // }
            }
        }
        decisionHandler(.cancel)
        let av = UIAlertController(title: "Access denied", message: "You don't have the right to exit" + website + "from this page", preferredStyle: .alert)
        av.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(av, animated: true)
    }
}

