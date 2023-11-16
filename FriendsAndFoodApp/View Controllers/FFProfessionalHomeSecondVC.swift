//
//  FFProfessionalHomeSecondVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 13/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFProfessionalHomeSecondVC: UIViewController {
    var restaurantdetail:[FFRestaurantObject]?
    var storedetail:FFStoreObject?
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var restNameLbl:UILabel!
    var isStore:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isStore == 1{
            callStoreDetailAPI()
            
        }else{
            
            callRestaurantDetailAPI()
        }            // Do any additional setup after loading the view.
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
            if let photo = restaurantdetail?[0].imageLarge {
                let imageUrl:URL = URL(string: photo)!
                imgView.kf.setImage(with: imageUrl)
            }
            restNameLbl.text = "\(self.restaurantdetail?[0].name ?? "")"
        }
    }
    func populateStoreData(){
        if let photo = self.storedetail?.imageLarge {
            let imageUrl:URL = URL(string: photo)!
            imgView.kf.setImage(with: imageUrl)
        }
        restNameLbl.text = "\(self.storedetail?.name ?? "")"
    }
    @IBAction func updateBtnTapped(_ sender :Any ){ // see ore button ction
        if isStore == 1{
            
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetailVC") as! FFStoreDetailViewController
                       vc.storeID = self.storedetail?.id
                    
                    vc.cityId = self.storedetail?.cityId

                       self.navigationController?.pushViewController(vc, animated: true)

        }else{
            

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! FFRestaurantDetailViewController
        vc.restaurantID = self.restaurantdetail?[0].id
        vc.cityId = self.restaurantdetail?[0].cityId
        self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
