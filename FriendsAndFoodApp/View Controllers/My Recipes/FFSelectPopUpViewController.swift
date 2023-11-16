//
//  FFSelectPopUpViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 08/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import DropDown

protocol PopUpDelegate {
    func confirmBtnTapped(quantity:String, measure:FFMeasureObject)
}

class FFSelectPopUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quantityTextField:UITextField!
    @IBOutlet weak var measureTextField:UITextField!
    
    var popDelegate:PopUpDelegate?
    let dropDown = DropDown()
    var measureList:[FFMeasureObject] = []
    var selectedmeasure:FFMeasureObject?
    
    var selectedIngredientId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        measureTextField.delegate = self
        callMeasureAPI()
        customiseDropDown()
        
        // Do any additional setup after loading the view.
    }
    
    func customiseDropDown(){ // measure pop up customisation
        dropDown.anchorView = measureTextField
        dropDown.dataSource = measureList.map { $0.name! }
        dropDown.direction = .any
        dropDown.selectionAction = { (index: Int, item: String) in
            self.selectedmeasure = self.measureList[index]
            self.measureTextField.text = item
            self.dropDown.hide()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBtnTapped(_ sender: Any) { // confirm button action
        
        if quantityTextField.text?.isEmpty == true {
            FFBaseClass.sharedInstance.showAlert(mesage: "Enter quantity", view: self)
            return
        }
        
        
        if measureTextField.text?.isEmpty == true {
            FFBaseClass.sharedInstance.showAlert(mesage: "Select measure", view: self)
            return
        }
        //save measure also
       print(selectedmeasure)
        
        if let delegate =  popDelegate {
            delegate.confirmBtnTapped(quantity: quantityTextField.text!, measure: selectedmeasure!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtntapped(_ sender : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        quantityTextField.resignFirstResponder()
        self.view.endEditing(true)
        if self.measureList.count > 0 {
         dropDown.show()
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "Please wait while we load measure list", view: self)
        }
    }
    
    func callMeasureAPI() { // get measure list webservice
        
        FFManagerClass.getMeasureList(ingredeintID: self.selectedIngredientId, success: { (response) in
            self.measureList = response
            self.dropDown.dataSource = self.measureList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            
        }) { (error) in
            print(error)
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
