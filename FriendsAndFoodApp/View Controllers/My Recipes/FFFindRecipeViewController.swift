//
//  FFFindRecipeViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

protocol findRecipeDelegate {
    func didFinishedRecipeFilter(isSearchResult: Bool,recipeList:[FFEntranceObject], selectedinterest:FFRecipeTypeObject?, selectedcategory:FFRecipeTypeObject?, selectedrecipeType:FFRecipeTypeObject?, searchText: String)
}

class FFFindRecipeViewController: UIViewController,UITextFieldDelegate {
    var delegate: findRecipeDelegate! = nil

    @IBOutlet weak var searchTermTextField:UITextField!
    @IBOutlet weak var recipeTypeTextField:UITextField!

    @IBOutlet weak var categoryTextField:UITextField!
    @IBOutlet weak var interestTextField:UITextField!
    var recipeTypeList:[FFRecipeTypeObject] = []

    var interestList:[FFRecipeTypeObject] = []
    var categoryList:[FFRecipeTypeObject] = []
    var selectedrecipeType:FFRecipeTypeObject?

    var selectedcategory:FFRecipeTypeObject?
    var selectedinterest:FFRecipeTypeObject?

    let dropDown = DropDown()
    var currentTextField:UITextField?
    var fromWhere: String?
    @IBOutlet weak var searchView:UIView!
    var searchText:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromWhere == "filter"{
                  searchView.isHidden = true
            self.title = "\(StringConstants.Labels.AdvancedRecipeSearch)"
              }else{
                  self.title = "Search Recipe"
              }
        
                if let search = searchText {
                    searchTermTextField.text = search
                }
                
                if let ctry = selectedcategory {
                    categoryTextField.text = ctry.name
                }
                if let interest  = selectedinterest {
                    interestTextField.text = interest.name
                }
                if let recipeType  = selectedrecipeType {
                    recipeTypeTextField.text = recipeType.name
                }

        categoryTextField.delegate = self
        interestTextField.delegate = self
        recipeTypeTextField.delegate = self

