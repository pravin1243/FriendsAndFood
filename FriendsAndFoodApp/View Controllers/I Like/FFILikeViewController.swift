//
//  FFILikeViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 30/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import SideMenu
class FFILikeViewController: UIViewController,SwipeMenuViewDataSource, SwipeMenuViewDelegate, TabViewDelegate {

      @IBOutlet weak var swipeMenuView: SwipeMenuView!
        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            // Do any additional setup after loading the view.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                swipeMenuView.dataSource = self
                swipeMenuView.delegate = self
        swipeMenuView.tabView?.tabViewDelegate = self
                var options: SwipeMenuViewOptions = .init()
        //        options.tabView.underlineView.backgroundColor = UIColor.primary
                options.tabView.style = .segmented
                
                swipeMenuView.reloadData(options: options)
                
                navigationController?.navigationBar.tintColor = UIColor.white
          //  customiseNavBar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)

    }
    
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    func customiseNavBar(){ // add search and filter button in navigation bar
        self.title = "\(StringConstants.iLike.Ilike)"
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let filterBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn)
        
        self.navigationItem.rightBarButtonItems = [searchButton]
    }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
            return 3
        }
        
        func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String { // set title for swipe menu tabs
            
            if index == 0 {
                return "\(StringConstants.bottomTab.Thematic)"
            }else if index == 1{
                return "\(StringConstants.iLike.Ingredients)"
            }
            else {
                return "\(StringConstants.iLike.Interests)"
            }
        }
        
        func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set view controller for eachh tab
          
            let myCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCategoriesVC") as! FFMyCategoriesViewController
            let myIngredientsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyIngredientsVC") as! FFMyIngredientsViewController
            let myInterestsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyInterestsVC") as! FFMyInterestsViewController

            
            if index == 0 {
                addChild(myCategoriesVC)
                return myCategoriesVC
            }else if index == 1{
                addChild(myIngredientsVC)
                return myIngredientsVC
            }
            else {
                addChild(myInterestsVC)
                return myInterestsVC
            }
        }



}
