//
//  WebViewController.swift
//  MetaNews
//
//  Created by Sean Thielen on 2/11/18.
//  Copyright © 2018 GoMeta. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    var pageTitle: String = ""
    var url: String = ""

    var webView: WKWebView!

    init(title: String, url: String) {
        super.init(nibName: nil, bundle: nil)
        self.pageTitle = title
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.pageTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(self.close))

        self.draw()
    }

    func draw() {
        self.view.backgroundColor = .white

        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)

        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
    }
}
