//
//  FFProfessionalHomeThirdVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 13/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFProfessionalHomeThirdVC: UIViewController {
    @IBOutlet weak var restNameLbl:UILabel!
    @IBOutlet weak var menuLbl:UILabel!
    @IBOutlet weak var sendButton:UIButton!
    var restaurantdetail:[FFRestaurantObject]?
    var storedetail:FFStoreObject?
    @IBOutlet weak var imgView:UIImageView!
    var isStore:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
         if isStore == 1{
             callStoreDetailAPI()
             
         }else{
             
             callRestaurantDetailAPI()
         }
                // Do any additional setup after loading the view.
            }
            
            func callRestaurantDetailAPI() { // restaurant detail webservice integration
                if let usr = FFBaseClass.sharedInstance.getUser() {
                    FFManagerClass.getRestaurantDetail(id: usr.ownerofrestaurant, success: { (response) in
                              self.restaurantdetail = response.restaurantDetailArray
                              self.populateData()
                          }) { (error) in
                              FFBaseClass.sharedInstance.showError(error: error, view: self)
                          }
                       }
            }
    
    
    func callStoreDetailAPI() { // restaurant detail webservice integration
        if let usr = FFBaseClass.sharedInstance.getUser() {
            
            FFManagerClass.getStoreDetail(id: usr.ownerofstore, success: { (response) in
                self.storedetail = response
                self.populateStoreData()
            }) { (error) in
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
    }
            func populateData(){
                if restaurantdetail?.count ?? 0 > 0 {
                    if let photo = restaurantdetail?[0].imageMedium {
                        let imageUrl:URL = URL(string: photo)!
                        imgView.kf.setImage(with: imageUrl)
                    }
                    restNameLbl.text = "\(self.restaurantdetail?[0].name ?? "")"
                    if let menu = self.restaurantdetail?[0].countrecipesin_menu{
                        if menu == 0{
                            menuLbl.text = "Start filling the menu in order to get new clients"
                            sendButton.setTitle("Add new recipes in the menu", for: .normal)
                        }
                        if menu == 1{
                            menuLbl.text = "\(menu) recipe in the menu"
                            sendButton.setTitle("Manage recipes in the menu", for: .normal)
                        }
                        if menu > 1{
                            menuLbl.text = "\(menu) recipes in the menu"
                            sendButton.setTitle("Manage recipes in the menu", for: .normal)
                        }
                    }
                }
            }
    
    func populateStoreData(){
            if let photo = self.storedetail?.imageMedium {
                          let imageUrl:URL = URL(string: photo)!
                          imgView.kf.setImage(with: imageUrl)
                      }
            restNameLbl.text = "\(self.storedetail?.name ?? "")"
        if let products = self.storedetail?.countproducts{
            if products == 0{
                menuLbl.text = "Start filling the catalog in order to get new clients"
                sendButton.setTitle("Add new product", for: .normal)
            }
            if products == 1{
                menuLbl.text = "\(products) product in the catalog"
                sendButton.setTitle("Manage my catalog", for: .normal)
            }
            if products > 1{
                menuLbl.text = "\(products) products in the catalog"
                sendButton.setTitle("Manage my catalog", for: .normal)
            }
        }

    }
    

  @IBAction func updateBtnTapped(_ sender :Any ){ // see ore button ction
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! FFRestaurantDetailViewController
           vc.restaurantID = self.restaurantdetail?[0].id
           vc.cityId = self.restaurantdetail?[0].cityId
           self.navigationController?.pushViewController(vc, animated: true)

       }
}
