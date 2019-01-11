//
//  WikiViewController.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: BaseViewController {
    
    private var url: URL!
    @IBOutlet var webView: WKWebView!
    
    static func create(url: URL) -> WikiViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WikiViewController") as! WikiViewController
        vc.url = url
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wiki"
        webView.load(URLRequest(url: url))
    }
}
