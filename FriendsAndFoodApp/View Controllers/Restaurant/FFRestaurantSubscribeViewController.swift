//
//  FFRestaurantSubscribeViewController.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 09/08/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFRestaurantSubscribeViewController: UIViewController, UITextFieldDelegate , UITextViewDelegate {
    
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var addressTextField:UITextField!
    @IBOutlet weak var addressErrorLabel: UILabel!
    
    @IBOutlet weak var phoneTextField:UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    
    @IBOutlet weak var cityTextField:UITextField!
    @IBOutlet weak var cityErrorLabel: UILabel!
    
    @IBOutlet weak var countryTextField:UITextField!
    @IBOutlet weak var countryeErrorLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var termsTextView:UITextView!

    
    var reqObj = FFRestaurantSubscribeRequestModel()
    var emptyErrorMsg = "This field is required"
    
    var restId:Int?
    var countryList:[FFPlaceObject] = []
    var cityList:[FFPlaceObject] = []
    
    let dropDown = DropDown()
    var currentTextField:UITextField?
    var selectedCountry:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nameTextField.text = "test restaurant 1"
//        phoneTextField.text = "1234"
//        addressTextField.text = "test"
//        cityTextField.text = "test city"
//        countryTextField.text = "test country"
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        cityTextField.delegate = self
        countryTextField.delegate = self
        
        termsTextView.delegate = self
        
        getCountriesList()
        customiseDropDown()
        customiseTermsAndConditions()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Custom Functions
    
    func customiseDropDown(){ // ad dropdown for cuntry and city textfields
        
        dropDown.anchorView = currentTextField
        if currentTextField == countryTextField {
            dropDown.dataSource = self.countryList.map { $0.name! }
            
        }else if currentTextField == cityTextField {
            dropDown.dataSource = self.cityList.map { $0.name! }

        }
        
        dropDown.direction = .any
        dropDown.selectionAction = { (index: Int, item: String) in
            self.currentTextField?.text = item
            self.dropDown.hide()
            if self.currentTextField == self.countryTextField {
                self.selectedCountry = self.countryList[index]
                self.getCityList()
            }else if self.currentTextField == self.cityTextField {
                self.selectedCity = self.cityList[index]

            }
        }
        
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
    
 
    @IBAction func closeViewBtnPressed(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender : Any){
        
//        if let _ = FFBaseClass.sharedInstance.getUser() {
//
//            FFBaseClass.sharedInstance.showAlert(mesage: "Please login to continue", view: self)
//
//        }else {
            if  self.validateFields() {
                self.callSignUpAPI()
            }
//        }
    }
    
    func callSignUpAPI(){ // restaurant subscribe webservice intergration
        
        reqObj.restId = self.restId
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.subscribeRestaurant(requestModel: self.reqObj, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            let vc = self.navigationController?.viewControllers[1] as! FFRestaurantDetailViewController
            vc.isOwner = true
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
        
    }
    
    func validateFields() -> Bool { // validate form values
        
        var isValid = true
        nameErrorLabel.text = ""
        phoneErrorLabel.text = ""
        addressErrorLabel.text = ""
        cityErrorLabel.text = ""
        countryeErrorLabel.text = ""
        
        
        if let fname = nameTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !fname.isEmpty {
            reqObj.name = fname
        }else {
            nameErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = phoneTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            reqObj.phone =  lname
        }else {
            phoneErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = addressTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            reqObj.address =  lname
        }else {
            addressErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            reqObj.city =  lname
        }else {
            cityErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = countryTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            reqObj.country =  lname
        }else {
            countryeErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        
        return isValid
    }
    
    func getCountriesList(){ // country list webservice
        FFManagerClass.getCountriesList(searchText: "", success: { (response) in
            self.countryList = response
        }) { (error) in
            
        }
    }
    
    func getCityList(){ // city list webservice
        
        FFManagerClass.getCitiesList(searchText: "", countryid: selectedCountry?.id, regionid: "", success: { (responseq) in
            self.cityList = responseq
        }) { (error) in
            
        }
        
    }
    
    func customiseTermsAndConditions(){ // terms and conditions formating and styling
        
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
    
    //MARK:- TextField  functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdown on textfield selection
        currentTextField = textField
        self.dropDown.hide()
        
        self.dropDown.anchorView = currentTextField
        if textField == countryTextField {
            self.dropDown.dataSource = self.countryList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }else if textField == cityTextField {
            self.dropDown.dataSource = self.cityList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }
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
