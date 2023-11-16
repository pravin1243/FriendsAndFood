//
//  FFProfessionalInfoVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 24/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown
class FFProfessionalInfoVC: UIViewController {

    
    @IBOutlet weak var companyNameTextfield: UITextField!
    @IBOutlet weak var companyNumTextfield: UITextField!
    @IBOutlet weak var jobTextfield: UITextField!
    @IBOutlet weak var companyNameErrorLabel: UILabel!
    @IBOutlet weak var companyNumErrorLabel: UILabel!
    @IBOutlet weak var jobErrorLabel: UILabel!
    var emptyErrorMsg = "This field is required"
    var invalidErrorMsg = "Invalid field"
    var professionalRequest = FFUpdateProfessionalInfoRequestModel()
    var userId: Int?
    var functionList:[FFPlaceObject] = []
    var selectedFunction:FFPlaceObject?
    let dropDown = DropDown()
    var userDetail:FFUserObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        getFunctionList()
        if let compname = self.userDetail?.companyname {
        companyNameTextfield.text = compname
        }
        if let compno = self.userDetail?.companyidentificationnumber {
            companyNumTextfield.text = compno
        }
        
        // Do any additional setup after loading the view.
    }
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
         
         
             dropDown.anchorView = jobTextfield
             dropDown.dataSource = self.functionList.map { $0.name! }
         
         dropDown.direction = .any
         dropDown.selectionAction = { (index: Int, item: String) in
             self.jobTextfield.text = item
             self.dropDown.hide()
             self.selectedFunction = self.functionList[index]
             self.jobTextfield.resignFirstResponder()
         }
     }
     
   
    func getFunctionList(){ // country list webservice
         
         FFManagerClass.getFunctionList(type: "function", success: { (response) in
             self.functionList = response
            for (index, item) in self.functionList.enumerated(){
                if let jobid = self.userDetail?.jobid{
                    if jobid == self.functionList[index].idInt{
                        self.jobTextfield.text = self.functionList[index].name
                    }
                    
                }
            }
            self.customiseDropDown()
         }) { (error) in
             
         }
     }
    func validateFields() -> Bool { // vlidate the fields
              
              var isValid = true
              jobErrorLabel.text = ""
              companyNameErrorLabel.text = ""
              companyNumErrorLabel.text = ""

           
           
            if let id = userId {
                    professionalRequest.userid = "\(id)"
                  }
              if let function = jobTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !function.isEmpty {
                  professionalRequest.jobid = "\(selectedFunction?.idInt ?? 0)"
              }else {
                  jobErrorLabel.text = emptyErrorMsg
                  isValid =  false
              }
           
            if let cname = companyNameTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !cname.isEmpty {
               professionalRequest.companyname = cname
                  }else {
                      companyNameErrorLabel.text = emptyErrorMsg
                      isValid =  false
                  }
            if let cnum = companyNumTextfield.text?.trimmingCharacters(in: CharacterSet.whitespaces) , !cnum.isEmpty {
               professionalRequest.companyidentificationnumber = cnum
                       }else {
                           companyNumErrorLabel.text = emptyErrorMsg
                           isValid =  false
                       }
     
              return isValid
          }
          
          @IBAction func confirmBtnTapped(_ sender: Any){ // edit photo button action
              if validateFields(){
                  FFLoaderView.showInView(view: self.view)
                  FFManagerClass.updateProfessionalInfo(professionalRequest: self.professionalRequest, success: { (response) in
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

     @IBAction func functionBtnTapped(_ sender: Any){ // edit photo button action
        dropDown.show()
    }
}
