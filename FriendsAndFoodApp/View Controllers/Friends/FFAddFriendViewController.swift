//
//  FFAddFriendViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 04/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import DropDown

class FFAddFriendViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nicknameTxtField:UITextField!
    @IBOutlet weak var emailTxtField:UITextField!
    @IBOutlet weak var scrollview:UIScrollView!
    let dropDown = DropDown()
    var nicknameList:[FFUserObject] = []
    var inviteEmail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(StringConstants.Labels.AddaFriend)"
        
        nicknameTxtField.delegate = self
        emailTxtField.delegate = self
        nicknameTxtField.textColor = UIColor.primary
        emailTxtField.textColor = UIColor.primary
        
        customiseDropDown()
        
        FFBaseClass.sharedInstance.isAddFriend = true

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customiseDropDown(){ // dropdown customisation and action
        dropDown.anchorView = nicknameTxtField
        dropDown.direction = .any
        dropDown.dataSource = nicknameList.map { $0.nickName! }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.nicknameTxtField.text = item
//            self.emailTxtField.text = self.nicknameList[index].email
            
            var name = ""
                   if let lastname = self.nicknameList[index].lastName {
                       name = lastname.capitalizingFirstLetter() + " "
                   }
                   
                   if let firstname = self.nicknameList[index].firstName?.capitalizingFirstLetter() {
                       let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                       name = name + String(firstLetter)
                       name = name + "."
                   }
            self.emailTxtField.text = self.nicknameList[index].email
            self.inviteEmail = self.nicknameList[index].email
            self.dropDown.hide()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailTxtField {
            inviteFriendBtnTapped(self)
        }
        
        if textField == nicknameTxtField {
            searchFriendBtnTapped(self)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didChangeTextField(_ sender: UITextField){
        dropDown.hide()
        if (sender.text?.count)! >= 3 {
            callNickNameSuggestionAPI(searchText: sender.text!)
        }
        
    }
    
    func callNickNameSuggestionAPI(searchText:String?){ // nickname suggestion webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getNicknameList(searchString: searchText, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.dropDown.hide()
            self.nicknameList = response
            self.dropDown.dataSource = self.nicknameList.map { $0.firstName! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    @IBAction func inviteFriendBtnTapped(_ sender : Any){ // invite friend button action
        
        if let email = emailTxtField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !email.isEmpty {
//            if isValidEmail(email: email){ // check email validity
//                callInviteFriendAPI(email: email)
//            }else {
//                FFBaseClass.sharedInstance.showAlert(mesage: "Invalid email", view: self)
//                return
//            }
            
            
            callInviteFriendAPI(email: email)

        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.EnterEmail)", view: self)
            return
        }
        
    }
    
    @IBAction func searchFriendBtnTapped(_ sender : Any){ // search friend button action
        
        if let nickname = nicknameTxtField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !nickname.isEmpty {
            callSearchFriendByNicknameAPI(nickname: nickname)
         
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "Enter email", view: self)
            return
        }
        
    }
    
    
    func callInviteFriendAPI(email:String?){ // invite friend webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByEmail(email: email, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.emailTxtField.text = ""
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            self.emailTxtField.text = ""
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callSearchFriendByNicknameAPI(nickname:String){ //search friend webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByNickname(nickname: nickname, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.nicknameTxtField.text = ""
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            self.nicknameTxtField.text = ""
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "self matches %@", emailRegex)
        return predicate.evaluate(with: email)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
