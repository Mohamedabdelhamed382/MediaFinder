//
//  SignUpVC.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/21/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import UIKit
import SQLite
class SignUpVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var userNameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var addressTextFeild: UITextField!
    @IBOutlet weak var phoneNumberTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var gotoLoginVCBtnTappedZoom: UIButton!
    //MARK:- Propreties
    var gender: Gender = .male
    var userData: User!
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        SqlLiteManger.shared().createTabelDataUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK:- Action Method
    @IBAction func setAddressBtbTapped(_ sender: UIButton) {
        gotoMapVC()
    }
    @IBAction func genderSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            gender = .female
        }else{
            gender = .male
        }
    }
    @IBAction func gotoLoginVCBtnTapped(_ sender: UIButton) {
        if isDataEnterd() {
            SqlLiteManger.shared().insertUser(userData: userData)
            //            print(userData.name! , userData.password!)
            setupAnimation()
            gotoLoginVC()
        }else{
            print("Error")
        }
    }
    @IBAction func alreadyHaveAnAccountBtnTapped(_ sender: UIButton) {
        gotoLoginVC()
    }
}

//MARK:- MapCenterDelegate
extension SignUpVC: MapCenterDelegate {
    func setDelailLocationInAddress(delailsAddress: String) {
        addressTextFeild.text = delailsAddress
        print(delailsAddress)
    }
}

//MARK:- Private Methods
extension SignUpVC {
    // To make sure that the data is free of extra space and notempty
    private func isVaildData() -> Bool {
        guard (userNameTextFeild.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter Name ")
            return false
        }
        guard (emailTextFeild.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter Email ")
            return false
        }
        guard (addressTextFeild.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter Address ")
            return false
        }
        guard (phoneNumberTextFeild.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter PhoneNumber")
            return false
        }
        guard (passwordTextFeild.text?.trimmed) != "" else {
            alert(title: "Error", message: "Please Enter password")
            return false
        }
        return true
    }
    // To make sure that the data is free of invailddata
    private func isVaildRegex()->Bool{
        guard isValidName(name: userNameTextFeild.text!.trimmed)  else {
            alert(title: "Error", message: "Please Enter Vaild Name  ")
            return false
        }
        guard isValidEmail(email: emailTextFeild.text!.trimmed)else{
            alert(title: "Error", message: "Please Enter Vaild Name ")
            return false
        }
        guard isValidPassword(password: passwordTextFeild.text!.trimmed) else {
            alert(title: "Error", message: "Please Enter Vaild password ")
            return false
        }
        guard isValidPhone(phone: filterPhoneNumber(phone: phoneNumberTextFeild.text!)) else {
            alert(title: "Error", message: "Please Enter Vaild phone ")
            return false
        }
        return true
    }
    // To make sure that the data is free of invailddata
    private func isDataEnterd() -> Bool{
        if isVaildRegex(){
            if  isVaildData(){
                enterDataInObject()
                return true
            }
        }
        return false
    }
    private func enterDataInObject(){
        if let Name = userNameTextFeild.text?.trimmed,let email = emailTextFeild.text?.trimmed, let address = addressTextFeild.text?.trimmed,let password = passwordTextFeild.text?.trimmed,let phoneNumber = phoneNumberTextFeild.text?.trimmed {
            userData = User(name: Name, email: email, address: address, password: password, phoneNumber: phoneNumber, gender: gender)
            print(userData!)
        }
    }
    private func gotoLoginVC(){
        let mainStorybord = UIStoryboard(name: Storybord.main, bundle: nil)
        let logvc = mainStorybord.instantiateViewController(withIdentifier: ViewContllor.logvc)
        self.navigationController?.pushViewController(logvc, animated: true)
    }
    private func gotoMapVC(){
        let mainStorybord = UIStoryboard(name: Storybord.main, bundle: nil)
        let mapVC = mainStorybord.instantiateViewController(withIdentifier: ViewContllor.mapVC)as! MapVC
        mapVC.delegate = self
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    //MARK:- Animation
    private func setupAnimation(){
        userNameTextFeild.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 1.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.userNameTextFeild.center.x = self.view.frame.width / 2
        }, completion:nil)
        emailTextFeild.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 2.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.emailTextFeild.center.x = self.view.frame.width / 2
        }, completion:nil)
        addressTextFeild.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 3.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.addressTextFeild.center.x = self.view.frame.width / 2
        }, completion:nil)
        phoneNumberTextFeild.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 4.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.phoneNumberTextFeild.center.x = self.view.frame.width / 2
        }, completion:nil)
        passwordTextFeild.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 5.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.passwordTextFeild.center.x = self.view.frame.width / 2
        }, completion:nil)
        // zooming animation
        UIView.animate(withDuration: 0.5, animations: {
            self.gotoLoginVCBtnTappedZoom.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.20, animations: {
                self.gotoLoginVCBtnTappedZoom.transform = CGAffineTransform.identity
            })
        })
    }
}

