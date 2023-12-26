//
//  GQPaymentSDK.swift
//  AviSampleSDK
//
//  Created by Avinash Soni on 21/12/23.
//

import UIKit

public protocol GQSDKDelegate{
    func onSuccess(data: [String: Any])
    func onFailed(data: [String: Any])
    func onCancel(data: [String: Any])
}

public class GQPaymentSDK: UIViewController, WebDelegate {
    func sdSuccess(data: [String : Any]?) {
        print("sdSucess web callback with data: \(String(describing: data))")
        delegate?.gqSuccessResponse(data: data)
    }
    
    func sdCancel(data: [String : Any]?) {
        print("sdCancel web callback received with data: \(String(describing: data))")
    }
    
    public var delegate: GQPaymentDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let successData: [String: Any] = ["Status": "Success"]
        let failedData: [String: Any] = ["Status": "Failed"]
        let cancelData: [String: Any] = ["Status": "Cancel"]

        // Simulate a successful scenario
        delegate?.gqSuccessResponse(data: successData)

        // Simulate a failure scenario
        self.delegate?.gqFailureResponse(data: failedData)

        // Simulate a cancellation scenario
        self.delegate?.gqCancelResponse(data: cancelData)
        
        let con: [String: Any] = [
            "client_id": "itsclientid",
            "client_secret": "itsclientsecret"
        ]
        
        let gqWebView = GQWebView()
        gqWebView.webDelegate = self
        DispatchQueue.main.async {
            self.present(gqWebView, animated: true, completion: nil)
        }
    }
    
    public var onSuccess: (([String: Any]) -> Void)?
    public var onFailed: (([String: Any]) -> Void)?
    public var onCancel: (([String: Any]) -> Void)?
}
