//
//  FFFindRestaurantViewController.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import DropDown

protocol findRestaurantDelegate {
    func didFinishedFilter(restauratList:[FFRestaurantObject],isSearchResult: Bool, selectedCountry:FFPlaceObject?, selectedRegion:FFPlaceObject?, selectedCity:FFPlaceObject?, searchText: String)
}

class FFFindRestaurantViewController: UIViewController, UITextFieldDelegate {
    var delegate: findRestaurantDelegate! = nil

    @IBOutlet weak var searchTermTextField:UITextField!
    @IBOutlet weak var countryTextField:UITextField!
    @IBOutlet weak var regionTextField:UITextField!
    @IBOutlet weak var cityTextField:UITextField!
    
    var currentTextField:UITextField?
    let dropDown = DropDown()
    
    var countryList:[FFPlaceObject] = []
    var cityList:[FFPlaceObject] = []
    var regionList:[FFPlaceObject] = []
    
    
    var selectedCountry:FFPlaceObject?
    var selectedRegion:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    var searchText:String?
    @IBOutlet weak var searchView:UIView!
    var fromWhere: String?
    var storeList:[FFStoreObject] = []
    var isStore: Int?
    var storeTypeId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromWhere == "filter"{
            searchView.isHidden = true
            if isStore == 1{
                      self.title = "Filter Stores"
                   }else{
                    self.title = "\(StringConstants.Labels.AdvancedRestaurantsearch)"
                   }
        }else{
            if isStore == 1{
                                self.title = "Search Stores"
                             }else{
                             self.title = "Search Restaurants"
                             }
        }
        searchTermTextField.delegate = self
        countryTextField.delegate = self
        regionTextField.delegate = self
        cityTextField.delegate = self
        
        
        if let search = searchText {
            searchTermTextField.text = search
        }
        
        if let ctry = selectedCountry {
            countryTextField.text = ctry.name
//            getRegionList()
        }
        if let region  = selectedRegion {
            regionTextField.text = region.name
//            getCityList()
        }
        if let city = selectedCity {
            cityTextField.text = city.name
        }
        
        
        customiseDropDown()
       // getCountriesList(searchText: "")
        
        
        // Do any additional setup after loading the view.
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Custom Functions
    
