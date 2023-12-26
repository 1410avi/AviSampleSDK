//
//  CheckoutViewController.swift
//  AviSampleSDK
//
//  Created by Avinash Soni on 21/12/23.
//

import UIKit

public class CheckoutViewController: UIViewController, UIWebViewDelegate {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CheckoutViewController")

        let webV    = UIWebView()
            webV.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            webV.loadRequest(NSURLRequest(url: NSURL(string: "https://www.apple.com")! as URL) as URLRequest)
            webV.delegate = self
            self.view.addSubview(webV)
    }

}
