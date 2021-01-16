//
//  Ragex.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/23/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController  {
    func isValidName(name: String ) -> Bool {
        let inputRegEx = "^[a-zA-Z\\_]{5,25}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:name)
    }
    func isValidEmail(email: String) -> Bool {
        let inputRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:email)
    }
    func isValidPhone(phone:String) -> Bool {
        let inputRegEx = "^((\\+)|(00))[0-9]{6,14}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:phone)
    }
    func isValidPassword(password : String) -> Bool {
        let inputRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_+={}?>.<,:;~`']{8,}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:password)
    }
    public func filterPhoneNumber(phone : String ) -> String {
        return String(phone.filter {!" ()._-\n\t\r".contains($0)})
    }
}
