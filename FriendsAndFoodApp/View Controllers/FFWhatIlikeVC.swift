//
//  FFWhatIlikeVC.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/24/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFWhatIlikeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuTableView:UITableView!
    var menuItems = [
        StringConstants.Menu.i_like,StringConstants.Menu.my_recipes,StringConstants.Menu.my_preferred_restaurants,StringConstants.Menu.my_favorite
    ]
    
       var imageItems = [#imageLiteral(resourceName: "FavRecipeGreen"),#imageLiteral(resourceName: "recipeListGreen"),#imageLiteral(resourceName: "FavRestaurantGreen"),#imageLiteral(resourceName: "FavRecipeGreen")]

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
        customiseNavBar()
        menuTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
        
    func customiseNavBar(){ //add filter and search button in navigation bar
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)

        self.title = "\(StringConstants.Menu.WhatILike)"
        }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

      //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        let imageView = cell?.viewWithTag(100) as! UIImageView
         let nameLabel = cell?.viewWithTag(200) as! UILabel
        if FFMenuViewController.selectedRow == indexPath.row {
            imageView.image = imageItems[indexPath.row]
            nameLabel.textColor = UIColor.primary
//            cell?.backgroundColor = UIColor.black
        }else {
            imageView.image = imageItems[indexPath.row]
            nameLabel.textColor = UIColor.primary
            cell?.backgroundColor = UIColor.clear
        }
        nameLabel.text = menuItems[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FFMenuViewController.selectedRow = indexPath.row
        menuTableView.reloadData()
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFILikeViewController") as!
            FFILikeViewController
            self.navigationController?.pushViewController(vc, animated: true)
               }
        if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyRecipesVC") as! FFMyRecipesViewController
            self.navigationController?.pushViewController(vc, animated: true)
              }
        if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
            vc.isFavList = true
//            vc.fromMenu = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
              }
        if indexPath.row == 3 {
            FFBaseClass.sharedInstance.currentFavouriteIndex = 0
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFMyFavouriteViewController") as! FFMyFavouriteViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }

    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 62
    }
}
