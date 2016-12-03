//
//  WebViewController.swift
//  BoutTimeTH
//
//  Created by Jari Koopman on 02/12/2016.
//  Copyright © 2016 JarICT. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var url: String!
    var objectTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = objectTitle
        webView.loadRequest(URLRequest(url: URL(string: url)!))

        // Do any additional setup after loading the view.
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
