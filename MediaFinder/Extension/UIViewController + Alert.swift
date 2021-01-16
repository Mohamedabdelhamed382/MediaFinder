//
//  UIViewController + Alert.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/25/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController  {

    func alert (title: String, message: String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
