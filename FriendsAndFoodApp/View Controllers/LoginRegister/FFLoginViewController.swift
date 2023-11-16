//
//  FFLoginViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/7/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var emailerrorLabel:UILabel!
    @IBOutlet weak var pwdErrorLabel:UILabel!
    
    var isFirstLaunch:Bool?
    var loginUser: FFUserObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FFBaseClass.sharedInstance.setStringValue(stringValue: "no", key: "isJustInstalled")
        //        emailTextField.text = "haegyseverine@yahoo.fr"
        //        passwordTextField.text = "Mesbounes4!"
        
        //        emailTextField.text = "neethu@luminescent-digital.com"
        //        passwordTextField.text = "Neethu123"
        
        //        emailTextField.text = "natafael@hotmail.fr"
        //        passwordTextField.text = "123456"
        
        //        emailTextField.text = "vikas.mishra@iskpro.com"
        //        emailTextField.text = "narendra.kumar@iskpro.com"
        //        passwordTextField.text = "123456"
        
        //        emailTextField.text = "mb@mydigitalys.com"
        //        passwordTextField.text = "mb654321"
        //        emailTextField.text = "rachit.kumar@iskpro.com"
        //        passwordTextField.text = "123456"
        
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
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func forgotPwdButtonTapped(_ sender : Any){
        
    }
    
    @IBAction func loginButtonTapped(_ sender : Any){ // login button action
        if validateInput(email: emailTextField.text, pwd: passwordTextField.text) {
            print("logged in...")
            callLoginAPI()
        }
    }
    
    @IBAction func laterButtonTapped(_ sender : Any){ // navigation without logging in
        FFBaseClass.sharedInstance.clearUser()
        goToNextVC()
    }
    
    @IBAction func registerButtonTapped(_ sender : Any){
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
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
    
    func isValidEmail(email: String) -> Bool { //  validating email
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "self matches %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func isValidPassword(password:String) -> Bool{ // validating password
        let isValid =  (password.count >= 6) ? true : false
        return isValid
        
    }
    
    func validateInput(email:String?, pwd:String?) -> Bool { // Check if email and password fields are not empty and are in valid form
        emailerrorLabel.isHidden = true
        pwdErrorLabel.isHidden = true
        if let emailString = email?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , let password = pwd?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines){
            
            if emailString.isEmpty {
                emailerrorLabel.text = "\(StringConstants.Alert.Messages.fieldRequired)"
                emailerrorLabel.isHidden = false
            }else  if !isValidEmail(email: emailString){
                emailerrorLabel.isHidden = false
                emailerrorLabel.text = "\(StringConstants.Alert.Messages.Incorrectemail)"
            }
            if password.isEmpty {
                pwdErrorLabel.text = "\(StringConstants.Alert.Messages.fieldRequired)"
                pwdErrorLabel.isHidden = false
            }else if !isValidPassword(password: password){
                pwdErrorLabel.isHidden = false
                pwdErrorLabel.text = "\(StringConstants.Alert.Messages.Incorrectpassword)"
            }
            
            if pwdErrorLabel.isHidden && emailerrorLabel.isHidden {
                return true
            }else {
                return false
            }
            
            
        }
        return false
    }
    
    func callLoginAPI(){ // login webservice call
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.login(email:emailTextField.text , password: passwordTextField.text, success: { (response:FFBaseResponseModel?) in
            print(response)
            FFBaseClass.sharedInstance.saveUser(user: response)
            FFLoaderView.hideInView(view: self.view)
            
            self.loginUser = response?.user
            
            
            let isJustInstalled = FFBaseClass.sharedInstance.getStringValue(key: "isJustInstalled")
            if isJustInstalled == "no"{
                self.goToNextVC()
            }else{
                if let isProfeessional = self.loginUser?.invitedby?.isprofessional{
                    
                    if isProfeessional == 1{
                        
                        if let isStore = self.loginUser?.invitedby?.isstore{
                            if isStore == 1{
                                self.showInvitePopUp(whichType: "store", title: "Welcome \(self.loginUser?.firstName ?? "") \(self.loginUser?.lastName ?? "")!", message: "You was invited by \(self.loginUser?.invitedby?.username ?? "") works in \(self.loginUser?.invitedby?.ownerofstorename ?? ""). \n Do you want to follow ?", option1: "I follow", option2: "Later",dataId: self.loginUser?.invitedby?.ownerofstoreid)
                            }
                        }
                        
                        if let isRestaurant = self.loginUser?.invitedby?.isrestaurant{
                            if isRestaurant == 1{
                                self.showInvitePopUp(whichType: "restaurant", title: "Welcome \(self.loginUser?.firstName ?? "") \(self.loginUser?.lastName ?? "")!", message: "You was invited by \(self.loginUser?.invitedby?.username ?? ""). \n Do you want to add it as a friend ?", option1: "I follow", option2: "Later", dataId: self.loginUser?.invitedby?.ownerofrestaurantid)
                            }
                        }
                        
                    }else{
                        
                        self.showInvitePopUp(whichType: "nonprofession", title: "Welcome \(self.loginUser?.firstName ?? "") \(self.loginUser?.lastName ?? "")!", message: "You was invited by \(self.loginUser?.invitedby?.username ?? ""). \n Do you want to add it as a friend ?", option1: "I confirm", option2: "Later", dataId: self.loginUser?.invitedby?.userid)
                        
                    }
                }else{
                    
                    self.goToPrefernces()
                    
                }
                
            }
            
            
        }) { (error) in
            print(error)
            
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func showInvitePopUp(whichType:String, title: String, message: String, option1: String, option2: String, dataId: Int? ){
        presentAlertWithTitle(title: title, message: message, options: option1, option2) { (option) in
            print("option: \(option)")
            switch(option) {
            case 0:
                print("option one")
                if whichType == "store"{
                    self.likeStore(storeId: dataId)
                }else if whichType == "restaurant"{
                    self.likeRestaurant(restId: dataId)
                }else{
                    self.acceptFrndRequest(userId: "\(dataId ?? 0)")
                }
                break
            case 1:
                self.goToPrefernces()
                print("option two")
            default:
                break
            }
        }
    }
    func likeRestaurant(restId: Int?){ // like restaurant webservice
        FFManagerClass.likeRestaurant(id: restId, success: { (response) in
            FFBaseClass.sharedInstance.showAlert(mesage: response.message!, view: self)
            self.goToNextVC()
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func likeStore(storeId: Int?){ // like store webservice
        FFManagerClass.likeStore(id: storeId, success: { (response) in
            FFBaseClass.sharedInstance.showAlert(mesage: response.message!, view: self)
            self.goToNextVC()
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func acceptFrndRequest(userId: String){ // accept freind request webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.acceptFriendRequest(id: "\(userId)", success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.goToPrefernces()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func goToNextVC(){ // navigation to home view controller
        if isFirstLaunch == true {
            self.performSegue(withIdentifier: "goToHome", sender: self)
        }else {
            //            self.navigationController?.popViewController(animated: true)
            self.performSegue(withIdentifier: "goToHome", sender: self)
        }
    }
    
    func goToPrefernces(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFirstPrefernceVC") as! FFFirstPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