    @IBAction func searchButtonPressed(_ sender: Any){
        
        if countryTextField.text == ""{
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Pleaseselectacountryfirst)", view: self)

        }else{
        if isStore == 1{
           callSearchStoreAPI()
        }else{
        callSearchRestaurantsAPI()
        }
        }
    }
    
    
    func callSearchRestaurantsAPI(){ //  search restaurants webservice
        FFLoaderView.showInView(view: self.view)
        var countryIdNew: String?
        if let countryId = selectedCountry?.idInt{
            countryIdNew = "\(countryId)"
        }
        var regionIdNew: String?
        if let regionId = selectedRegion?.idInt{
            regionIdNew = "\(regionId)"
        }
        var cityIdNew: String?
        if let cityId = selectedCity?.idInt{
            cityIdNew = "\(cityId)"
        }

        FFManagerClass.searchRestaurants(serchText: searchTermTextField.text, countryid: "\(countryIdNew ?? "")" , regionid: "\(regionIdNew ?? "")" , cityid: "\(cityIdNew ?? "")" , success: { (response) in
            FFLoaderView.hideInView(view: self.view)
//            let vc = self.navigationController?.viewControllers[1] as! FFRestaurantListViewController
////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
//
//            vc.restauratList = response
//            vc.isSearchResult = true
//            vc.selectedCountry = self.selectedCountry
//            vc.selectedRegion = self.selectedRegion
//            vc.selectedCity = self.selectedCity
//            vc.searchText = self.searchTermTextField.text ?? ""
            self.navigationController?.popViewController(animated: true)
            self.delegate.didFinishedFilter(restauratList: response, isSearchResult: true, selectedCountry: self.selectedCountry, selectedRegion: self.selectedRegion, selectedCity: self.selectedCity, searchText: self.searchTermTextField.text ?? "")

        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
        
    }
    
    func callSearchStoreAPI(){ //  search restaurants webservice
            FFLoaderView.showInView(view: self.view)
            var countryIdNew: String?
            if let countryId = selectedCountry?.idInt{
                countryIdNew = "\(countryId)"
            }
            var regionIdNew: String?
            if let regionId = selectedRegion?.idInt{
                regionIdNew = "\(regionId)"
            }
            var cityIdNew: String?
            if let cityId = selectedCity?.idInt{
                cityIdNew = "\(cityId)"
            }

        FFManagerClass.searchStores(page: "", maxResult: "",typeid:"", serchText: searchTermTextField.text, countryid: "\(countryIdNew ?? "")" , regionid: "\(regionIdNew ?? "")" , cityid: "\(cityIdNew ?? "")" , success: { (response) in
                FFLoaderView.hideInView(view: self.view)
    //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
            for vc in self.navigationController!.viewControllers as Array {
                if let storeVC = vc as? FFStoreListingViewController {
                    storeVC.storeList = response
                    storeVC.isSearchResult = true
                    storeVC.selectedCountry = self.selectedCountry
                    storeVC.selectedRegion = self.selectedRegion
                    storeVC.selectedCity = self.selectedCity
                    storeVC.searchText = self.searchTermTextField.text ?? ""
                    self.navigationController!.popToViewController(storeVC, animated: true)
                    break
                }
            }
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
            
            
        }
    
    //    func goToFirstViewController() {
    //        let a = self.navigationController.viewControllers[0] as A
    //        a.data = "data"
    //        self.navigationController.popToRootViewControllerAnimated(true)
    //    }
    
    
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
                
                self.selectedRegion = nil
                self.selectedCity = nil
                self.regionTextField.text = ""
                self.cityTextField.text = ""
//                self.getRegionList(searchText: "")
//                self.getCityList(searchText: "")

            }else if self.currentTextField == self.regionTextField {
                self.selectedRegion = self.regionList[index]
                self.selectedCity = nil
                self.cityTextField.text = ""
//                self.getCityList()
            }else if self.currentTextField == self.cityTextField {
                self.selectedCity = self.cityList[index]
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
    
    //MARK:- Textfield Functions
    
//    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
//        currentTextField = textField
//        self.dropDown.hide()
//
//        self.dropDown.anchorView = currentTextField
//        if textField == countryTextField {
//            self.dropDown.dataSource = self.countryList.map { $0.name! }
//            self.dropDown.reloadAllComponents()
//            self.dropDown.show()
//        }else if textField == regionTextField {
//            self.dropDown.dataSource = self.regionList.map { $0.name! }
//            self.dropDown.reloadAllComponents()
//            self.dropDown.show()
//        }else if textField == cityTextField {
//            self.dropDown.dataSource = self.cityList.map { $0.name! }
//            self.dropDown.reloadAllComponents()
//            self.dropDown.show()
//        }
//    }
    
 @IBAction func countryButtonPressed(_ sender: Any){
//    currentTextField = countryTextField
//    self.dropDown.hide()
//    self.dropDown.anchorView = currentTextField
//    self.dropDown.dataSource = self.countryList.map { $0.name! }
//    self.dropDown.reloadAllComponents()
//    self.dropDown.show()

    }
    @IBAction func regionButtonPressed(_ sender: Any){
        if countryTextField.text == ""{
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Pleaseselectacountryfirst)", view: self)

        }else{
            currentTextField = regionTextField
//            self.dropDown.hide()
            self.dropDown.anchorView = currentTextField
            self.dropDown.dataSource = self.regionList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()

        }
    }
    @IBAction func cityButtonPressed(_ sender: Any){
        if countryTextField.text == ""{
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Pleaseselectacountryfirst)", view: self)

        }else{
            currentTextField = cityTextField
//            self.dropDown.hide()
            self.dropDown.anchorView = currentTextField
            self.dropDown.dataSource = self.cityList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()

        }
    }
}
