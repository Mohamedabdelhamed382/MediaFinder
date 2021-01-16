//
//  AppDelegate.swift
//  constranints
//
//  Created by Mohamed Abdelhamed Ahmed on 12/14/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func setRootVC(){
        let isloged = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoged)
        let sb = UIStoryboard(name: Storybord.main, bundle: nil)
        if isloged{
            let rootVC = sb.instantiateViewController(withIdentifier: ViewContllor.myTableVC)as!MyTableVC
            let navigationcontroller = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationcontroller
        }else{
            let rootVC = sb.instantiateViewController(withIdentifier: ViewContllor.signUpVC)as!SignUpVC
            let navigationcontroller = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationcontroller
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)-> Bool {
        SqlLiteManger.shared().setUpDatabase()
        IQKeyboardManager.shared.enable = true
        setRootVC()
        return true
    }
}
