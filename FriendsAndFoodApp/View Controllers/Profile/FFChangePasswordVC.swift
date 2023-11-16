
//
//  FFChangePasswordVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFChangePasswordVC: UIViewController {
    @IBOutlet weak var oldPassTextfield: UITextField!
    @IBOutlet weak var nwPassTextfield: UITextField!
    @IBOutlet weak var confirmPassTextfield: UITextField!

    @IBOutlet weak var oldpassErrorLabel: UILabel!
    @IBOutlet weak var neewpassErrorLabel: UILabel!
    @IBOutlet weak var confirmpassErrorLabel: UILabel!
    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    var changePasswordRequest = FFChangePasswordRequestModel()
    var userId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> Bool { // vlidate the fields
        
        var isValid = true
        oldpassErrorLabel.text = ""
        neewpassErrorLabel.text = ""
        confirmpassErrorLabel.text = ""
        
      if let id = userId {
              changePasswordRequest.id = "\(id)"
            }
        
        if let oldpass = oldPassTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !oldpass.isEmpty {
            changePasswordRequest.oldpassword = oldpass
        }else {
            oldpassErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
     
      if let newpass = nwPassTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !newpass.isEmpty {
                changePasswordRequest.newpassword = newpass
            }else {
                neewpassErrorLabel.text = emptyErrorMsg
                isValid =  false
            }
        if let confirmpass = confirmPassTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !confirmpass.isEmpty {
            if confirmpass == nwPassTextfield.text{
                changePasswordRequest.confirmnewpassword = confirmpass

            }else{
                confirmpassErrorLabel.text = "New and Confirm password does not match"
                isValid =  false

            }
                }else {
                    confirmpassErrorLabel.text = emptyErrorMsg
                    isValid =  false
                }
        return isValid
    }
    
    @IBAction func confirmBtnTapped(_ sender: Any){ // edit photo button action
        if validateFields(){
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.changePassword(changePasswordRequest: self.changePasswordRequest, success: { (response) in
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
}
