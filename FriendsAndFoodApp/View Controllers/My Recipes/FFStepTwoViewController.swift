//
//  FFStepTwoViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 07/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import DropDown
import ObjectMapper

class FFStepTwoViewController: FFAddRecipeBaseController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, PopUpDelegate {
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var personsTextField:UITextField!
    @IBOutlet weak var ingredientTableView:UITableView!
    @IBOutlet weak var preparationTableview:UITableView!
    @IBOutlet weak var ingredientTextField:UITextField!
    @IBOutlet weak var preparationTextField:UITextField!
    
    var searchResultIngredietsArray : [FFRecipeTypeObject] = []
    var selectedIngredietsArray:[FFIngredientUploadObject] = []
    var selectedIngredient:FFIngredientUploadObject?
    
    var preparationstepsArray:[FFStepObject] = []
    var recipeTitle:String?
    let dropDown = DropDown()
    
//    var recipeRequest:FFAddRecipeRequestModel?
    
    var deletedStepArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipeName = recipeTitle {
            self.title = recipeName
        }
        
        ingredientTextField.delegate = self
        preparationTextField.delegate = self
        
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        ingredientTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: true)
        customiseDropDown()
        ingredientTableView.tableFooterView = UIView()
        
        preparationTableview.dataSource = self
        preparationTableview.delegate = self
        preparationTableview.tableFooterView = UIView()
        
        
      
        
    }
    
    func populateData() { // data population for edit recipe
        personsTextField.text = recipeRequest?.personCnt
        selectedIngredietsArray = recipeRequest?.ingredients ?? [FFIngredientUploadObject]()
        preparationstepsArray = recipeRequest?.steps ?? [FFStepObject]()
        preparationTableview.reloadData()
        ingredientTableView.reloadData()
        //selectedIngredietsArray = recipeRequest?.ingredients
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if recipeRequest?.isEdit == true {
            
            populateData()
        //}
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func customiseDropDown(){ // ingredient pop up customisation
        dropDown.anchorView = ingredientTextField
        dropDown.arrowIndicationX = 0
        dropDown.dataSource = searchResultIngredietsArray.map { $0.name! }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.selectedIngredient = self.getIngredientRequest(ingredient: self.searchResultIngredietsArray[index])
            self.ingredientTextField.text = item
            self.dropDown.hide()
            self.showIngredientPopUp()
        }
    }
    
    
    func showIngredientPopUp(){ // show measure and quantity popu p
        self.view.endEditing(true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpVC") as! FFSelectPopUpViewController
        vc.popDelegate = self
        if let id = selectedIngredient?.id {
          vc.selectedIngredientId  =  "\(id)"
        }
        vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        recipeRequest?.personCnt = personsTextField.text
        recipeRequest?.ingredients = selectedIngredietsArray
        recipeRequest?.steps = preparationstepsArray
        recipeRequest?.deletedsteps = deletedStepArray

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.ingredientTableView {
          return selectedIngredietsArray.count
        }else {
            return preparationstepsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! UITableViewCell
        let countLabel = cell.viewWithTag(100) as! UILabel
        let nameLabel = cell.viewWithTag(300) as! UILabel
        let imageView = cell.viewWithTag(200) as! UIImageView
        let closeBtn = cell.viewWithTag(400) as! UIButton
        
        countLabel.text = "\(indexPath.row + 1)"
        
        if tableView == self.ingredientTableView {
            
            nameLabel.text = selectedIngredietsArray[indexPath.row].name
            if let familyImg = selectedIngredietsArray[indexPath.row].image {
                imageView.contentMode = .scaleAspectFill
                let imageUrl:URL = URL(string: familyImg)!
                imageView.kf.setImage(with:imageUrl )
            }else {
                imageView.image = #imageLiteral(resourceName: "steps")
                imageView.contentMode = .center
            }
            
            closeBtn.titleLabel?.tag = indexPath.row
            closeBtn.addTarget(self, action: #selector(removeIngredient(_:)), for: UIControl.Event.touchUpInside)
            
        }else {
            
            nameLabel.text = preparationstepsArray[indexPath.row].name
            closeBtn.titleLabel?.tag = indexPath.row
            closeBtn.addTarget(self, action: #selector(removePrepStep(_:)), for: UIControl.Event.touchUpInside)
            
        }
        return cell
    }
    
    @objc func removeIngredient(_ sender : UIButton){
        selectedIngredietsArray.remove(at: (sender.titleLabel?.tag)!)
        ingredientTableView.reloadData()
    }
    
    @objc func removePrepStep(_ sender : UIButton){
        deletedStepArray.append("\(preparationstepsArray[sender.titleLabel?.tag ?? 0].id ?? 0)")
        let a = preparationstepsArray[sender.titleLabel?.tag ?? 0].id
        preparationstepsArray.remove(at: (sender.titleLabel?.tag)!)
        preparationTableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func confirmBtnTapped(quantity: String, measure: FFMeasureObject) { // confirm measure and quantity and add to ingredient list
        if selectedIngredietsArray.count > 12 {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.maximumof12ingredients)", view: self)
            return
        }
        selectedIngredient?.quantity = Float(quantity)
        selectedIngredient?.measureId = "\(measure.idInt ?? 0)"
        selectedIngredietsArray.append(selectedIngredient!)
        ingredientTableView.reloadData()
        ingredientTextField.text = ""
    }
    
    @IBAction func didChangeTextField(_ sender: UITextField){ // call ingredient auto suggetsion webservice afer 3 characters
        dropDown.hide()
        if (sender.text?.count)! >= 3 {
            callSearchIngredientAPI(searchText: sender.text!)
        }
        
    }
    
    func callSearchIngredientAPI(searchText:String){ // search ingredient webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.searchIngredientList(searchText: searchText, success: { (response) in
            print(response)
            self.dropDown.hide()
            self.searchResultIngredietsArray = response
            self.dropDown.dataSource = self.searchResultIngredietsArray.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == preparationTextField {
            addToStepArray(step: textField.text!)
        }
        self.view.endEditing(true)
        return true
    }
    
    func addToStepArray(step:String){ // adding each step to step request array
        
        if preparationstepsArray.count > 12 {
          FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.maximumof12steps)", view: self)
            return
        }
        
        let stepObj = FFStepObject()
        stepObj.name = step
        stepObj.position = "\(preparationstepsArray.count  + 1)"
        stepObj.isdefault = "1"
        preparationstepsArray.append(stepObj)
        preparationTableview.reloadData()
        preparationTextField.text = ""
        
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
    
    @IBAction func addExtraIngredient(_ sender : Any){
//        if  dropDown.isHidden == true {
//
//            let dict = ["name":ingredientTextField.text]
//            let ingredient  = FFRecipeTypeObject(map: Map.init(mappingType: MappingType.fromJSON, JSON: dict))
//            ingredient?.name = ingredientTextField.text
//          //  selectedIngredietsArray.append(ingredient!)
//            ingredientTableView.reloadData()
//            ingredientTextField.text = ""
//
//        }
    }
    
    func validateStepTwo() -> Bool{ // validate fields in step two of ad recipe
        if let ppl = personsTextField.text, !ppl.isEmpty {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enternumberofpersons)", view: self)
            return false
        }
        
        if selectedIngredietsArray.count < 1 {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enteratleastoneingredient)", view: self)
            return false
        }
        
        if preparationstepsArray.count < 1 {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Enteratleastonestep)", view: self)
            return false
        }
        
        return true
    }
    
    @IBAction func goToStepThree(_ sender : Any){ // go to step three of add recipe
        
        if validateStepTwo() {
            
            recipeRequest?.personCnt = personsTextField.text
            recipeRequest?.ingredients = selectedIngredietsArray
            recipeRequest?.steps = preparationstepsArray
            recipeRequest?.deletedsteps = deletedStepArray

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StepThreeVC") as! FFStepThreeViewController
            vc.recipeRequest = self.recipeRequest
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getIngredientRequest(ingredient: FFRecipeTypeObject) -> FFIngredientUploadObject{ // convert ingrediet object to ingredient request model
        
            let ingredientObj = FFIngredientUploadObject(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["" : ""]))
            ingredientObj?.name = ingredient.name
            ingredientObj?.id = ingredient.id
//            if let qty = ingredient.quantity {
//             ingredientObj?.quantity = "\(qty)"
//            }
//            ingredientObj?.measureId = ingredient.measure?.id
        
        ingredientObj?.image = ingredient.familyImage?.first?.name
        
        return ingredientObj!
        
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
