//
//  FFUpdateGetInTouchViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 21/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFUpdateGetInTouchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    var dietArray = [String]()
    var allInterestList:[FFAllInterestObject] = []
    var dietString:String?
    var fromWhere: String?
    var textData: String?
    var restaurantID:Int?
    var storeID:Int?

    @IBOutlet weak var dietCollectionView:UICollectionView!
    @IBOutlet weak var dietCollectionViewHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var anyTextField:UITextField!
    let dropDown = DropDown()
    var specilaityList:[FFPlaceObject] = []
    var selectedSpeciality:FFPlaceObject?
    @IBOutlet weak var dropDownButton:UIButton!
    var restaurantRequest = FFAddRestaurantRequestModel()
    var storeRequest = FFSuggestStorePostModel()

    var selectedPrice: String?
    
    @IBOutlet weak var textFieldView:UIView!
    @IBOutlet weak var dietView:UIView!

    var isStore: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        dietCollectionView.dataSource  = self
        dietCollectionView.delegate = self

        anyTextField.text = textData
        if fromWhere == "phone"{
            anyTextField.placeholder = "Phone"
        }else if fromWhere == "email"{
            anyTextField.placeholder = "Email"
        }else if fromWhere == "website"{
            anyTextField.placeholder = "Website"
        }else if fromWhere == "facebook"{
            anyTextField.placeholder = "Facebook"
        }else if fromWhere == "reach"{
            anyTextField.placeholder = "Reach Us"
        }else if fromWhere == "pricelevel"{
            anyTextField.placeholder = "Select Price"
            self.dropDownButton.isHidden = false
            self.customiseDropDown()
        }else if fromWhere == "kitchen"{
            anyTextField.placeholder = "Select cuisine type"
            getSpecialities()
            self.dropDownButton.isHidden = false
        }else if fromWhere == "diet"{
            textFieldView.isHidden = true
            dietView.isHidden = false

//            anyTextField.placeholder = "Select cuisine type"
            getAllInterests()
        }
        else{
            
        }
        // Do any additional setup after loading the view.
    }
    
    func getSpecialities(){ // speciality list webservice
             
             FFManagerClass.getFunctionList(type: "special", success: { (response) in
                 self.specilaityList = response
                 self.customiseDropDown()
                 
             }) { (error) in
                 
             }
         }
    
    func getAllInterests(){ // interest list webservice
               
               FFManagerClass.getAllInterestList(success: { (response) in
                   self.allInterestList = response
                   
                 self.dietCollectionView.reloadData()
                 self.dietCollectionView.layoutIfNeeded()
                 self.dietCollectionViewHeightConstraint.constant = self.dietCollectionView.contentSize.height

               }) { (error) in
                   
               }
           }

    func customiseDropDown(){ // measure pop up customisation
        if fromWhere == "kitchen" {
            dropDown.anchorView = anyTextField
            dropDown.dataSource = self.specilaityList.map { $0.name! }
        }else if fromWhere == "pricelevel" {
            dropDown.anchorView = anyTextField
            dropDown.dataSource = ["Not Expensive (€)","Affordable (€€)","Expensive (€€€)"]
        }else{
            
        }
        dropDown.direction = .any
        dropDown.selectionAction = { (index: Int, item: String) in
            if self.fromWhere == "kitchen" {
                self.selectedSpeciality = self.specilaityList[index]
            }else{
                if index == 0{
                    self.selectedPrice = "€"
                }else if index == 1{
                    self.selectedPrice = "€€"
                }else{
                    self.selectedPrice = "€€€"
                }
            }
            self.anyTextField.text = item
            self.dropDown.hide()
        }
    }
    


    
    @IBAction func cancelBtntapped(_ sender : Any) {
           self.dismiss(animated: true, completion: nil)
       }

    @IBAction func showDropdownBtnTapped(_ sender: Any) { // confirm button action
        dropDown.show()
     }
    
    func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
            var isValid = true
            if fromWhere == "diet"{
        self.dietArray.removeAll()
        for i in 0...self.allInterestList.count - 1{
            if self.allInterestList[i].isChecked == 1{
                
                self.dietArray.append("\(self.allInterestList[i].id ?? 0)")
                
            }
        }
        
        if self.dietArray.count > 0{
            dietString = dietArray.joined(separator: ", ")
            restaurantRequest.interests = dietString
        }else{
            FFBaseClass.sharedInstance.showAlert(mesage: "Select alleast one interest", view: self)
            isValid = false

        }

            }else{
            if let anyText = anyTextField.text, !anyText.isEmpty {
                if fromWhere == "phone"{
                    if isStore == 1{
                        storeRequest.phone = anyText

                    }else{
                    restaurantRequest.phone = anyText
                    }
                       }else if fromWhere == "email"{
                    if isStore == 1{
                        storeRequest.email = anyText

                    }else{
                    restaurantRequest.email = anyText
                    }

                       }else if fromWhere == "website"{
                    if isStore == 1{
                                           storeRequest.website = anyText

                                       }else{
                                       restaurantRequest.website = anyText
                                       }
                       }else if fromWhere == "facebook"{
                    if isStore == 1{
                                           storeRequest.facebook = anyText

                                       }else{
                                       restaurantRequest.facebook = anyText
                                       }

                       }else if fromWhere == "reach"{
                       }else if fromWhere == "pricelevel"{
                    
                    restaurantRequest.priceRange = self.selectedPrice

                       }else if fromWhere == "kitchen"{
                    restaurantRequest.specialities = "\(self.selectedSpeciality?.idInt ?? 0)"

                       }

            }else {
                FFBaseClass.sharedInstance.showAlert(mesage: "Enter \(fromWhere ?? "")", view: self)
                isValid = false
            }
        }
        return isValid
    }
    
    @IBAction func confirmBtnTapped(_ sender : Any){
        
        if validateStepOneFields(){
          if isStore == 1{
            self.updateStore()
          }else{
            self.updateRestaurant()
            }
        }
    }
    func updateRestaurant(){
        restaurantRequest.isEdit = true
                  restaurantRequest.id = "\(restaurantID ?? 0)"
                  FFLoaderView.showInView(view: self.view)
                  FFManagerClass.postRestaurant(restaurantRequest: self.restaurantRequest, success: { (response) in
                      print(response)
                       self.dismiss(animated: true, completion: nil)
                      NotificationCenter.default.post(name: Notification.Name("restInfoUpdated"), object: nil)
                      FFLoaderView.hideInView(view: self.view)
                  }) { (error) in
                      print(error)
                      FFLoaderView.hideInView(view: self.view)
                      FFBaseClass.sharedInstance.showError(error: error, view: self)
                  }
    }
    
    func updateStore(){
        storeRequest.isEdit = true
                  storeRequest.id = "\(storeID ?? 0)"
                  FFLoaderView.showInView(view: self.view)
                  FFManagerClass.suggestStore(storeRequest: self.storeRequest, success: { (response) in
                      print(response)
                       self.dismiss(animated: true, completion: nil)
                      NotificationCenter.default.post(name: Notification.Name("storeInfoUpdated"), object: nil)
                      FFLoaderView.hideInView(view: self.view)
                  }) { (error) in
                      print(error)
                      FFLoaderView.hideInView(view: self.view)
                      FFBaseClass.sharedInstance.showError(error: error, view: self)
                  }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              if collectionView == dietCollectionView{
              return allInterestList.count
              }else{
                return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectCell: UICollectionViewCell = UICollectionViewCell()
        if collectionView == dietCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.allInterestList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
            if self.allInterestList[indexPath.row].isChecked == 1 {
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
            }else {
                tickImgView.image = #imageLiteral(resourceName: "tickgrey")
            }
            collectCell = cell
        }
        return collectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == dietCollectionView{

    let cellWidth = collectionView.bounds.width
        let cellSize = collectionView.bounds.size.width / 3

    return CGSize(width: cellSize, height: 100)
    }else{
        return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           //        selectedTheme = self.interestList[indexPath.row].stringId!
                   if collectionView == dietCollectionView{
                       if self.allInterestList[indexPath.row].isChecked == 1 {
                           self.allInterestList[indexPath.row].isChecked = 0
                       }else{
                           self.allInterestList[indexPath.row].isChecked = 1
                       }
                       self.dietCollectionView.reloadData()
                   }
    }
    
    
}
