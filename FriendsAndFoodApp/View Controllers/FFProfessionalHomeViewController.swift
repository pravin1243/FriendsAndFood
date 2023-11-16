//
//  FFProfessionalHomeViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 09/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class FFProfessionalHomeViewController: UIViewController, SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    var interestId:String?
    var isStore:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
//        options.tabView.underlineView.backgroundColor = UIColor.primary
        options.tabView.style = .segmented
        options.tabView.itemView.font = UIFont.boldSystemFont(ofSize: 12.0)
        swipeMenuView.reloadData(options: options)
        
    }
    
  
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 3
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        
        if index == 0 {
            return "Dashboard".uppercased()
        }else if index == 1 {
            if isStore == 1{
                if let usr = FFBaseClass.sharedInstance.getUser() {

                    return "\(usr.storetype ?? "")".uppercased()
                }else{
                    return ""
                }

            }else{
            return "Restaurants".uppercased()
            }
        }else {
            if isStore == 1{
                return "Catalog".uppercased()

            }else{
            return "Menu".uppercased()
            }
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set viewcontrollers for the corresponding tabs
        let homeRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "FFDashboardViewController") as! FFDashboardViewController
        homeRecipeVC.isStore = isStore
        let homesecond = self.storyboard?.instantiateViewController(withIdentifier: "FFProfessionalHomeSecondVC") as! FFProfessionalHomeSecondVC
        homesecond.isStore = isStore

        let homethird = self.storyboard?.instantiateViewController(withIdentifier: "FFProfessionalHomeThirdVC") as! FFProfessionalHomeThirdVC
        homethird.isStore = isStore

        if index == 0 {
            addChild(homeRecipeVC)
            return homeRecipeVC
        }else if index == 1 {
            addChild(homesecond)
            return homesecond
        }else {
            addChild(homethird)
            return homethird
        }

    }
   
   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
