//
//  FFEditProfileViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 28/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFEditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    var imageData: Data?
    var imageName: String?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var lastnameErrorLabel: UILabel!
    
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var birthdateErrorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    
     var imagePicker = UIImagePickerController()
    
    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    
    var userDetail:FFUserObject?
    var profileImageObject:FFImageObject?
    var editRequest = FFEditProfileRequestModel()
    @IBOutlet weak var missBtn:UIButton!
    @IBOutlet weak var mrBtn:UIButton!
    var isGender:Bool?
    @IBOutlet weak var dateHeadLabel: UILabel!
    @IBOutlet weak var phoneHeadLabel: UILabel!
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateHeadLabel.text = "Birthdate"
        phoneHeadLabel.text = "Phone"

        firstNameTextField.delegate = self
        lastnameTextfield.delegate =  self
        birthdateTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        isGender = false
        customiseBtn(button: mrBtn)
        customiseBtn(button: missBtn)

        if let _ = userDetail {
            populateData()
        }
        self.birthdateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1

//        showDatePicker()

        // Do any additional setup after loading the view.
    }
    

   


    @objc func tapDone() {
        
        
           if let datePicker = self.birthdateTextField.inputView as? UIDatePicker { // 2-1
               let dateformatter = DateFormatter() // 2-2
               dateformatter.dateStyle = .medium // 2-3
            dateformatter.dateFormat = "dd-MM-yyyy"

            if #available(iOS 13.4, *) {
                datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
                datePicker.preferredDatePickerStyle = .wheels
            }

               self.birthdateTextField.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.birthdateTextField.resignFirstResponder() // 2-5
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
                editRequest.gender = "2"
                 missBtn.isSelected = false
                 mrBtn.isSelected = false
                 
                 hideOrShowTick(btn: missBtn, shouldShow: false)
                 hideOrShowTick(btn: mrBtn, shouldShow: false)
                 
                 sender.isSelected = true
                 hideOrShowTick(btn: sender, shouldShow: true)
                 
             }
         
             @IBAction func mrBtnTapped(_ sender : UIButton) { // dificulty buton selection action
                 isGender = true

                editRequest.gender = "1"

         missBtn.isSelected = false
         mrBtn.isSelected = false
         
         hideOrShowTick(btn: missBtn, shouldShow: false)
         hideOrShowTick(btn: mrBtn, shouldShow: false)
         
         sender.isSelected = true
         hideOrShowTick(btn: sender, shouldShow: true)

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateData(){ // data populate from webservie response
        
        firstNameTextField.text = self.userDetail?.firstName
        lastnameTextfield.text = self.userDetail?.lastName
        birthdateTextField.text = self.userDetail?.birthdate
        emailTextField.text = self.userDetail?.email
        phoneTextField.text = self.userDetail?.phone

        if let photo = self.userDetail?.photo , !photo.isEmpty{
            let imageUrl:URL = URL(string: photo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
//            self.profileImageView.kf.setImage(with: imageUrl)
            self.profileImageView.kf.setImage(with: imageUrl, options: [.forceRefresh])
        }
        
        if let gender = self.userDetail?.gender{
            if gender == 1{
                mrBtnTapped(mrBtn)
                editRequest.gender = "1"
            }
            if gender == 2{
                mrBtnTapped(missBtn)
                editRequest.gender = "2"
            }
        }
        
        
    }
    
    
    func isValidPassword(text : String) -> Bool { // password validity check
        
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
    
    func isValidEmail(email: String) -> Bool { // email validation
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "self matches %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func validateFields() -> Bool { // vlidate the fields
        
        var isValid = true
        firstNameErrorLabel.text = ""
        lastnameErrorLabel.text = ""
        birthdateErrorLabel.text = ""
        emailErrorLabel.text = ""
        phoneErrorLabel.text = ""
        
//        editRequest = FFEditProfileRequestModel(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["":""]))
        editRequest.ok = "1"
        if let id = self.userDetail?.id {
          editRequest.id = "\(id)"
        }
        if let imgObj = self.profileImageObject {
            editRequest.image = imgObj.name
        }else{
            editRequest.image = ""
        }
        
        if let fname = firstNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !fname.isEmpty {
            editRequest.firstname = fname
        }else {
            firstNameErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let lname = lastnameTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !lname.isEmpty {
            editRequest.lastName =  lname
        }else {
            lastnameErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let bdate = birthdateTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !bdate.isEmpty {
            editRequest.birthdate = bdate

            
        }else {
            birthdateErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
            
            if !isValidEmail(email: email ){
                emailErrorLabel.text = invalidErrorMsg
                isValid =  false
            }else {
                editRequest.email = email
            }
            
        }else {
            emailErrorLabel.text = emptyErrorMsg
            isValid =  false
        }
        
        if let pwd = phoneTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !pwd.isEmpty {
            if pwd.count < 10 {
                phoneErrorLabel.text = invalidErrorMsg
                isValid =  false
            }else {
                editRequest.phone = pwd
            }
        }else {
            phoneErrorLabel.text = emptyErrorMsg
            isValid = false
        }
        
        return isValid
    }
    
     @IBAction func backBtnTapped(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateProfileBtnTapped(_ sender: Any){ // edit profile webservice
        
        if validateFields() ==  true {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.uploadProfileImageData(request: self.editRequest, imageData: imageData ?? Data(),imageName:imageName ?? "" ,success: { (resp) in
                print(resp)
                FFLoaderView.hideInView(view:  self.view)
                self.navigationController?.popViewController(animated: true)
                
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                print(error)
            }
        }
        
    }
    
    @IBAction func editPhotoBtnTapped(_ sender: Any){ // edit photo button action
 
        imagePicker.delegate = self
      
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take an image", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Search the gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
            
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

//        image slection and upload function
        
        let image             = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        
        imageName = "IMG_\(Date().timeIntervalSinceReferenceDate)"
        imageName = imageName?.replacingOccurrences(of: ".", with: "")
        imageName?.append(".jpg")
        
        let localPath         = photoURL.appendingPathComponent(imageName ?? "")
        
        if !FileManager.default.fileExists(atPath: localPath!.path) {
            do {
                try image.pngData()?.write(to: localPath!)
                print("file saved")
            }catch {
                print("error saving file")
            }
        }
        else {
            print("file already exists")
        }
        imageData = image.jpeg(.low) ?? Data()
        self.profileImageView.image =  image
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtnTapped(_ sender: Any){ // cancel button action
        self.navigationController?.popViewController(animated: true)
    }
 

}
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
//         Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
                toolBar.barStyle = .blackTranslucent
        var items = [UIBarButtonItem]()
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        cancel.tintColor = UIColor.white

        items.append(
            cancel
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        let okButton =  UIBarButtonItem(title: "Ok", style: .done, target: target, action: selector) //7
        okButton.tintColor = UIColor.white

        items.append(
            okButton
        )
        
        toolBar.items = items
        
        self.inputAccessoryView = toolBar //9
        
        

    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}

