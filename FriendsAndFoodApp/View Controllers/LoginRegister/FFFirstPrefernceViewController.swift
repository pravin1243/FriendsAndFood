//
//  FFFirstPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/30/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFFirstPrefernceViewController: UIViewController {

    @IBOutlet weak var nameButton:UIButton!
    @IBOutlet weak var welcomeLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FFBaseClass.sharedInstance.getUser() {
            nameButton.setTitle("\(StringConstants.userPreference.Hi) \(user.firstName ?? "")", for: .normal)
            welcomeLabel.text = "\(StringConstants.userPreference.welcometoFriendsFood)"

        }
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func skipButtonTapped(_ sender : Any){ // skip button action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSecondPrefernceVC") as! FFSecondPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }

}