        customiseDropDown()
        getCategories()
        getInterests()
        getRecipeType()
        // Do any additional setup after loading the view.
    }
    

   func getInterests(){ // interetst list webservice
           FFLoaderView.showInView(view: self.view)
           FFManagerClass.getInterestList(success: { (response) in
               print(response)
               self.interestList = response
               FFLoaderView.hideInView(view: self.view)
               DispatchQueue.main.async {
               }
               
               
           }) { (error) in
               print(error)
               FFBaseClass.sharedInstance.showError(error: error, view: self)
               FFLoaderView.hideInView(view: self.view)
           }
       }
       
       func getCategories(){ // categories webservice
           
           FFLoaderView.showInView(view: self.view)
           FFManagerClass.getDishesList(id: "", success: { (response) in
               print(response)
               self.categoryList = response
               FFLoaderView.hideInView(view: self.view)
               self.dropDown.dataSource = self.categoryList.map { $0.name! }
               self.dropDown.reloadAllComponents()


           }) { (error) in
               print(error)
               FFLoaderView.hideInView(view: self.view)
               FFBaseClass.sharedInstance.showError(error: error, view: self)
           }
       }
    
    
    func getRecipeType(){ // categories webservice
              
              FFLoaderView.showInView(view: self.view)
              FFManagerClass.getRecipeTypeList( success: { (response) in
                  print(response)
                  self.recipeTypeList = response
                  FFLoaderView.hideInView(view: self.view)
                  self.dropDown.dataSource = self.categoryList.map { $0.name! }
                  self.dropDown.reloadAllComponents()


              }) { (error) in
                  print(error)
                  FFLoaderView.hideInView(view: self.view)
                  FFBaseClass.sharedInstance.showError(error: error, view: self)
              }
          }
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
            
            
            if currentTextField == categoryTextField {
                dropDown.anchorView = categoryTextField
                dropDown.dataSource = self.categoryList.map { $0.name! }
            }else if currentTextField == interestTextField {
                dropDown.anchorView = interestTextField
                dropDown.dataSource = self.interestList.map { $0.name! }
            }else if currentTextField == recipeTypeTextField {
                dropDown.anchorView = recipeTypeTextField
                dropDown.dataSource = self.recipeTypeList.map { $0.name! }
            }
            
            dropDown.direction = .any
            dropDown.selectionAction = { (index: Int, item: String) in
                self.currentTextField?.text = item
                self.dropDown.hide()
                
                if self.currentTextField == self.categoryTextField {
                    self.selectedcategory = self.categoryList[index]

                }else if self.currentTextField == self.interestTextField {
                    self.selectedinterest = self.interestList[index]
                }else if self.currentTextField == self.recipeTypeTextField {
                    self.selectedrecipeType = self.recipeTypeList[index]
                }
                
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
            currentTextField = textField
            self.dropDown.hide()
    
            self.dropDown.anchorView = currentTextField
            if textField == categoryTextField {
                self.dropDown.dataSource = self.categoryList.map { $0.name! }
                self.dropDown.reloadAllComponents()
                self.dropDown.show()
            }else if textField == interestTextField {
                self.dropDown.dataSource = self.interestList.map { $0.name! }
                self.dropDown.reloadAllComponents()
                self.dropDown.show()
            }else if textField == recipeTypeTextField {
                self.dropDown.dataSource = self.recipeTypeList.map { $0.name! }
                self.dropDown.reloadAllComponents()
                self.dropDown.show()
            }
        }
    
    @IBAction func searchButtonPressed(_ sender: Any){
        if let user = FFBaseClass.sharedInstance.getUser() {
            callSearchMyRecipesAPI(user: user)
        }
    }
    
    func callSearchMyRecipesAPI(user:FFUserObject){ // recipe list webservice
         
         FFLoaderView.showInView(view: self.view)
        FFManagerClass.searchMyRecipesList(recipeTypeId:selectedrecipeType?.id, userID: user.id,categoryID:selectedcategory?.id,interestID :selectedinterest?.id, success: { (response) in
             print(response)

//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyRecipesVC") as! FFMyRecipesViewController
//            let vc = self.navigationController?.viewControllers[0] as! FFMyRecipesViewController
//            vc.isSearchResult = true
//            vc.recipeList = response
//            vc.selectedinterest = self.selectedinterest
//            vc.selectedcategory = self.selectedcategory
//            vc.selectedrecipeType = self.selectedrecipeType
//            vc.searchText = self.searchTermTextField.text ?? ""
            self.navigationController?.popViewController(animated: true)
            self.delegate.didFinishedRecipeFilter(isSearchResult: true, recipeList: response, selectedinterest: self.selectedinterest, selectedcategory: self.selectedcategory, selectedrecipeType: self.selectedrecipeType, searchText: self.searchTermTextField.text ?? "")
            
         }) { (error) in
             print(error)
             FFLoaderView.hideInView(view: self.view)
             FFBaseClass.sharedInstance.showError(error: error, view: self)
         }
         
     }
     
        @IBAction func catButtonPressed(_ sender: Any){
//            if countryTextField.text == ""{
//                FFBaseClass.sharedInstance.showAlert(mesage: "Please select country", view: self)
//
//            }else{
                currentTextField = categoryTextField
    //            self.dropDown.hide()
                self.dropDown.anchorView = currentTextField
                self.dropDown.dataSource = self.categoryList.map { $0.name! }
                self.dropDown.reloadAllComponents()
                self.dropDown.show()

//            }
        }
        @IBAction func interestButtonPressed(_ sender: Any){
//            if countryTextField.text == ""{
//                FFBaseClass.sharedInstance.showAlert(mesage: "Please select a country first", view: self)
//
//            }else{
                currentTextField = interestTextField
    //            self.dropDown.hide()
                self.dropDown.anchorView = currentTextField
                self.dropDown.dataSource = self.interestList.map { $0.name! }
                self.dropDown.reloadAllComponents()
                self.dropDown.show()

          //  }
        }
    
           @IBAction func recipeTypeButtonPressed(_ sender: Any){
    //            if countryTextField.text == ""{
    //                FFBaseClass.sharedInstance.showAlert(mesage: "Please select a country first", view: self)
    //
    //            }else{
                    currentTextField = recipeTypeTextField
        //            self.dropDown.hide()
                    self.dropDown.anchorView = currentTextField
                    self.dropDown.dataSource = self.recipeTypeList.map { $0.name! }
                    self.dropDown.reloadAllComponents()
                    self.dropDown.show()

              //  }
            }
       
}
