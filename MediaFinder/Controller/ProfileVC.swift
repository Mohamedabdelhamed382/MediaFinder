//
//  ProfileVC.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/21/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import UIKit
class ProfileVC: UIViewController {
    //MARK:- OutLets
    @IBOutlet weak var usernamelapel: UILabel!
    @IBOutlet weak var emaillapel: UILabel!
    @IBOutlet weak var adresslapel: UILabel!
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataInLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK:- Action
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(false, forKey: UserDefaultsKeys.isLoged)
        gotoLoginVC()
    }
}
//MARK:- Private Function
extension ProfileVC{
    private func setDataInLabel(){
        let data =  SqlLiteManger.shared().getDataUser()
        usernamelapel.text = data?.name
        emaillapel.text = data?.email
        adresslapel.text = data?.address
    }
    private func gotoLoginVC(){
        let sb = UIStoryboard(name: Storybord.main, bundle: nil)
        let viewLoginVC = sb.instantiateViewController(withIdentifier: ViewContllor.logvc)
        self.navigationController?.pushViewController(viewLoginVC, animated: true)
    }
}
