//
//  FFDashboardViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 13/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Cosmos

class FFDashboardViewController: UIViewController {

    @IBOutlet weak var cosmosView:CosmosView!
    var restaurantdetail:[FFRestaurantObject]?
    var storedetail:FFStoreObject?    
    @IBOutlet weak var likeCountLabel:UILabel!
    @IBOutlet weak var reviewRatingLabel:UILabel!
    @IBOutlet weak var menuLabel:UILabel!

    @IBOutlet weak var reviewCountLabel:UILabel!
    @IBOutlet weak var menuCountLabel:UILabel!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var lastnameErrorLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!

    var emptyErrorMsg = StringConstants.Alert.Messages.fieldRequired
    var invalidErrorMsg = "Invalid field"
    
    var inviteRequest = FFInviteUserRequestModel()


    var isStore:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        if isStore == 1{
            callStoreDetailAPI()
            menuLabel.text = "Catalog"
        }else{

        callRestaurantDetailAPI()
            menuLabel.text = "Menu"

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
        if self.restaurantdetail?.count ?? 0 > 0 {
            cosmosView.rating = Double(self.restaurantdetail?[0].averagenotereviews ?? 0)
            reviewCountLabel.text = "\(self.restaurantdetail?[0].countreviews ?? 0) reviews"
            likeCountLabel.text = "\(self.restaurantdetail?[0].countlikes ?? 0)"
            menuCountLabel.text = "\(self.restaurantdetail?[0].countrecipesin_menu ?? 0)"
            reviewRatingLabel.text = "\(self.restaurantdetail?[0].averagenotereviews ?? 0)/5"
        }
    }
    
    func populateStoreData(){
        cosmosView.rating = Double(self.storedetail?.averagenotereviews ?? 0)
        reviewCountLabel.text = "\(self.storedetail?.countreviews ?? 0) reviews"
        likeCountLabel.text = "\(self.storedetail?.countlikes ?? 0)"
        menuCountLabel.text = "\(self.storedetail?.countproducts ?? 0)"
        reviewRatingLabel.text = "\(self.storedetail?.averagenotereviews ?? 0)/5"

    }
    
    func validateFields() -> Bool { // validating all the fields in the form
            
            var isValid = true
            firstNameErrorLabel.text = ""
            lastnameErrorLabel.text = ""
            emailErrorLabel.text = ""

            if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
                
                if !isValidEmail(email: email ){
                    emailErrorLabel.text = invalidErrorMsg
                    isValid =  false
                }else {
                        inviteRequest.email = email
                }
                
            }else {
                emailErrorLabel.text = emptyErrorMsg
                isValid =  false
            }
            return isValid
        }
    
    func isValidEmail(email: String) -> Bool { //  checking email validity
         let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
         let predicate = NSPredicate(format: "self matches %@", emailRegex)
         return predicate.evaluate(with: email)
     }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        if validateFields() {
        
            callInviteAPI()
        }
        
    }
    
    func callInviteAPI(){  //invite user webservice
        
        if let usr = FFBaseClass.sharedInstance.getUser() {
            
            inviteRequest.userid = usr.id
            if isStore == 1{
                inviteRequest.isStore = 1
                inviteRequest.storeid = usr.ownerofstore

                    }else{
                        inviteRequest.restaurantid = usr.ownerofrestaurant

                    }
        }
        print("invite api called..")
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.inviteUser(requestModel: self.inviteRequest, success: { (response) in
            print(response)
            FFBaseClass.sharedInstance.saveUser(user: response)
            FFLoaderView.hideInView(view: self.view)
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }

        
    }

}
