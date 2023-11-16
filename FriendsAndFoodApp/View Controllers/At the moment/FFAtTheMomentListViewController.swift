//
//  AtTheMomentListViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController


class FFAtTheMomentListViewController: UIViewController, SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    var interestId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
//        options.tabView.underlineView.backgroundColor = UIColor.primary
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)
        customiseNavBar()
    }
    func customiseNavBar(){ //add filter and search button in navigation bar
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "BackIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showLeft)), animated: true)

                        self.title = "Recipes"

        }
    @objc func showLeft(){
        self.navigationController?.popViewController(animated: true)
         }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    
        override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 3
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        
        if index == 0 {
            return "\(StringConstants.Labels.Entrances)".uppercased()
        }else if index == 1 {
            return "\(StringConstants.Labels.Dishes)".uppercased()
        }else {
            return "\(StringConstants.Labels.Desserts)".uppercased()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set viewcontrollers for the corresponding tabs
        let entranceVC = self.storyboard?.instantiateViewController(withIdentifier: "entranceVC") as! FFEntranceListViewController
        entranceVC.isEatWell = false
        entranceVC.interestId = self.interestId
        let dishesVC = self.storyboard?.instantiateViewController(withIdentifier: "dishesVC") as! FFDishesListViewController
        dishesVC.isEatWell = false
        dishesVC.interestId = self.interestId
        let dessertsVC = self.storyboard?.instantiateViewController(withIdentifier: "dessertsVC") as! FFDessertsListViewController
        dessertsVC.isEatWell = false
        dessertsVC.interestId = self.interestId
        
        if index == 0 {
            addChild(entranceVC)
            return entranceVC
        }else if index == 1 {
            addChild(dishesVC)
            return dishesVC
        }else {
            addChild(dessertsVC)
            return dessertsVC
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
