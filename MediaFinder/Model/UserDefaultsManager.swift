//
//  UserDefaultsManager.swift
//  constranints
//
//  Created by Mohamed Abdelhamed Ahmed on 12/25/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//
import Foundation
class UserDefaulsManager{
    //MARK:- Singleton Setup
    private static let sharedInstance = UserDefaulsManager()
    
    static func shared() -> UserDefaulsManager {
        return UserDefaulsManager.sharedInstance
    }
    //MARK:- Propreties
    var email: String?{
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.email)
        }
        get {
            guard (UserDefaults.standard.object(forKey:UserDefaultsKeys.email) != nil) else {
                return nil
            }
            return UserDefaults.standard.string(forKey:UserDefaultsKeys.email)!
        }
    }
}
