//
//  FFMenuViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/10/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuItems = [
        StringConstants.Menu.home,
     StringConstants.Menu.AllTheRecipes,
     StringConstants.Menu.stores,
     StringConstants.Menu.my_friends,
     StringConstants.bottomTab.EatWell,
     StringConstants.Menu.WhatILike,
     StringConstants.Menu.preferences,
     StringConstants.Menu.logout
    ]

    var imageItems =    [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "recipeList"),#imageLiteral(resourceName: "friends"),#imageLiteral(resourceName: "FavRestaurant"),#imageLiteral(resourceName: "eatwell"),#imageLiteral(resourceName: "FavRecipe"),#imageLiteral(resourceName: "preference-white"),#imageLiteral(resourceName: "Logout")]
    
    var selectedImage = [#imageLiteral(resourceName: "homeGreen"),#imageLiteral(resourceName: "recipeListGreen"),#imageLiteral(resourceName: "friendsGreen"),#imageLiteral(resourceName: "FavRestaurantGreen"),#imageLiteral(resourceName: "TopRecipeActive"),#imageLiteral(resourceName: "FavRecipeGreen"),#imageLiteral(resourceName: "preference-green"),#imageLiteral(resourceName: "LogoutGreen")]

    @IBOutlet weak var menuTableView:UITableView!
    @IBOutlet weak var loginBtn: UIButton!

    static var selectedRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        loginBtn.layer.cornerRadius = 3
        loginBtn.clipsToBounds = true
        
        SideMenuManager.default.menuPushStyle = .replace
//        SideMenuNavigationController.menu
        // Do any additional setup after loading the view.
    }
    
    func removeLogout() { // remove logout option from side menu
        if menuItems.count == 8 {
            menuItems.removeLast()
            imageItems.removeLast()
            selectedImage.removeLast()
        }
    }
    
    func addLogout(){ // add logout option in side menu
        if menuItems.count == 7 {
            menuItems.append("\(StringConstants.Menu.logout)")
            imageItems.append(#imageLiteral(resourceName: "Logout"))
            selectedImage.append(#imageLiteral(resourceName: "LogoutGreen"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { // if already login, add logout to side menu
        
        if let _ =  FFBaseClass.sharedInstance.getUser(){
            loginBtn.isHidden = true
            addLogout()
            
        }else {
            loginBtn.isHidden = false
            removeLogout()
        }
        menuTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            imageView.image = selectedImage[indexPath.row]
            nameLabel.textColor = UIColor.primary
            cell?.backgroundColor = UIColor.black
        }else {
            imageView.image = imageItems[indexPath.row]
            nameLabel.textColor = UIColor.white
            cell?.backgroundColor = UIColor.clear
        }
        
        nameLabel.text = menuItems[indexPath.row]
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FFMenuViewController.selectedRow = indexPath.row
        menuTableView.reloadData()

        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 1 {
            let entranceVC = self.storyboard?.instantiateViewController(withIdentifier: "entranceVC") as! FFEntranceListViewController
            entranceVC.isEatWell = false
            entranceVC.fromNonProfessionalHome = 1
            entranceVC.fromMenu = 1
            self.navigationController?.pushViewController(entranceVC, animated: true)
        }
        if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFMyStoreViewController") as! FFMyStoreViewController
            vc.fromMenu = true
            self.navigationController?.pushViewController(vc, animated: true)
               }
        if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendsVC") as! FFriendsListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 4 {
            let topRecipesVC = self.storyboard?.instantiateViewController(withIdentifier: "EatWellMenuVC") as! EatWellMenuViewController
            self.navigationController?.pushViewController(topRecipesVC, animated: true)
        }
        
        if indexPath.row == 5 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFWhatIlikeVC") as! FFWhatIlikeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        if indexPath.row == 6 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFPreferencesVC") as! FFPreferencesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 7 {
                  FFBaseClass.sharedInstance.clearUser()
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
                  self.navigationController?.pushViewController(vc, animated: true)
                  FFMenuViewController.selectedRow = 0
                  
              }

        dismiss(animated: true, completion: nil)
       
    }
    
    @IBAction func loginBtnTapped(_ sender : Any){ // login button action
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
        loginVC.isFirstLaunch = true
        self.navigationController?.pushViewController(loginVC, animated: true)
        
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
