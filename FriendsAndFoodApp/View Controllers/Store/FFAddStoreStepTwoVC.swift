//
//  FFAddStoreStepTwoVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 04/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown
class FFAddStoreStepTwoVC: FFSuggestStoreBaseController,UITextFieldDelegate {
    @IBOutlet weak var estNameTextField:UITextField!

    @IBOutlet weak var countryTextField:UITextField!
    @IBOutlet weak var cityTextField:UITextField!

    @IBOutlet weak var postalTextField:UITextField!

    @IBOutlet weak var nameStreetTextField:UITextField!
    @IBOutlet weak var addressAdditionTextField:UITextField!

    @IBOutlet weak var phoneTextField:UITextField!
    @IBOutlet weak var restEmailTextField:UITextField!
    @IBOutlet weak var websitetTextField:UITextField!
    @IBOutlet weak var facebookTextField:UITextField!

    var selectedCountry:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    var currentTextField:UITextField?
    let dropDown = DropDown()

    var countryList:[FFPlaceObject] = []
    var cityList:[FFPlaceObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.delegate = self
        cityTextField.delegate = self
        getCountriesList()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
              self.navigationController?.setNavigationBarHidden(false, animated: animated)
          }
       
       
       func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
           
           
           if currentTextField == countryTextField {
               dropDown.anchorView = countryTextField
               dropDown.dataSource = self.countryList.map { $0.name! }
           }else if currentTextField == cityTextField {
               dropDown.anchorView = cityTextField
               dropDown.dataSource = self.cityList.map { $0.name! }
           }
           
           dropDown.direction = .any
           dropDown.selectionAction = { (index: Int, item: String) in
               self.currentTextField?.text = item
               self.dropDown.hide()
               
               if self.currentTextField == self.countryTextField {
                   self.selectedCountry = self.countryList[index]
                   
                   self.selectedCity = nil
                   self.cityTextField.text = ""
                   self.getCityList()
               }else if self.currentTextField == self.cityTextField {
                   self.selectedCity = self.cityList[index]
               }
               self.cityTextField.resignFirstResponder()
               self.countryTextField.resignFirstResponder()
           }
       }
       
       func getCountriesList(){ // country list webservice
           
        FFManagerClass.getCountriesList(searchText: "", success: { (response) in
               self.countryList = response
               
               self.customiseDropDown()
               //            if let country = self.selectedCountry {
               //                let countryObj = self.countryList.filter{ $0.id == country }.first
               //                if let obj = countryObj {
               //                    self.countryTextField.text = obj.name
               //                }
               //            }
               
           }) { (error) in
               
           }
       }
       

       
       func getCityList(){ //city list websevice
           
        FFManagerClass.getCitiesList(searchText: "", countryid: "\(selectedCountry?.idInt ?? 0)", regionid: "", success: { (responseq) in
               self.cityList = responseq
           }) { (error) in
               
           }
           
       }
       
       //MARK:- Textfield Functions
       
//       func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
//           currentTextField = textField
//           self.dropDown.hide()
//
//           self.dropDown.anchorView = currentTextField
//           if textField == countryTextField {
//               self.dropDown.dataSource = self.countryList.map { $0.name! }
//               self.dropDown.reloadAllComponents()
//               self.dropDown.show()
//           }else if textField == cityTextField {
//               self.dropDown.dataSource = self.cityList.map { $0.name! }
//               self.dropDown.reloadAllComponents()
//               self.dropDown.show()
//           }
//       }
       
       func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
           
           if let establisment = estNameTextField.text, !establisment.isEmpty {
               
               storeRequest?.name = establisment
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.EnterOfficialnameoftheestablishment)", view: self)
               return false
           }
           
           if let country = countryTextField.text, !country.isEmpty {
               
               storeRequest?.countryId = "\(selectedCountry?.idInt ?? 0)"
               storeRequest?.countryName = country

           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthecountry)", view: self)
               return false
           }
           
           if let city = cityTextField.text, !city.isEmpty {
               
               storeRequest?.cityId = "\(selectedCity?.idInt ?? 0)"
               storeRequest?.cityName = city

           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthecity)", view: self)
               return false
           }
           
           if let postal = postalTextField.text, !postal.isEmpty {
               
               storeRequest?.postalCode = postal
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthepostalcode)", view: self)
               return false
           }
           
           if let street = nameStreetTextField.text, !street.isEmpty {
               
               //                   restaurantRequest?.address = street
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthenumberstreet)", view: self)
               return false
           }
           
           if let address = addressAdditionTextField.text, !address.isEmpty {
               
               storeRequest?.address = address
               
           }
           
           if let phone = phoneTextField.text, !phone.isEmpty {
               
               storeRequest?.phone = phone
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthephone)", view: self)
               return false
           }
           
           if let restEmail = restEmailTextField.text, !restEmail.isEmpty {
               
               storeRequest?.email = restEmail
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Entertherestaurantemail)", view: self)
               return false
           }
           
           if let website = restEmailTextField.text, !website.isEmpty {
               
               storeRequest?.website = website
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.EnterthewebsiteURL)", view: self)
               return false
           }
           
           if let facebook = restEmailTextField.text, !facebook.isEmpty {
               
               storeRequest?.facebook = facebook
               
           }else {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Enterthefacebookpage)", view: self)
               return false
           }
           return true
       }
    
    

       
       @IBAction func nextBtnTapped(_ sender : Any){
        
//                             self.navigationController?.popToRootViewController(animated: true)

        
           if validateStepOneFields(){

               let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFAddStoreStepThreeVC") as! FFAddStoreStepThreeVC
               vc.storeRequest = storeRequest
               self.navigationController?.pushViewController(vc, animated: true)
           }
       }
    
    @IBAction func didChangeCountryTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 1 {
               getCountriesList(searchText: sender.text!)
           }
           
       }

    @IBAction func didChangeCityTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 3 {
            if countryTextField.text == ""{
                FFBaseClass.sharedInstance.showAlert(mesage: "Please select a country first", view: self)
                self.cityTextField.text = ""

            }else{

            getCityList(searchText: sender.text!)
            }
           }
           
       }
    
    func getCountriesList(searchText:String?){ // country list webservice
        
        FFManagerClass.getCountriesList(searchText: searchText,success: { (response) in
            self.countryList = response
            self.currentTextField = self.countryTextField
//            self.dropDown.hide()
            self.dropDown.anchorView = self.countryTextField
            self.dropDown.dataSource = self.countryList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        
            
        }) { (error) in
            
        }
    }

    func getCityList(searchText:String?){ //city list websevice
        
        FFManagerClass.getCitiesList(searchText: searchText,countryid: "\(selectedCountry?.idInt ?? 0)", regionid: "", success: { (responseq) in
            self.cityList = responseq
            self.currentTextField = self.cityTextField
//            self.dropDown.hide()
            self.dropDown.anchorView = self.cityTextField
            self.dropDown.dataSource = self.cityList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()

        }) { (error) in
            
        }
        
    }
}
