//
//  FFFSixthPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/7/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFFSixthPrefernceViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var headLabel:UILabel!
    @IBOutlet weak var subheadLabel:UILabel!
    @IBOutlet weak var skipButton:UIButton!

    @IBOutlet weak var countryTextField:UITextField!
    @IBOutlet weak var regionTextField:UITextField!
    @IBOutlet weak var cityTextField:UITextField!
    @IBOutlet weak var zipTextField:UITextField!
    @IBOutlet weak var addressTextView:UITextView!

    var currentTextField:UITextField?
    let dropDown = DropDown()
    
    var countryList:[FFPlaceObject] = []
    var cityList:[FFPlaceObject] = []
    var regionList:[FFPlaceObject] = []
    
    
    var selectedCountry:FFPlaceObject?
    var selectedRegion:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    var updateAddressRequest = FFUpdateAddressRequestModel()
    @IBOutlet weak var addressErrorLabel: UILabel!
    @IBOutlet weak var countryErrorLabel: UILabel!
    @IBOutlet weak var cityErrorLabel: UILabel!
    @IBOutlet weak var regionErrorLabel: UILabel!
    @IBOutlet weak var zipcodeErrorLabel: UILabel!
    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    var countryId: Int?
    var cityId: Int?
    var regionId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.placeholder = "\(StringConstants.indicateAddress.Selectacountry)"
        regionTextField.placeholder = "\(StringConstants.indicateAddress.Selectaregion)"
        cityTextField.placeholder = "\(StringConstants.indicateAddress.Selectacity)"
        zipTextField.placeholder = "\(StringConstants.indicateAddress.Enteryourzipcode)"
        addressTextView.text = "\(StringConstants.indicateAddress.Enteryouraddress)"

        zipTextField.delegate = self
        countryTextField.delegate = self
        regionTextField.delegate = self
        cityTextField.delegate = self
        addressTextView.delegate = self
        headLabel.text = "\(StringConstants.indicateAddress.Indicateyouraddress)"
        subheadLabel.text = "\(StringConstants.indicateAddress.Receivecustomlocalrestaurantsandshops)"
        skipButton.setTitle("\(StringConstants.indicateAddress.Nextstep)", for: .normal)
        addressTextView.layer.borderWidth = 0.5
        addressTextView.layer.borderColor = #colorLiteral(red: 0.8752595782, green: 0.8703916669, blue: 0.8747208714, alpha: 1)
        customiseDropDown()
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "\(StringConstants.indicateAddress.Enteryouraddress)"{
                textView.text = ""
            }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "\(StringConstants.indicateAddress.Enteryouraddress)"
        }
    }
    
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
        
        
        if currentTextField == countryTextField {
            dropDown.anchorView = countryTextField
            dropDown.dataSource = self.countryList.map { $0.name! }
        }else if currentTextField == regionTextField {
            dropDown.anchorView = regionTextField
            dropDown.dataSource = self.regionList.map { $0.name! }
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
                self.countryId = self.countryList[index].idInt
                self.selectedRegion = nil
                self.selectedCity = nil
                self.regionTextField.text = ""
                self.cityTextField.text = ""
//                self.getRegionList(searchText: "")
//                self.getCityList(searchText: "")

            }else if self.currentTextField == self.regionTextField {
                self.selectedRegion = self.regionList[index]
                self.regionId = self.regionList[index].idInt

                self.selectedCity = nil
                self.cityTextField.text = ""
//                self.getCityList()
            }else if self.currentTextField == self.cityTextField {
                self.selectedCity = self.cityList[index]
                self.cityId = self.cityList[index].idInt
            }
            
        }
    }

    @IBAction func didChangeCountryTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 1 {
               getCountriesList(searchText: sender.text!)
           }
           
       }
    @IBAction func didChangeRegionTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 2 {
            if countryTextField.text == ""{
                FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Pleaseselectacountryfirst)", view: self)
                self.regionTextField.text = ""
            }else{
                getRegionList(searchText: sender.text!)
            }
           }
           
       }
    @IBAction func didChangeCityTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 3 {
            if countryTextField.text == ""{
                FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Pleaseselectacountryfirst)", view: self)
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
    
    func getRegionList(searchText:String?){ // regiion list webservice
        
        FFManagerClass.getRegionsList(searchText: searchText,countryid: "\(selectedCountry?.idInt ?? 0)", success: { (response) in
            self.regionList = response
            self.currentTextField = self.regionTextField
//            self.dropDown.hide()
            self.dropDown.anchorView = self.regionTextField
            self.dropDown.dataSource = self.regionList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()

        }) { (error) in
            
        }
    }
    
    func getCityList(searchText:String?){ //city list websevice
        
        FFManagerClass.getCitiesList(searchText: searchText,countryid: "\(selectedCountry?.idInt ?? 0)", regionid: "\(selectedRegion?.idInt ?? 0)", success: { (responseq) in
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
    
    @IBAction func skipAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSeventhPrefernceVC") as! FFSeventhPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func nextButton(_ sender: UIButton){
        
        if validateFields(){
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.updateAddress(updateAddressRequest: self.updateAddressRequest, success: { (response) in
                print(response)
                 self.dismiss(animated: true, completion: nil)
             NotificationCenter.default.post(name: Notification.Name("profileUpdated"), object: nil)
                FFLoaderView.hideInView(view: self.view)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSeventhPrefernceVC") as! FFSeventhPrefernceViewController
                self.navigationController?.pushViewController(vc, animated: true)

            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
    }
    
    
    func validateFields() -> Bool { // vlidate the fields
           
           var isValid = true
           addressErrorLabel.text = ""
           countryErrorLabel.text = ""
           cityErrorLabel.text = ""
           zipcodeErrorLabel.text = ""
        updateAddressRequest.addresstypeid = 1
        
         if let id = FFBaseClass.sharedInstance.getUser()?.id {
                 updateAddressRequest.userid = "\(id)"
               }
           if let address = addressTextView.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !address.isEmpty {
               updateAddressRequest.address = address
           }else {
               addressErrorLabel.text = emptyErrorMsg
               isValid =  false
           }
        
         if let country = countryTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !country.isEmpty {
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
        if let selectedregionId = regionId{
            updateAddressRequest.regionid = selectedregionId

        }

         if let city = cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !city.isEmpty {
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
        if let zip = zipTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !zip.isEmpty {
                       updateAddressRequest.zipcode = zip
                   }else {
                       zipcodeErrorLabel.text = emptyErrorMsg
                       isValid =  false
                   }
           return isValid
       }
       
}
