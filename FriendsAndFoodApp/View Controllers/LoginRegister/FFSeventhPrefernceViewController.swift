//
//  FFSeventhPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/7/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFSeventhPrefernceViewController: UIViewController {
    @IBOutlet weak var headLabel:UILabel!
    @IBOutlet weak var subheadLabel:UILabel!
    @IBOutlet weak var skipButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        headLabel.text = "\(StringConstants.userPreference.Welldone)"
        subheadLabel.text = "\(StringConstants.userPreference.YourFriendsFoodaccountisperfectlyconfigured)"
        skipButton.setTitle("\(StringConstants.userPreference.Everythingsuitsme)", for: .normal)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func skipAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
        self.navigationController?.pushViewController(vc, animated: true)
        

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    @IBAction func nextButton(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
