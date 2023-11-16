//
//  FFNonProfessionalHomeViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 05/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class FFNonProfessionalHomeViewController: UIViewController, SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    var interestId:String?
    
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
        return 4
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        
        if index == 0 {
            return "\(StringConstants.nonProfessionalHome.Recipes)".uppercased()
        }else if index == 1 {
            return "\(StringConstants.nonProfessionalHome.Restaurants)".uppercased()
        }else if index == 2 {
            return "\(StringConstants.nonProfessionalHome.Commerces)".uppercased()
        }
        else {
            return "\(StringConstants.nonProfessionalHome.QA)".uppercased()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set viewcontrollers for the corresponding tabs
        let homeRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "FFHomeRecipeViewController") as! FFHomeRecipeViewController
        
        let restvc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
        restvc.isFavList = false
        restvc.fromHome = 1

        let FFMyStoreViewController = self.storyboard?.instantiateViewController(withIdentifier: "FFMyStoreViewController") as! FFMyStoreViewController
        FFMyStoreViewController.fromMenu = false
        FFMyStoreViewController.fromHome = 1
        let FFFAQViewController = self.storyboard?.instantiateViewController(withIdentifier: "FFFaqViewController") as! FFFaqViewController

        if index == 0 {
            addChild(homeRecipeVC)
            return homeRecipeVC
        }else if index == 1 {
            addChild(restvc)
            return restvc
        }else if index == 2 {
            addChild(FFMyStoreViewController)
            return FFMyStoreViewController
        }
        else {
            addChild(FFFAQViewController)
            return FFFAQViewController
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
