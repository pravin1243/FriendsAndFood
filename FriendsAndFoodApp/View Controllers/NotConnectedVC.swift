//
//  NotConnectedVC.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 24/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class NotConnectedVC: UIViewController {

    var fromWhere: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLogin(_ sender:Any){
          let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
          loginVC.isFirstLaunch = false
          self.navigationController?.pushViewController(loginVC, animated: true)
      }
      
      @IBAction func goToRegistration(_ sender: Any) {
          let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! FFRegistrationViewController
          registerVC.isFirstLaunch = false
          self.navigationController?.pushViewController(registerVC, animated: true)
      }
    
    @IBAction func backBtnTapped(_ sender :Any){
        if fromWhere == "profile"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    }

}
