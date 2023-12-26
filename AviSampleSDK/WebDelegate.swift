//
//  WebDelegate.swift
//  AviSampleSDK
//
//  Created by Avinash Soni on 26/12/23.
//

import Foundation

protocol WebDelegate{
    func sdSuccess(data: [String: Any]?)
    func sdCancel(data: [String: Any]?)
}
