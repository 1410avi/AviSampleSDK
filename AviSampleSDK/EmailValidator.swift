//
//  EmailValidator.swift
//  AviSampleSDK
//
//  Created by Avinash Soni on 21/12/23.
//

import Foundation
import CashfreePGCoreSDK
import CashfreePGUISDK
import CashfreePG

public class EmailValidator {
    public static func validateEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
