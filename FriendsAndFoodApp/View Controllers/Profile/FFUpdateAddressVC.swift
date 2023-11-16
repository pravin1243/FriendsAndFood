//
//  FFUpdateAddressVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFUpdateAddressVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var zipcodeTextfield: UITextField!

    @IBOutlet weak var addressErrorLabel: UILabel!
    @IBOutlet weak var countryErrorLabel: UILabel!
    @IBOutlet weak var cityErrorLabel: UILabel!
    @IBOutlet weak var zipcodeErrorLabel: UILabel!

    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    var updateAddressRequest = FFUpdateAddressRequestModel()
    var userId: Int?
    var currentTextField:UITextField?
    let dropDown = DropDown()
    
    var countryList:[FFPlaceObject] = []
    var cityList:[FFPlaceObject] = []
    var regionList:[FFPlaceObject] = []
    
    
    var selectedCountry:FFPlaceObject?
    var selectedRegion:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    var isProfessional: Bool?
    var addressTypeId: Int?

    var addressObject: FFUserAddressObject?
    @IBOutlet weak var customTitleLabel: UILabel!

    var countryId: Int?
    var cityId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        if addressTypeId == 1{
            self.customTitleLabel.text = "\(StringConstants.Profile.UPDATEPERSONALADDRESS)"
        }else{
            self.customTitleLabel.text = "\(StringConstants.Profile.UPDATEPROFESSIONALADDRESS)"

        }
//        getCountriesList(searchText: "")
        populateData()
        countryTextfield.delegate = self
        cityTextfield.delegate = self
        customiseDropDown()
        // Do any additional setup after loading the view.
    }
    
    func populateData(){ // data populate from webservie response
        addressTextfield.text = addressObject?.address
        countryTextfield.text = addressObject?.country
        cityTextfield.text = addressObject?.city
        zipcodeTextfield.text = addressObject?.zipcode
        updateAddressRequest.countryid = addressObject?.countryid
        selectedCountry?.idInt = addressObject?.countryid
        countryId = addressObject?.countryid
        updateAddressRequest.cityid = addressObject?.cityid
        selectedCity?.idInt = addressObject?.cityid
        cityId = addressObject?.cityid

    }
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
            
            
            if currentTextField == countryTextfield {
                dropDown.anchorView = countryTextfield
                dropDown.dataSource = self.countryList.map { $0.name! }
            }else if currentTextField == cityTextfield {
                dropDown.anchorView = cityTextfield
                dropDown.dataSource = self.cityList.map { $0.name! }
            }
            
            dropDown.direction = .any
            dropDown.selectionAction = { (index: Int, item: String) in
                self.currentTextField?.text = item
                self.dropDown.hide()
                
                if self.currentTextField == self.countryTextfield {
                    self.selectedCountry = self.countryList[index]
                    self.countryId = self.countryList[index].idInt

                    self.selectedRegion = nil
                    self.selectedCity = nil
                    self.cityTextfield.text = ""
                    self.getCityList(searchText: "")

                }else if self.currentTextField == self.cityTextfield {
                    self.selectedCity = self.cityList[index]
                    self.cityId = self.cityList[index].idInt

                }
                
            }
        }

    func validateFields() -> Bool { // vlidate the fields
           
           var isValid = true
           addressErrorLabel.text = ""
           countryErrorLabel.text = ""
           cityErrorLabel.text = ""
           zipcodeErrorLabel.text = ""

        
        
         if let id = userId {
                 updateAddressRequest.userid = "\(id)"
               }
        updateAddressRequest.addresstypeid = addressTypeId
           if let address = addressTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !address.isEmpty {
               updateAddressRequest.address = address
           }else {
               addressErrorLabel.text = emptyErrorMsg
               isValid =  false
           }
        
         if let country = countryTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !country.isEmpty {
            updateAddressRequest.countryid = selectedCountry?.idInt
               }else {
                   countryErrorLabel.text = emptyErrorMsg
                   isValid =  false
               }
        if let selectedcountryId = countryId{
            updateAddressRequest.countryid = selectedcountryId

        }else {
            countryErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
         if let city = cityTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !city.isEmpty {
            updateAddressRequest.cityid = selectedCity?.idInt
                    }else {
                        cityErrorLabel.text = emptyErrorMsg
                        isValid =  false
                    }
        if let selectedcityId = cityId{
            updateAddressRequest.cityid = selectedcityId
        }else {
            cityErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        if let zip = zipcodeTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !zip.isEmpty {
                       updateAddressRequest.zipcode = zip
                   }else {
                       zipcodeErrorLabel.text = emptyErrorMsg
                       isValid =  false
                   }
           return isValid
       }
       
       @IBAction func confirmBtnTapped(_ sender: Any){ // edit photo button action
           if validateFields(){
               FFLoaderView.showInView(view: self.view)
               FFManagerClass.updateAddress(updateAddressRequest: self.updateAddressRequest, success: { (response) in
                   print(response)
                    self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: Notification.Name("profileUpdated"), object: nil)
                   FFLoaderView.hideInView(view: self.view)
               }) { (error) in
                   print(error)
                   FFLoaderView.hideInView(view: self.view)
                   FFBaseClass.sharedInstance.showError(error: error, view: self)
               }
           }

       }
       
       @IBAction func closeBtnTapped(_ sender: Any){ // edit photo button action
           self.dismiss(animated: true, completion: nil)

          }
    
           
    @IBAction func countryBtnTapped(_ sender: Any){ // edit photo button action
        self.currentTextField = self.countryTextfield
        self.dropDown.anchorView = self.countryTextfield
        self.dropDown.dataSource = self.countryList.map { $0.name! }
        self.dropDown.reloadAllComponents()
        self.dropDown.show()

    }
    @IBAction func cityBtnTapped(_ sender: Any){ // edit photo button action
                if countryTextfield.text == ""{
                    FFBaseClass.sharedInstance.showAlert(mesage: "Please select a country first", view: self)

                }else{
                    currentTextField = cityTextfield
        //            self.dropDown.hide()
                    self.dropDown.anchorView = currentTextField
                    self.dropDown.dataSource = self.cityList.map { $0.name! }
                    self.dropDown.reloadAllComponents()
                    self.dropDown.show()

                }

    }
    
    
    @IBAction func didChangeCountryTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 3 {
               getCountriesList(searchText: sender.text!)
           }
           
       }

    @IBAction func didChangeCityTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 3 {
            if countryTextfield.text == ""{
                FFBaseClass.sharedInstance.showAlert(mesage: "Please select a country first", view: self)
                self.cityTextfield.text = ""

            }else{
                
            getCityList(searchText: sender.text!)
            }
           }
           
       }
    
    func getCountriesList(searchText:String?){ // country list webservice
        
        FFManagerClass.getCountriesList(searchText: searchText,success: { (response) in
            self.countryList = response
            self.currentTextField = self.countryTextfield
//            self.dropDown.hide()
            self.dropDown.anchorView = self.countryTextfield
            self.dropDown.dataSource = self.countryList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        
            
        }) { (error) in
            
        }
    }

    func getCityList(searchText:String?){ //city list websevice
        
        FFManagerClass.getCitiesList(searchText: searchText,countryid: "\(selectedCountry?.idInt ?? 0)", regionid: "", success: { (responseq) in
            self.cityList = responseq
            self.currentTextField = self.cityTextfield
//            self.dropDown.hide()
            self.dropDown.anchorView = self.cityTextfield
            self.dropDown.dataSource = self.cityList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()

        }) { (error) in
            
        }
        
    }
}
