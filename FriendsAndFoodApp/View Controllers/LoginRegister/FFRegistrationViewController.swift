//
//  FFRegistrationViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/30/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFRegistrationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var genderErrorLabel: UILabel!

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var lastnameErrorLabel: UILabel!

    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameErrorLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!

    var emptyErrorMsg = StringConstants.Alert.Messages.fieldRequired
    var invalidErrorMsg = "Invalid field"
    
    var isFirstLaunch:Bool?
    var registerRequest = FFRegisterRequestModel()
    @IBOutlet weak var missBtn:UIButton!
    @IBOutlet weak var mrBtn:UIButton!
    var isGender:Bool?

    @IBOutlet weak var termsTextView:UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        isGender = false
        customiseBtn(button: mrBtn)
        customiseBtn(button: missBtn)

        firstNameTextField.delegate = self
        lastnameTextfield.delegate =  self
//        nickNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        termsTextView.delegate = self
        customiseTermsAndConditions()
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
                registerRequest.gender = "2"

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

                registerRequest.gender = "1"

        missBtn.isSelected = false
        mrBtn.isSelected = false
        
        hideOrShowTick(btn: missBtn, shouldShow: false)
        hideOrShowTick(btn: mrBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)

            }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            
            scrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - self.bottomLayoutGuide.length, right: 0)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        scrollview.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        if validateFields() {
            callRegisterAPI()
        }
        
    }
    
    func callRegisterAPI(){  //register user webservice
        print("register api called..")
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.registerUser(requestModel: self.registerRequest, success: { (response) in
            print(response)
            FFBaseClass.sharedInstance.saveUser(user: response)
            FFLoaderView.hideInView(view: self.view)
            
            self.goToNextVC()
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }

        
    }
    
    func goToNextVC(){ // navigate to next view controller
        if isFirstLaunch == true {
            self.performSegue(withIdentifier: "goHome", sender: self)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateFields() -> Bool { // validating all the fields in the form
        
        var isValid = true
        genderErrorLabel.text = ""
        firstNameErrorLabel.text = ""
        lastnameErrorLabel.text = ""
//        nickNameErrorLabel.text = ""
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
        if isGender == false{
            genderErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let fname = firstNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !fname.isEmpty {
            registerRequest.firstname = fname
        }else {
            firstNameErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = lastnameTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            registerRequest.lastName =  lname
        }else {
            lastnameErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
//        if let nname = nickNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !nname.isEmpty {
//
//            if nname.count <= 3 {
//                nickNameErrorLabel.text = invalidErrorMsg
//                isValid =  false
//            }else {
//                registerRequest.nickName = nname
//            }
//
//        }else {
//            nickNameErrorLabel.text = emptyErrorMsg
//            isValid =  false
//        }
        
        if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
            
            if !isValidEmail(email: email ){
                emailErrorLabel.text = invalidErrorMsg
                isValid =  false
            }else {
                registerRequest.email = email
            }
            
        }else {
            emailErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let pwd = passwordTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !pwd.isEmpty {
            if pwd.count <= 6 {
                passwordErrorLabel.text = invalidErrorMsg
                isValid =  false
            }else {
                registerRequest.password = pwd
            }
        }else {
            passwordErrorLabel.text = emptyErrorMsg
            isValid = false
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
    
    func customiseTermsAndConditions(){
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let linkAttributes:[NSAttributedString.Key:Any] = [.link : NSURL(string: "http://ff.mydigitalys.com/cgu.php") ?? "", .paragraphStyle : style]
        let str:NSString = "By using friends & food, you agree on our Terms of Service and Privacy Policy"
        let attrString = NSMutableAttributedString(string: str as String)
        attrString.setAttributes(linkAttributes, range: str.range(of: "Terms of Service"))
        attrString.setAttributes(linkAttributes, range: str.range(of: "Privacy Policy"))
        
        
        self.termsTextView.attributedText = attrString
        self.termsTextView.isUserInteractionEnabled = true
        self.termsTextView.isEditable = false
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
