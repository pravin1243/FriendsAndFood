//
//  FFAddMenuViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFAddMenuViewController: UIViewController {

    @IBOutlet weak var addBtn:UIButton!

    @IBOutlet weak var entreeBtn:UIButton!
    @IBOutlet weak var platBtn:UIButton!
    @IBOutlet weak var dessertBtn:UIButton!
    @IBOutlet weak var titleTextField:UITextField!
    @IBOutlet weak var priceTextField:UITextField!
    var restaurantID:Int?
    var menuRequest = FFAddMenuRequestModel()
    var selectedDish:String?
    var menuID:String?
    var isEdit:Bool?
    var price:String?
    var currency:String?
    var currencyId:String?
    var name:String?
    @IBOutlet weak var currencyTextField:UITextField!
    var recipeTypeId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = name
        priceTextField.text = price
        currencyTextField.text = currency

        self.adjustImageAndTitleOffsetsForButton(button: entreeBtn)
        self.adjustImageAndTitleOffsetsForButton(button: platBtn)
        self.adjustImageAndTitleOffsetsForButton(button: dessertBtn)
       if recipeTypeId == 1{
            entreeBtn.isSelected = true
            hideOrShowTick(btn: entreeBtn, shouldShow: true)
            selectedDish = entreeBtn.titleLabel?.text

        }else if recipeTypeId == 2{
            platBtn.isSelected = true
            hideOrShowTick(btn: platBtn, shouldShow: true)
            selectedDish = platBtn.titleLabel?.text

        }else if recipeTypeId == 3{
            dessertBtn.isSelected = true
            hideOrShowTick(btn: dessertBtn, shouldShow: true)
            selectedDish = dessertBtn.titleLabel?.text

       }else{
        
        }
        if isEdit == true{
            addBtn.setTitle("Modify Menu", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
 //         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow , object: nil)
  //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
      }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - IBAction methods
     
     @IBAction func dishBtnTapped(_ sender : UIButton){ // dish selection action
         entreeBtn.isSelected = false
         platBtn.isSelected = false
         dessertBtn.isSelected = false
         
         
         hideOrShowTick(btn: entreeBtn, shouldShow: false)
         hideOrShowTick(btn: platBtn, shouldShow: false)
         hideOrShowTick(btn: dessertBtn, shouldShow: false)
         
         sender.isSelected = true
         hideOrShowTick(btn: sender, shouldShow: true)
         selectedDish = sender.titleLabel?.text
         
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

    func adjustImageAndTitleOffsetsForButton (button: UIButton) { // vertically align text and image in uibutton
        
        let spacing: CGFloat = 6.0
        
        let imageSize = button.imageView!.frame.size
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        customiseBtn(button: button)
        
    }
    func customiseBtn(button: UIButton){
        
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        button.layer.borderWidth = 0.5
        
        button.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        button.setTitleColor(UIColor.primary, for: UIControl.State.selected)
    }
    
    func getTypeId() -> String{ // get type id from UI
        var typeId = "0"
        if entreeBtn.isSelected {
            typeId = "1"
        }else  if platBtn.isSelected {
            typeId = "2"
        }else {
            typeId = "3"
        }
        return typeId
    }
    
    func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
        
        if entreeBtn.isSelected || platBtn.isSelected || dessertBtn.isSelected {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "Enter dish type", view: self)
            return false
        }
        
        if let title = titleTextField.text, !title.isEmpty {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "Enter title", view: self)
            return false
        }
        
        if let title = priceTextField.text, !title.isEmpty {
                   
               }else {
                   FFBaseClass.sharedInstance.showAlert(mesage: "Enter price", view: self)
                   return false
               }
        return true
    }
    
    @IBAction func nextBtnTapped(_ sender : Any){ // next buttin action
        
        if validateStepOneFields() {
            menuRequest.recipetypeid = getTypeId()
            menuRequest.price = priceTextField.text
            menuRequest.name = titleTextField.text
            menuRequest.currencyid = currencyId
            menuRequest.isEdit = isEdit

            if isEdit == true{
                menuRequest.restaurantID = menuID

            }else{
                menuRequest.restaurantID = String("\(restaurantID ?? 0)")

            }
            
            FFLoaderView.showInView(view: self.view)
                  FFManagerClass.addMenu(menuRequest: menuRequest, success: { (response) in
                      print(response)
//                       self.navigationController?.popToRootViewController(animated: true)
                    self.navigationController?.popViewController(animated: true)
                      FFLoaderView.hideInView(view: self.view)
                  }) { (error) in
                      print(error)
                      FFLoaderView.hideInView(view: self.view)
                      FFBaseClass.sharedInstance.showError(error: error, view: self)
                  }
        }
    }

    @IBAction func closeBtnTapped(_ sender : Any){
          self.navigationController?.popViewController(animated: true)
      }
    
    @IBAction func deleteBtnTapped(_ sender : Any){
            presentAlertWithTitle(title: "Supprimer le menu", message: "Êtes-vous sûr de vouloir supprimer ce menu?", options: "Oui", "Non") { (option) in
                   print("option: \(option)")
                   switch(option) {
                       case 0:
                           print("option one")
                           self.deleteMenuAPI()
                           break
                       case 1:
                           print("option two")
                       default:
                           break
                   }
               }
        
    }
    
    func deleteMenuAPI() { // delete recipe button action
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.deleteMenu(menuID: menuID, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            
//            if let userr = FFBaseClass.sharedInstance.getUser() {
//                self.navigationController?.popViewController(animated: true)
//
//            }
        self.navigationController?.popViewController(animated: true)

        }) { (erroe) in
            print(erroe)
            FFLoaderView.hideInView(view: self.view)
        }
    }

}
