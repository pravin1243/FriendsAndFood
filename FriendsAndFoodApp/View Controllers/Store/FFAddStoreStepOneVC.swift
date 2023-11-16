//
//  FFAddStoreStepOneVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 04/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFAddStoreStepOneVC: FFSuggestStoreBaseController, UITextFieldDelegate {
    let dropDown = DropDown()

    
    @IBOutlet weak var activityTextField:UITextField!
    var storeTypeList:[FFStoreTypeObject] = []
    var selectedActivity:FFStoreTypeObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        storeRequest = FFSuggestStorePostModel()
        loadStoreTypes()
        activityTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    func loadStoreTypes(){ // ingredient list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getStoreTypes(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.storeTypeList = responce
            
            self.customiseDropDown()

        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
        if textField == activityTextField {
            self.dropDown.dataSource = self.storeTypeList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }
 
    }
    
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
        
        
            dropDown.anchorView = activityTextField
            dropDown.dataSource = self.storeTypeList.map { $0.name! }
        
        dropDown.direction = .any
        dropDown.selectionAction = { (index: Int, item: String) in
            self.activityTextField.text = item
            self.dropDown.hide()
            self.selectedActivity = self.storeTypeList[index]
            self.activityTextField.resignFirstResponder()
        }
    }
    
        
        func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
            var isValid = true

            if let function = activityTextField.text, !function.isEmpty {
                
                storeRequest?.storeTypeId = "\(selectedActivity?.storeTypeId ?? 0)"

            }else {
                FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.Entertheactivityofthestore)", view: self)
                isValid = false
            }
            return isValid
        }
    
    @IBAction func closeBtnTapped(_ sender : Any){
           self.navigationController?.popViewController(animated: true)
       }

    @IBAction func nextBtnTapped(_ sender : Any){
         if validateStepOneFields() {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFAddStoreStepTwoVC") as! FFAddStoreStepTwoVC
             vc.storeRequest = storeRequest
             self.navigationController?.pushViewController(vc, animated: true)
         }
     }

}
