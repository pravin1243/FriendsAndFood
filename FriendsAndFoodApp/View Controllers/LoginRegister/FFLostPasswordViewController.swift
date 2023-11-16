//
//  FFLostPasswordViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/31/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFLostPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var lostPassWordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var resetCodeView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeErrorLabel: UILabel!
    
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!

    
    @IBOutlet weak var confirmView: UIView!
    
    var resetToken:String?
    var emailString:String?
    var codeString:String?
    var pwdString:String?
    var confirmPwdString:String?
    
    var emptyErrorMsg = "This field is required"
    var invalidEmailErrorMsg = "Invalid Email"
    var invalidPwdErrorMsg = "Invalid Password"
    var pwdNotMatchMsg = "Passwords do not match"

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        codeTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        lostPassWordView.isHidden = false
        resetCodeView.isHidden = true
        resetPasswordView.isHidden = true
        confirmView.isHidden = true
        
//        emailTextField.text = "neethumanikantan@qburst.com"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) { // move fields when keyboard appears
        
        if let userInfo = sender.userInfo {
            
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - self.bottomLayoutGuide.length, right: 0)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }

    
    //MARK: - IBAction Methods
    
    @IBAction func retrieveButtonTapped(_ sender : Any){ // retrieve button action
        
        emailErrorLabel.text = ""
        
        if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
            
            if !isValidEmail(email: email) {
                emailErrorLabel.text = invalidEmailErrorMsg
                return
            }
            self.emailString  = email
            
        }else {
            emailErrorLabel.text = emptyErrorMsg
            return
        }
        
        callRetrievePasswordAPI()
        
    }
    
    @IBAction func resendEmailBtnTapped(_ sender  :Any) {
        callRetrievePasswordAPI()
    }
    
    @IBAction func cancelButtonTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func resetCodeConfirmBtnTapped(_ sender : Any){ // reset code button action
        codeErrorLabel.text = ""
        
        if let code = codeTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            if code.isEmpty {
                codeErrorLabel.text = emptyErrorMsg
                return
            }
            codeErrorLabel.text = ""
            self.codeString = code
            
        }else {
            codeErrorLabel.text = emptyErrorMsg
        }
        callResetCodeConfirmAPI()
    }
    
    @IBAction func changePasswordBtnTapped(_ sender : Any){ // change password button action
        passwordErrorLabel.text = ""
        confirmPasswordErrorLabel.text = ""
        
        if let password = passwordTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !password.isEmpty {
            if isValidPassword(text: password){
                pwdString = password
            }else {
                passwordErrorLabel.text = invalidPwdErrorMsg
                return
            }
        }else {
            passwordErrorLabel.text = emptyErrorMsg
            return
        }
        if let confirmPwd = confirmPasswordTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , !confirmPwd.isEmpty {
            
            if confirmPwd == pwdString {
                confirmPwdString = confirmPwd
                callResetPasswordAPI()
            }else {
                confirmPasswordErrorLabel.text =  pwdNotMatchMsg
            }
            
        }else {
            confirmPasswordErrorLabel.text = emptyErrorMsg
            return
        }
        
        
        
    }
    
    //MARK: - API calls
    
    func callRetrievePasswordAPI(){ // retrieve pasword webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.retrievePassword(email: self.emailString, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.resetToken = response.resetToken
            self.emailString = response.email
            self.hideAllViews()
            self.resetCodeView.isHidden = false
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    
    func callResetCodeConfirmAPI(){ // reset code web service
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.validateCode(email: self.emailString, code: self.codeString, token: self.resetToken, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            if let succes = response.status , succes == 1 {
                self.hideAllViews()
                self.resetPasswordView.isHidden = false
            }else {
                FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "Error", view: self)
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callResetPasswordAPI(){ // reset password webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.resetPassword(email: emailString, code: codeString, token: resetToken, password: pwdString, confirmPwd: confirmPwdString, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            if let succes = response.status , succes == 1 {
                self.view.endEditing(true)
                self.hideAllViews()
                self.confirmView.isHidden = false
            }else {
                FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "Error", view: self)
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }

    
    //MARK: - Custom Functions
    
    func isValidPassword(text : String) -> Bool { // check password validity
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalChk = texttest.evaluate(with: text)
        
        let smallLetterRegEx  = ".*[a-z]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        let smallChk = texttest2.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberChk = texttest1.evaluate(with: text)
        
        let lengthChk = text.count >= 6 ? true : false
        
        return capitalChk && numberChk && lengthChk && smallChk
        
    }

    func isValidEmail(email: String) -> Bool { // check email validity
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "self matches %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func hideAllViews(){ // hide other views
        lostPassWordView.isHidden = true
        resetCodeView.isHidden = true
        resetPasswordView.isHidden = true
        confirmView.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
}
