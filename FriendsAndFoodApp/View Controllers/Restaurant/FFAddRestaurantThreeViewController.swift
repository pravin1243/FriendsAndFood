//
//  FFAddRestaurantThreeViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 25/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown

class FFAddRestaurantThreeViewController: FFAddRestaurantBaseController,UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UITextFieldDelegate {

    
    var deleteArray = [String]()
    let dropDown = DropDown()

    @IBOutlet weak var dietCollectionView:UICollectionView!
    @IBOutlet weak var dietCollectionViewHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var specialityTextField:UITextField!
    @IBOutlet weak var priceRangeTextField:UITextField!
    @IBOutlet weak var restDescTextField:UITextView!

    @IBOutlet weak var addImageBtn:UIButton!
    @IBOutlet weak var imageCollectionview:UICollectionView!
    @IBOutlet weak var collectionviewHeightConstraint: NSLayoutConstraint!
    var imagearray = [Any]()
    var imagePicker = UIImagePickerController()

    var specilaityList:[FFPlaceObject] = []
    var selectedSpeciality:FFPlaceObject?
    var allInterestList:[FFAllInterestObject] = []
    var currentTextField:UITextField?

    var dietArray = [String]()

    var selectedSpecilaity:FFPlaceObject?
    var dietString:String?

    
    @IBOutlet weak var checkBtn:UIButton!

    var isChecked:Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
        restDescTextField.layer.borderWidth = 0.5
        restDescTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        restDescTextField.layer.cornerRadius = 4

        imageCollectionview.dataSource = self
        imageCollectionview.delegate = self
        dietCollectionView.dataSource  = self
        dietCollectionView.delegate = self

        specialityTextField.delegate = self
        priceRangeTextField.delegate = self

