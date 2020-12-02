//
//  DetailViewController.swift
//  Project07-WhitehousePetitions
//
//  Created by Arnaud Miguet on 01.12.20.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else {return}
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h1>\(detailItem.title)</h1>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
