//
//  Checkout.swift
//  AviSampleSDK
//
//  Created by Avinash Soni on 21/12/23.
//

import Foundation
import UIKit
import CashfreePGCoreSDK
import CashfreePGUISDK
import CashfreePG
import WebKit

public class Checkout: UIViewController, WKUIDelegate, CFResponseDelegate{
    
    public func onError(_ error: CashfreePGCoreSDK.CFErrorResponse, order_id: String) {
        print("ErrorResponse: ")
        print(order_id)
        print(error.status)
        print(error.description)
    }
    
    public func verifyPayment(order_id: String) {
        print("SuccessResponse: ")
        print(order_id)
    }
    
    
    private let cfPaymentGatewayService = CFPaymentGatewayService.getInstance()
    
    func openPG() {
        print("OpenPG Function")
        if let session = getSession() {
            do {
                
                // Set Components
                let paymentComponents = try CFPaymentComponent.CFPaymentComponentBuilder()
                    .enableComponents([
                        "order-details",
                        "card",
                        "paylater",
                        "wallet",
                        "emi",
                        "netbanking",
                        "upi"
                    ])
                    .build()
                
                // Set Theme
                let theme = try CFTheme.CFThemeBuilder()
                    .setPrimaryFont("Source Sans Pro")
                    .setSecondaryFont("Gill Sans")
                    .setButtonTextColor("#FFFFFF")
                    .setButtonBackgroundColor("#FF0000")
                    .setNavigationBarTextColor("#FFFFFF")
                    .setNavigationBarBackgroundColor("#FF0000")
                    .setPrimaryTextColor("#FF0000")
                    .setSecondaryTextColor("#FF0000")
                    .build()
                
                // Native payment
                let webCheckoutPayment = try CFWebCheckoutPayment.CFWebCheckoutPaymentBuilder()
                    .setSession(session)
//                    .setTheme(theme)
//                    .setComponent(paymentComponents)
                    .build()
                
                // Invoke SDK
                try self.cfPaymentGatewayService.doPayment(webCheckoutPayment, viewController: self)
                
                
            } catch let e {
                let error = e as! CashfreeError
                print(error.localizedDescription)
                // Handle errors here
            }
        }
    }
    
    var webView: WKWebView!
    
    public override func loadView() {
           let webConfiguration = WKWebViewConfiguration()
           webView = WKWebView(frame: .zero, configuration: webConfiguration)
           webView.uiDelegate = self
           view = webView
       }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.cfPaymentGatewayService.setCallback(self)
//        print("OpenPG")
//        openPG()
        
        let myURL = URL(string:"https://www.apple.com")
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
        
    }
    
    private func getSession() -> CFSession? {
            do {
                let session = try CFSession.CFSessionBuilder()
                    .setEnvironment(.SANDBOX)
                    .setPaymentSessionId("session_031Q82CLXytgN3I-6SQr2V1g2seyPWnYtFoCULGsTZnISqb-9LnN4PgJqvUADAzvEv86mCr5N_kXzSPm-Dc0foO28oWRnQgJZ27e64ijnAaI")
                    .setOrderID("2e2df7e6-a041-4b4c-8167-0a2e8d4d0650")
                    .build()
                return session
            } catch let e {
                let error = e as! CashfreeError
                print(error.localizedDescription)
                // Handle errors here
            }
            return nil
        }
    
    public static func validateEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