        getSpecialities()
        getAllInterests()
        // Do any additional setup after loading the view.
    }

    
    func getSpecialities(){ // speciality list webservice
        
        FFManagerClass.getFunctionList(type: "special", success: { (response) in
            self.specilaityList = response
            
            self.customiseDropDown()
            
        }) { (error) in
            
        }
    }
    
    func getAllInterests(){ // interest list webservice
          
          FFManagerClass.getAllInterestList(success: { (response) in
              self.allInterestList = response
              
            self.dietCollectionView.reloadData()
            self.dietCollectionView.layoutIfNeeded()
            self.dietCollectionViewHeightConstraint.constant = self.dietCollectionView.contentSize.height

          }) { (error) in
              
          }
      }

    
    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
        currentTextField = textField
        self.dropDown.hide()
        
        self.dropDown.anchorView = currentTextField
        if textField == specialityTextField {
            self.dropDown.dataSource = self.specilaityList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }else if textField == priceRangeTextField {
            self.dropDown.dataSource = ["Not \(StringConstants.restaurantstore.expensive) (€)","\(StringConstants.restaurantstore.expensive) (€€)","\(StringConstants.restaurantstore.Affordable) (€€€)"]
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
        }
    }
    
    func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
           
           if currentTextField == specialityTextField {
               dropDown.anchorView = specialityTextField
               dropDown.dataSource = self.specilaityList.map { $0.name! }
           }else if currentTextField == priceRangeTextField {
               dropDown.anchorView = priceRangeTextField
            self.dropDown.dataSource = ["Not \(StringConstants.restaurantstore.expensive) (€)","\(StringConstants.restaurantstore.expensive) (€€)","\(StringConstants.restaurantstore.Affordable) (€€€)"]
           }
           
           dropDown.direction = .any
        
        dropDown.selectionAction = { (index: Int, item: String) in
            self.currentTextField?.text = item
            self.dropDown.hide()
            
            if self.currentTextField == self.specialityTextField {
                self.selectedSpecilaity = self.specilaityList[index]
                
            }else if self.currentTextField == self.priceRangeTextField {
                
            }
            self.specialityTextField.resignFirstResponder()
            self.priceRangeTextField.resignFirstResponder()
        }
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
         adjustImageAndTitleOffsetsForButton(button: addImageBtn)
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
     
    @IBAction func adBtnPresssed(_ sender :Any){ // slect image button action
           imagePicker.delegate = self
           
           if imagearray.count > 6 {
               FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.max6images)", view: self)
               return
           }
    
           let alert = UIAlertController(title: "\(StringConstants.addStore.ChooseanImage)", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.Takeanimage)", style: .default, handler: { _ in
               self.openCamera()
           }))
           
           alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.Searchinthegallery)", style: .default, handler: { _ in
               self.openGallary()
           }))
           
           alert.addAction(UIAlertAction.init(title: "\(StringConstants.addStore.Cancel)", style: .cancel, handler: nil))
           
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
               let alert  = UIAlertController(title: "\(StringConstants.addStore.Warning)", message: "\(StringConstants.addStore.Youdonthavecamera)", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.OK)", style: .default, handler: nil))
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

        let image             = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
            
            var imageName: String = "IMG_\(Date().timeIntervalSinceReferenceDate)"
            imageName = imageName.replacingOccurrences(of: ".", with: "")
            imageName.append(".png")
            
            let localPath         = photoURL.appendingPathComponent(imageName)
            
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
            
    //        let imgData = image.UIImageJPEGRepresentation(compressionQuality: 0.2)

            
            let imageData = image.jpeg(.low) ?? Data()
            
            FFLoaderView.showInView(view: self.view)
        FFManagerClass.uploadRestImageData(imageName: imageName, imageData: imageData, success: { (resp) in
                print(resp)
                FFLoaderView.hideInView(view: self.view)
                self.imagearray.append((resp.files?.first)!)
    //            self.uploadedImageArray.append((resp.files?.first)!)
                self.imageCollectionview.reloadData()
                self.imageCollectionview.layoutIfNeeded()
                self.collectionviewHeightConstraint.constant = self.imageCollectionview.contentSize.height
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                print(error)
            }
            
            
           
            picker.dismiss(animated: true, completion: nil)
        }
        
        

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == imageCollectionview{
            return imagearray.count
            }else{
                return allInterestList.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var collectCell: UICollectionViewCell = UICollectionViewCell()
          if collectionView == imageCollectionview{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeImageCell", for: indexPath)
            
            let imageView = cell.viewWithTag(100) as! UIImageView
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            let imageUrl:URL?
            
            let item = imagearray[indexPath.row]
            if item is FFImageObject {
                imageUrl  = URL(string: (item as! FFImageObject).url!)!
            }else {
                imageUrl = URL(string: (imagearray[indexPath.row] as! FFRecipeTypeObject).name as! String)!
            }
            
            
            imageView.kf.setImage(with: imageUrl)
            let closeBtn = cell.viewWithTag(200) as! UIButton
            closeBtn.titleLabel?.tag = indexPath.row
            closeBtn.addTarget(self, action: #selector(closeImageBtnPressed(_:)), for: .touchUpInside)
            collectCell = cell
          }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.allInterestList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
            if self.allInterestList[indexPath.row].isChecked == 1 {
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
            }else {
                tickImgView.image = #imageLiteral(resourceName: "tickgrey")
            }
            collectCell = cell

            }
            return collectCell
        }
        
        @objc func closeImageBtnPressed(_ sender: UIButton){ // delete image button action
            
            let item = imagearray[(sender.titleLabel?.tag)!]
           
            if item is FFImageObject {
                
            }else {
                let itemObj:FFRecipeTypeObject = item as! FFRecipeTypeObject
                if let id = itemObj.id {
                 deleteArray.append("\(id)")
                }
            }
            imagearray.remove(at: (sender.titleLabel?.tag)! )
            
            imageCollectionview.reloadData()
            imageCollectionview.layoutIfNeeded()
           self.collectionviewHeightConstraint.constant = self.imageCollectionview.contentSize.height
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == imageCollectionview{

            let cellWidth = collectionView.bounds.width
            return CGSize(width: cellWidth, height: cellWidth)
            }else{
                let cellSize = collectionView.bounds.size.width / 3
                return CGSize(width: cellSize, height: 100)

            }
        }
        
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        selectedTheme = self.interestList[indexPath.row].stringId!
                if collectionView == dietCollectionView{
                    if self.allInterestList[indexPath.row].isChecked == 1 {
                        self.allInterestList[indexPath.row].isChecked = 0
                    }else{
                        self.allInterestList[indexPath.row].isChecked = 1
                    }
                collectionView.reloadData()
                }
            }
    
    
    func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
        
        
        self.dietArray.removeAll()
        for i in 0...self.allInterestList.count - 1{
            if self.allInterestList[i].isChecked == 1{
                
                self.dietArray.append("\(self.allInterestList[i].id ?? 0)")
                
            }
        }
        
        if self.dietArray.count > 0{
            dietString = dietArray.joined(separator: ", ")
            restaurantRequest?.interests = dietString
        }else{
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Selectatleastoneinterest)", view: self)
            return false

        }
        
        if let speciality = specialityTextField.text, !speciality.isEmpty {
            restaurantRequest?.specialities = "\(self.selectedSpecilaity?.idInt ?? 0)"
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.EnterCulinarySpecialties)", view: self)
            return false
        }

        
        if let priceRange = priceRangeTextField.text, !priceRange.isEmpty {
            
            restaurantRequest?.priceRange = "€"

        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.Enterpricerange)", view: self)
            return false
        }
//
//        if let ctime = cookingTimeTextField.text, !ctime.isEmpty {
//
//        }else {
//            FFBaseClass.sharedInstance.showAlert(mesage: "Enter cooking time", view: self)
//            return false
//        }
//
//
//        if "" == selectedTheme {
//            FFBaseClass.sharedInstance.showAlert(mesage: "Select theme", view: self)
//            return false
//        }
//
//        if selectedcategory == nil {
//            FFBaseClass.sharedInstance.showAlert(mesage: "Select category", view: self)
//            return false
//        }
        
        if isChecked == true{
            restaurantRequest?.accept2 = "1"
        }else{
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.restaurantstore.acceptterms)", view: self)
            return false

        }
        
        return true
    }
    
    
    @IBAction func nextBtnTapped(_ sender : Any){
        if validateStepOneFields(){
            if imagearray.count > 0 && imagearray[0] is FFImageObject {
                       restaurantRequest?.image = (imagearray[0] as! FFImageObject).name
                   }
            
            
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.postRestaurant(restaurantRequest: self.restaurantRequest, success: { (response) in
                print(response)
                 self.navigationController?.popToRootViewController(animated: true)
                FFLoaderView.hideInView(view: self.view)
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }

        }
    }
    
    @IBAction func checkBtnTapped(_ sender : Any){
        
        if isChecked == false{
            checkBtn.setBackgroundImage(#imageLiteral(resourceName: "checkfill"), for: .normal)
            checkBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
            isChecked = true
        }else{
            checkBtn.setBackgroundImage(#imageLiteral(resourceName: "checkempty"), for: .normal)
            checkBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
            isChecked = false

        }
        
    }
    

}
