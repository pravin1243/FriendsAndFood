//
//  FFAddRecipeViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import DropDown

class FFAddRecipeViewController: FFAddRecipeBaseController , UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    @IBOutlet weak var entreeBtn:UIButton!
    @IBOutlet weak var platBtn:UIButton!
    @IBOutlet weak var dessertBtn:UIButton!
    var selectedDish:String?
    
    @IBOutlet weak var facileBtn:UIButton!
    @IBOutlet weak var moyenBtn:UIButton!
    @IBOutlet weak var dificileBtn:UIButton!
    var selectedDifficulty:String?
    
    @IBOutlet weak var themeCollectionView:UICollectionView!
    @IBOutlet weak var themeCollectionViewHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var deleteBtnHeightConstraint:NSLayoutConstraint!

    var interestList:[FFRecipeTypeObject] = []
//    @IBOutlet weak var vegetarianBtn:UIButton!
//    @IBOutlet weak var veganBtn:UIButton!
//    @IBOutlet weak var vegetalienBtn:UIButton!
//    @IBOutlet weak var balancedBtn:UIButton!
//    @IBOutlet weak var yummyBtn:UIButton!
//    @IBOutlet weak var autreBtn:UIButton!
//    var selectedtheme:String?
    
    @IBOutlet weak var titleTextField:UITextField!
    @IBOutlet weak var descriptionTextView:UITextView!
    @IBOutlet weak var preparationTimeTextField:UITextField!
    @IBOutlet weak var cookingTimeTextField:UITextField!
    @IBOutlet weak var categoryTextField:UITextField!
    
    @IBOutlet weak var scrollView:UIScrollView!
    var categoryList:[FFRecipeTypeObject] = []
    var selectedcategory:FFRecipeTypeObject?
    let dropDown = DropDown()
    
    var selectedTheme = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // addDummyData()
        
        self.adjustImageAndTitleOffsetsForButton(button: entreeBtn)
        self.adjustImageAndTitleOffsetsForButton(button: platBtn)
        self.adjustImageAndTitleOffsetsForButton(button: dessertBtn)
        
        customiseBtn(button: facileBtn)
        customiseBtn(button: moyenBtn)
        customiseBtn(button: dificileBtn)
        

        
        themeCollectionView.dataSource  = self
        themeCollectionView.delegate = self
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        descriptionTextView.layer.cornerRadius = 4

        categoryTextField.delegate = self
        getInterests()
        getCategories()
        customiseDropDown()
        
        if let recipeObject = self.recipeRequest {
            self.populateData()
            recipeRequest?.isEdit = true
        }else {
            recipeRequest = FFAddRecipeRequestModel(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["":""]))
            recipeRequest?.isEdit = false
            deleteBtnHeightConstraint.constant = 0
        }
        
        // Do any additional setup after loading the view.
    }
    
    func populateData(){ // populate data in fields from recipedetail for edit recipe
       
        
        print(recipeRequest?.toJSON())
       
        
      if let type = recipeRequest?.typeId {
            if type == "1" {
                entreeBtn.isSelected = true
                hideOrShowTick(btn: entreeBtn, shouldShow: true)
            }else if type  == "2"{
                platBtn.isSelected = true
                hideOrShowTick(btn: platBtn, shouldShow: true)
            }else{
                dessertBtn.isSelected = true
                hideOrShowTick(btn: dessertBtn, shouldShow: true)
            }
        }
        
        
        titleTextField.text = recipeRequest?.name
        descriptionTextView.text = recipeRequest?.description
        
        preparationTimeTextField.text = recipeRequest?.prepTime
        cookingTimeTextField.text = recipeRequest?.bakingTime
        

        
        if let toughness = recipeRequest?.toughnessID {
            if toughness == "1"{
                facileBtn.isSelected = true
                hideOrShowTick(btn: facileBtn, shouldShow: true)
            }else if toughness == "2"{
                moyenBtn.isSelected = true
                hideOrShowTick(btn: moyenBtn, shouldShow: true)

            }else{
                dificileBtn.isSelected = true
                hideOrShowTick(btn: dificileBtn, shouldShow: true)
            }
            
        }
        
        
        if let theme = recipeRequest?.interest {
            selectedTheme = theme
            themeCollectionView.reloadData()
        }
        
        for item in categoryList {
            if item.id! == Int((recipeRequest?.categoryId)!)! {
                selectedcategory = item
                categoryTextField.text = selectedcategory?.name_normalized

            }
        }
        
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

    
    @IBAction func difficultyBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        facileBtn.isSelected = false
        moyenBtn.isSelected = false
        dificileBtn.isSelected = false
        
        hideOrShowTick(btn: facileBtn, shouldShow: false)
        hideOrShowTick(btn: moyenBtn, shouldShow: false)
        hideOrShowTick(btn: dificileBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        selectedDifficulty = sender.titleLabel?.text
        
    }
    
 
    
//    @IBAction func themeBtnTapped(_ sender :UIButton){
//        vegetarianBtn.isSelected = false
//        veganBtn.isSelected = false
//        vegetalienBtn.isSelected = false
//        balancedBtn.isSelected = false
//        yummyBtn.isSelected = false
//        autreBtn.isSelected = false
//
//        sender.isSelected = true
//
//        hideOrShowTick(btn: vegetarianBtn, shouldShow: false)
//        hideOrShowTick(btn: veganBtn, shouldShow: false)
//        hideOrShowTick(btn: vegetalienBtn, shouldShow: false)
//        hideOrShowTick(btn: balancedBtn, shouldShow: false)
//        hideOrShowTick(btn: yummyBtn, shouldShow: false)
//        hideOrShowTick(btn: autreBtn, shouldShow: false)
//
//        hideOrShowTick(btn: sender, shouldShow: true)
//        selectedtheme = sender.titleLabel?.text
//    }
    
    //MARK:- Textfield delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        dropDown.show()
    }
    //MARK: - Collectionview methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCell", for: indexPath)
        let label = cell.viewWithTag(100) as! UILabel
        label.text = " \(self.interestList[indexPath.row].name!) "
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let tickImgView = cell.viewWithTag(200) as! UIImageView
        if selectedTheme == "\(self.interestList[indexPath.row].id ?? 0)" {
            tickImgView.image = #imageLiteral(resourceName: "tickgreen")
        }else {
            tickImgView.image = #imageLiteral(resourceName: "tickgrey")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedTheme = self.interestList[indexPath.row].stringId!
        selectedTheme = "\(self.interestList[indexPath.row].id ?? 0)"

        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.bounds.size.width / 3
        return CGSize(width: cellSize, height: 100)
    }
    
    //MARK: - Custom functions
    
    func getInterests(){ // interetst list webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getInterestList(success: { (response) in
            print(response)
            self.interestList = response
            let other = FFRecipeTypeObject(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["" : ""]))
            other?.name = "Other"
            other?.stringId = "0"
            self.interestList.append(other!)
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                self.themeCollectionView.reloadData()
                self.themeCollectionView.layoutIfNeeded()
                self.themeCollectionViewHeightConstraint.constant = self.themeCollectionView.contentSize.height
            }
            
            
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    func getCategories(){ // categories webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getDishesList(id: "", success: { (response) in
            print(response)
            self.categoryList = response
            FFLoaderView.hideInView(view: self.view)
            self.dropDown.dataSource = self.categoryList.map { $0.name! }
            self.dropDown.reloadAllComponents()
            if let request = self.recipeRequest {
                for item in self.categoryList {
                    if item.id == Int(request.categoryId ?? "") {
                        self.selectedcategory = item
                        self.categoryTextField.text = self.selectedcategory?.name_normalized
                        
                    }
                }
            }

        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func customiseDropDown(){ // catgeory pop up customisation
        dropDown.anchorView = categoryTextField
        dropDown.dataSource = categoryList.map { $0.name! }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.selectedcategory = self.categoryList[index]
            self.categoryTextField.text = item
            self.dropDown.hide()
        }
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

    @IBAction func goToStepTwoBtnTapped(_ sender : Any){ // next buttin action
        
        if validateStepOneFields() {
            
            recipeRequest?.name = titleTextField.text
            recipeRequest?.description = descriptionTextView.text
            recipeRequest?.prepTime = preparationTimeTextField.text
            recipeRequest?.bakingTime = cookingTimeTextField.text

            recipeRequest?.typeId = getTypeId()
            recipeRequest?.toughnessID = getToughnessId()
           // if let interestId = selectedTheme {
            recipeRequest?.interest = selectedTheme
          //  }

            recipeRequest?.categoryId = "\(selectedcategory?.id ?? 0)"

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepTwoVC") as! FFStepTwoViewController
            vc.recipeTitle = self.titleTextField.text ?? ""
            vc.recipeRequest = self.recipeRequest
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    func getInterestId() -> String {
//
//        if vegetarianBtn.isSelected {
//            return "1"
//        }else if veganBtn.isSelected {
//            return "2"
//        }else if vegetalienBtn.isSelected {
//            return "3"
//        }else if balancedBtn.isSelected{
//            return "4"
//        }else if yummyBtn.isSelected{
//            return "5"
//        }else {
//            return "0"
//        }
//    }
    
    func getToughnessId() -> String { // get toughness id value form UI
        if facileBtn.isSelected {
            return "1"
        }else if moyenBtn.isSelected {
            return "2"
        }else {
            return "3"
        }
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
    
    @IBAction func closeBtnTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func validateStepOneFields() -> Bool{ // validating fields in step 1 of add recipe
        
        if entreeBtn.isSelected || platBtn.isSelected || dessertBtn.isSelected {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enterdishtype)", view: self)
            return false
        }
        
        if let title = titleTextField.text, !title.isEmpty {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Entertitle)", view: self)
            return false
        }
        
     
        
        if facileBtn.isSelected || moyenBtn.isSelected || dificileBtn.isSelected {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enterdifficultylevel)", view: self)
            return false
        }
        
        if let ptime = preparationTimeTextField.text, !ptime.isEmpty {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enterpreparationtime)", view: self)
            return false
        }
        
        if let ctime = cookingTimeTextField.text, !ctime.isEmpty {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Entercookingtime)", view: self)
            return false
        }
        
        
        if "" == selectedTheme {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Selecttheme)", view: self)
            return false
        }
        
        if selectedcategory == nil {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Selectcategory)", view: self)
            return false
        }
        
        return true
    }
    

    
    
    @IBAction func deleteRecipeBtnTapped(_ sender : Any){ // delete buttin action
        presentAlertWithTitle(title: "Supprimer la recette", message: "Êtes-vous sûr de vouloir supprimer cette recette?", options: "Oui", "Non") { (option) in
            print("option: \(option)")
            switch(option) {
                case 0:
                    print("option one")
                    self.deleteRecipeAPI()
                    break
                case 1:
                    print("option two")
                default:
                    break
            }
        }

        
    }
    
    func deleteRecipeAPI() { // delete recipe button action
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.deleteRecipe(recipeID: Int(recipeRequest?.id ?? ""), success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            
            if let userr = FFBaseClass.sharedInstance.getUser() {
                self.navigationController?.popViewController(animated: true)

            }
        
        }) { (erroe) in
            print(erroe)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    
    
}
