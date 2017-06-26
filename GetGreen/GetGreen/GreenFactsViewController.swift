//
//  GreenFactsViewController.swift
//  GetGreen
//
//  Created by Annie Tung on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class GreenFactsViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        let path = Bundle.main.path(forResource: "embedded", ofType: "html")
        let dir = URL(fileURLWithPath: Bundle.main.bundlePath)
        // loading the file to the internet onto our webview
        let myURL = URL(fileURLWithPath: path!)
        webView.loadFileURL(myURL, allowingReadAccessTo: dir)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupWebView() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
