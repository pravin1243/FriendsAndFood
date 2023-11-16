//
//  FFAddRestaurantViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 21/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFAddRestaurantViewController: FFAddRestaurantBaseController, UITextFieldDelegate {

    @IBOutlet weak var meBtn:UIButton!
    @IBOutlet weak var otherBtn:UIButton!
    @IBOutlet weak var missBtn:UIButton!
    @IBOutlet weak var mrBtn:UIButton!

    let dropDown = DropDown()

    
    @IBOutlet weak var lastNameTextField:UITextField!
    @IBOutlet weak var firstNameTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!

    @IBOutlet weak var functionTextField:UITextField!
    @IBOutlet weak var genderTextField:UITextField!

    @IBOutlet weak var firstNameView:UIView!
    @IBOutlet weak var lastNameView:UIView!
    @IBOutlet weak var emailView:UIView!
    @IBOutlet weak var functionView:UIView!

    @IBOutlet weak var genderView:UIView!

    var functionList:[FFPlaceObject] = []

    var selectedFunction:FFPlaceObject?
    @IBOutlet weak var genderStackView:UIStackView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantRequest = FFAddRestaurantRequestModel()

        customiseBtn(button: meBtn)
        customiseBtn(button: otherBtn)
        
        customiseBtn(button: mrBtn)
        customiseBtn(button: missBtn)
        

        showMeView()
        // Do any additional setup after loading the view.
        
        let superview = meBtn.superview
              let tick = superview?.viewWithTag(100) as! UIImageView
              tick.isHidden = false
              
                  meBtn.layer.borderColor = UIColor.primary.cgColor

        getFunctionList()
        functionTextField.delegate = self
//        genderTextField.delegate = self

    }
    
    func getFunctionList(){ // country list webservice
        
        FFManagerClass.getFunctionList(type: "function", success: { (response) in
            self.functionList = response
            
            self.customiseDropDown()
        }) { (error) in
            
        }
    }
    
    
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
        
        
            dropDown.anchorView = functionTextField
            dropDown.dataSource = self.functionList.map { $0.name! }
        
        dropDown.direction = .any
        dropDown.selectionAction = { (index: Int, item: String) in
            self.functionTextField.text = item
            self.dropDown.hide()
            self.selectedFunction = self.functionList[index]
            self.functionTextField.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
        if textField == functionTextField {
            self.dropDown.dataSource = self.functionList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }
        if textField == genderTextField {
            self.dropDown.dataSource = []
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }
    }

    
    func showMeView(){
        firstNameView.isHidden = true
        lastNameView.isHidden = true
        emailView.isHidden = true
        genderStackView.isHidden = true

    }
    
    func showOtherView(){
          firstNameView.isHidden = false
          lastNameView.isHidden = false
          emailView.isHidden = false
        genderStackView.isHidden = false

      }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }

    
    func customiseBtn(button: UIButton){
        
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        button.layer.borderWidth = 0.5
        
        button.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        button.setTitleColor(UIColor.primary, for: UIControl.State.selected)
    }
    
    func hideOrShowTick(btn:UIButton, shouldShow:Bool ){ // show/hide selection tick mark
        
        let superview = btn.superview
        let tick = superview?.viewWithTag(100) as! UIImageView
        tick.isHidden = !shouldShow
        
        if shouldShow == true {
            btn.layer.borderColor = UIColor.primary.cgColor
        }else {
            btn.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
    }
    
    @IBAction func meBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        showMeView()
//        meView.isHidden = false
//        otherView.isHidden = true

        meBtn.isSelected = false
        otherBtn.isSelected = false
        
        hideOrShowTick(btn: meBtn, shouldShow: false)
        hideOrShowTick(btn: otherBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }
    
    @IBAction func otherBtnTapped(_ sender : UIButton) { // dificulty buton selection action
//        meView.isHidden = true
//        otherView.isHidden = false
        showOtherView()
        meBtn.isSelected = false
        otherBtn.isSelected = false
        
        hideOrShowTick(btn: meBtn, shouldShow: false)
        hideOrShowTick(btn: otherBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }
    
        @IBAction func misBtnTapped(_ sender : UIButton) { // dificulty buton selection action
            restaurantRequest?.gender = "Miss"

    //        meView.isHidden = true
    //        otherView.isHidden = false
//            showOtherView()
            missBtn.isSelected = false
            mrBtn.isSelected = false
            
            hideOrShowTick(btn: missBtn, shouldShow: false)
            hideOrShowTick(btn: mrBtn, shouldShow: false)
            
            sender.isSelected = true
            hideOrShowTick(btn: sender, shouldShow: true)
            
        }
    
        @IBAction func mrBtnTapped(_ sender : UIButton) { // dificulty buton selection action
            restaurantRequest?.gender = "Mister"

    missBtn.isSelected = false
    mrBtn.isSelected = false
    
    hideOrShowTick(btn: missBtn, shouldShow: false)
    hideOrShowTick(btn: mrBtn, shouldShow: false)
    
    sender.isSelected = true
    hideOrShowTick(btn: sender, shouldShow: true)

        }
    @IBAction func closeBtnTapped(_ sender : Any){
           self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func nextBtnTapped(_ sender : Any){
        if validateStepOneFields() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFAddRestaurantTwoVC") as! FFAddRestaurantTwoViewController
            vc.restaurantRequest = restaurantRequest
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
        var isValid = true
        if firstNameView.isHidden == false{
            if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
                
                if !isValidEmail(email: email ){
                    FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Emailisnotvalid)", view: self)
                    
                    isValid =  false
                }else {
//                    restaurantRequest?.email = email
                }
            }else
            {
                FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.EnterEmail)", view: self)
                isValid = false
            }
        }
        if let function = functionTextField.text, !function.isEmpty {
            
            restaurantRequest?.jobId = "\(selectedFunction?.idInt ?? 0)"

        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.EnterOfficialnameoftheestablishment)", view: self)
            return false
        }
        return isValid
    }
    
    func isValidEmail(email: String) -> Bool { //  checking email validity
          let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
          let predicate = NSPredicate(format: "self matches %@", emailRegex)
          return predicate.evaluate(with: email)
      }
}
