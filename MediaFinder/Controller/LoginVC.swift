//
//  LoginVC.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/21/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import UIKit
class LoginVC: UIViewController {
    //MARK:- Outlites
    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    //MARK:- Life Cycle method
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK:- Actions
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        goToSignUpVC()
    }
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if dataState() {
            gotoMovieVC()
        }
    }
}
//MARK:- Private Methods
extension LoginVC {
    private func goToSignUpVC(){
        let sb = UIStoryboard(name: Storybord.main, bundle: nil)
        let signUpVC = sb.instantiateViewController(withIdentifier: ViewContllor.signUpVC  )as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    private func gotoMovieVC(){
        let sb = UIStoryboard(name: Storybord.main , bundle: nil)
        let MyTableVC = sb.instantiateViewController(withIdentifier: ViewContllor.myTableVC)as! MyTableVC
        self.navigationController?.pushViewController(MyTableVC, animated: true)
    }
    //MARK:- Validation Functions
    private func isVaildData() -> Bool {
        guard (usernameTextFiled.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter Name ")
            return false
        }
        guard (passwordTextFiled.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter Password ")
            return false
        }
        return true
    }
    private func isVaildRegex() -> Bool {
        guard isValidName(name: usernameTextFiled.text!.trimmed)  else {
            alert(title: "Error", message: "Please Enter Vaild Name ")
            return false
        }
        guard isValidPassword(password: passwordTextFiled.text!.trimmed) else {
            alert(title: "Error", message: "Please Enter Vaild password ")
            return false
        }
        return true
    }
    //MARK:- Compare Data function
    private func compareData()->Bool{
        let data =  SqlLiteManger.shared().getDataUser()
        guard usernameTextFiled.text?.trimmed == data?.name && passwordTextFiled.text?.trimmed == data?.password else {
            print(data?.name,data?.password )
            
            alert(title: "Error", message: "Please Enter Vaild username or password  ")
            return false
        }
        return true
    }
    private func dataState() -> Bool{
        if isVaildData(){
            if isVaildRegex(){
                if compareData(){
                    return true
                }
            }
        }
        return false
    }
}
