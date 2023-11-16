//
//  FFMyFavouriteViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 30/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import SideMenu
class FFMyFavouriteViewController: UIViewController,SwipeMenuViewDataSource, SwipeMenuViewDelegate, TabViewDelegate {

      @IBOutlet weak var swipeMenuView: SwipeMenuView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            swipeMenuView.dataSource = self
            swipeMenuView.delegate = self
    swipeMenuView.tabView?.tabViewDelegate = self
            var options: SwipeMenuViewOptions = .init()
    //        options.tabView.underlineView.backgroundColor = UIColor.primary
            options.tabView.style = .segmented
            swipeMenuView.reloadData(options: options)
            
            navigationController?.navigationBar.tintColor = UIColor.white
        //customiseNavBar()
            self.title = "\(StringConstants.Menu.my_favorite)"
            // Do any additional setup after loading the view.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if FFBaseClass.sharedInstance.currentFavouriteIndex == 1 || FFBaseClass.sharedInstance.currentFavouriteIndex == 2
        {
            
        }else
        {
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)
        }
     
    }
    
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    func customiseNavBar(){ // add search and filter button in navigation bar
        
        self.title = "\(StringConstants.favourites.Favoriteslist)"
        
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
        
        self.navigationItem.rightBarButtonItems = [filterButton, searchButton]
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
                return "\(StringConstants.favourites.MYRECIPE)".uppercased()
            }else if index == 1{
                return "\(StringConstants.favourites.MyStore)".uppercased()
            }
            else {
                return "\(StringConstants.favourites.MyFollowers)".uppercased()
            }
        }
        
        func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set view controller for eachh tab
          
            let MyFavRecipesVC = self.storyboard?.instantiateViewController(withIdentifier: "MyFavRecipesVC") as! FFMyFavoriteRecipesViewController
            let FFMyStoreViewController = self.storyboard?.instantiateViewController(withIdentifier: "FFMyStoreViewController") as! FFMyStoreViewController
            FFMyStoreViewController.fromMenu = false
            let myFavFreinds = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC") as! FFFollowViewController
            if let usr = FFBaseClass.sharedInstance.getUser(){
                myFavFreinds.userId = usr.id
            }
            if index == 0 {
                addChild(MyFavRecipesVC)
                return MyFavRecipesVC
            }else if index == 1{
                addChild(FFMyStoreViewController)
                return FFMyStoreViewController
            }
            else {
                addChild(myFavFreinds)
                return myFavFreinds
            }
        }



}
