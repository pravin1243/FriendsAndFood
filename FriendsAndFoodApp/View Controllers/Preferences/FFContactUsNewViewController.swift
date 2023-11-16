//
//  FFContactUsNewViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 12/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFContactUsNewViewController: UIViewController {
    @IBOutlet weak var genderErrorLabel: UILabel!

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var lastnameErrorLabel: UILabel!

    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!

    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var subjectErrorLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!

    @IBOutlet weak var  messageTextView:UITextView!
    @IBOutlet weak var messageErrorLabel: UILabel!

    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    
    var contactRequest = FFPostContactRequestModel()
    @IBOutlet weak var missBtn:UIButton!
    @IBOutlet weak var mrBtn:UIButton!
    var isGender:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        isGender = false
        customiseBtn(button: mrBtn)
        customiseBtn(button: missBtn)

        messageTextView.layer.borderWidth = 0.5
        messageTextView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        messageTextView.layer.cornerRadius = 4

        self.title = "Contact Us"
        // Do any additional setup after loading the view.
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
       
               @IBAction func misBtnTapped(_ sender : UIButton) { // dificulty buton selection action
                   isGender = true
                   contactRequest.gender = "2"

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
                   isGender = true

                   contactRequest.gender = "1"

           missBtn.isSelected = false
           mrBtn.isSelected = false
           
           hideOrShowTick(btn: missBtn, shouldShow: false)
           hideOrShowTick(btn: mrBtn, shouldShow: false)
           
           sender.isSelected = true
           hideOrShowTick(btn: sender, shouldShow: true)

               }

    @IBAction func saveBtnTapped(_ sender: Any) {
           if validateFields() {
               callContactUsAPI()
           }
           
       }
       
    func callContactUsAPI(){
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.postContact(contactRequest: self.contactRequest, success: { (response) in
            print(response)
//             self.navigationController?.popToRootViewController(animated: true)
            FFBaseClass.sharedInstance.showAlert(mesage: "Thanks for contacting us, we will come back to you soon !", view: self)

            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func validateFields() -> Bool { // validating all the fields in the form
            
            var isValid = true
            genderErrorLabel.text = ""
            firstNameErrorLabel.text = ""
            lastnameErrorLabel.text = ""
            emailErrorLabel.text = ""
            phoneErrorLabel.text = ""
            subjectErrorLabel.text = ""
        messageErrorLabel.text = ""

            if isGender == false{
                genderErrorLabel.text = emptyErrorMsg
                isValid =  false
            }
            
            if let fname = firstNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !fname.isEmpty {
                contactRequest.firstname = fname
            }else {
                firstNameErrorLabel.text = emptyErrorMsg
                isValid =  false
            }
            
            if let lname = lastnameTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
                contactRequest.lastName =  lname
            }else {
                lastnameErrorLabel.text = emptyErrorMsg
                isValid =  false
            }

            if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
                
                if !isValidEmail(email: email ){
                    emailErrorLabel.text = invalidErrorMsg
                    isValid =  false
                }else {
                    contactRequest.email = email
                }
                
            }else {
                emailErrorLabel.text = emptyErrorMsg
                isValid =  false
            }
            
       
        if let subject = subjectTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !subject.isEmpty {
                    contactRequest.subject =  subject
                }else {
                    subjectErrorLabel.text = emptyErrorMsg
                    isValid =  false
                }
        
        if let message = messageTextView.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !message.isEmpty {
                    contactRequest.message =  message
                }else {
                    messageErrorLabel.text = emptyErrorMsg
                    isValid =  false
                }

        
            return isValid
        }
    
    func isValidEmail(email: String) -> Bool { //  checking email validity
          let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
          let predicate = NSPredicate(format: "self matches %@", emailRegex)
          return predicate.evaluate(with: email)
      }
      
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.view.endEditing(true)
          return false
      }

}
