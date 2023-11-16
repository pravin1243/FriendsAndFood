//
//  FFMyRecipesViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/22/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
import ObjectMapper

class FFMyRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , RecipeCellDelegate, findRecipeDelegate{
    func didFinishedRecipeFilter(isSearchResult: Bool, recipeList: [FFEntranceObject], selectedinterest: FFRecipeTypeObject?, selectedcategory: FFRecipeTypeObject?, selectedrecipeType: FFRecipeTypeObject?, searchText: String) {
        self.isSearchResult = isSearchResult
        self.recipeList = recipeList
        self.selectedinterest = selectedinterest
        self.selectedcategory = selectedcategory
        self.selectedrecipeType = selectedrecipeType
        self.searchText = searchText

    }
    

    

    @IBOutlet weak var recipeListTableView:UITableView!
    @IBOutlet weak var emptyRecipeView:UIView!
    @IBOutlet weak var notConnectedView:UIView!
    var selectedcategory:FFRecipeTypeObject?
    var selectedinterest:FFRecipeTypeObject?
    var selectedrecipeType:FFRecipeTypeObject?

    var searchText:String = ""

    var recipeList:[FFEntranceObject] = []
    var recipeDetail:FFEntranceObject?
    var isSearchResult:Bool?
    var filterBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeListTableView.dataSource = self
        recipeListTableView.delegate = self
        
       
        recipeListTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            if isSearchResult == true {
                
            
                var cnt = 0
                if  !searchText.isEmpty {
                    cnt = cnt + 1
                }
                if let _ = self.selectedcategory {
                    cnt = cnt + 1
                }
                if let _ = self.selectedinterest {
                    cnt = cnt + 1
                }
                if let _ = self.selectedrecipeType {
                                   cnt = cnt + 1
                            }
                
                self.filterBtn?.setTitle("(\(cnt))", for: UIControl.State.normal)
                self.recipeListTableView.reloadData()
            }else {
             callMyRecipesAPI(user: user)
            }
        }else {
            notConnectedView.isHidden = false
        }
    }
    
    func customiseNavigationBar(){ // add search , add and filter buton in navigation bar
        self.title = "\(StringConstants.nonProfessionalHome.Recipes)"

        
       // self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let addBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        addBtn.setImage(#imageLiteral(resourceName: "addicon"),for: .normal)
        addBtn.addTarget(self, action: #selector(addRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        addBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let addButton = UIBarButtonItem(customView: addBtn)
        
        filterBtn = UIButton(type: UIButton.ButtonType.custom)
        filterBtn?.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn?.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn!)
        if self.recipeList.count > 0{
            self.navigationItem.rightBarButtonItems = [filterButton, addButton]

        }else{
            self.navigationItem.rightBarButtonItems = [ addButton]

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRecipeCell") as! FFMyRecipeTableViewCell
        cell.recipeObj = self.recipeList[indexPath.row]
        cell.cellDelegate = self
        cell.refreshCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = recipeList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callMyRecipesAPI(user:FFUserObject){ // recipe list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyRecipesList(userID: user.id, success: { (response) in
            print(response)
            self.recipeList = response
            FFLoaderView.hideInView(view: self.view)
            if self.recipeList.count > 0 {
                self.recipeListTableView.isHidden = false
            }else {
                self.recipeListTableView.isHidden = true
            }
            self.recipeListTableView.reloadData()
            self.customiseNavigationBar()
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    @objc func addRecipeBtnTapped(){
    
        performSegue(withIdentifier: "AddRecipeSegue", sender: self)
    }
    
    @objc func searchRecipeBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFindRecipeVC") as! FFFindRecipeViewController
        vc.selectedinterest = self.selectedinterest
        vc.selectedcategory = self.selectedcategory
        vc.searchText = self.searchText
        vc.fromWhere = "search"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func filterRecipeBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFindRecipeVC") as! FFFindRecipeViewController
        vc.selectedinterest = self.selectedinterest
        vc.selectedcategory = self.selectedcategory
         vc.selectedrecipeType = self.selectedrecipeType
        vc.searchText = self.searchText
        vc.fromWhere = "filter"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }

    
    @IBAction func goToLogin(_ sender:Any){
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
        loginVC.isFirstLaunch = false
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func goToRegistration(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! FFRegistrationViewController
        registerVC.isFirstLaunch = false
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func goToAddRecipe(_ sender: Any){ // add recipe webservice
        performSegue(withIdentifier: "AddRecipeSegue", sender: self)
    }
    
    func editRecipeTapped(obj: FFEntranceObject?) { // edit recipe button action
        
        self.loadRecipeDetail(recipeId: "\(obj?.id ?? 0)")
    }
    
    func deleteRecipeTapped(obj: FFEntranceObject?) { // delete recipe button action
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.deleteRecipe(recipeID: obj?.id, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            
            if let userr = FFBaseClass.sharedInstance.getUser() {
                  self.callMyRecipesAPI(user: userr)
            }
        
        }) { (erroe) in
            print(erroe)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    
    
    
    func convertRecipeObj(obj: FFEntranceObject?) -> FFAddRecipeRequestModel{ // create recipe request model from recipe object
        let addRecipeRequest = FFAddRecipeRequestModel()
        if let id = obj?.id {
            addRecipeRequest.id = "\(id)"
        }
        
        addRecipeRequest.name = obj?.name
        addRecipeRequest.description = obj?.recipeDescription
        if let id = obj?.types?.first?.id {
            addRecipeRequest.typeId = "\(id)"
        }
        if let toughness  = obj?.toughness?.id {
            addRecipeRequest.toughnessID = "\(toughness)"
        }
        if let ptime  = obj?.preparationTime {
            addRecipeRequest.prepTime = "\(ptime)"
        }

        if let ctime  = obj?.bakingTime {
            addRecipeRequest.bakingTime = "\(ctime)"
        }
        
        if let interest = obj?.interests?.first?.id {
            addRecipeRequest.interest = "\(interest)"
        }else {
            addRecipeRequest.interest = "0" //other theme
        }
        
        if let nbperson = obj?.noOfPersons {
            addRecipeRequest.personCnt = "\(nbperson)"
        }
        
        if let catId = obj?.categories?.first?.id {
            addRecipeRequest.categoryId = "\(catId)"
        }
        
        var ingArray = [FFIngredientUploadObject]()
        for item in (obj?.ingredients)! {
            ingArray.append(getIngredientRequest(ingredient: item))
        }
        addRecipeRequest.ingredients = ingArray
        
        var stepArray = [FFStepObject]()
        
        for item in (obj?.steps)! {
            stepArray.append(getStepRequest(step: item))
        }
        
        addRecipeRequest.steps = stepArray
        
//        var imgArray = [String]()
//        for img in (obj?.imageArray)!{
//            imgArray.append(img.name!)
//        }
//        addRecipeRequest.images = imgArray

        addRecipeRequest.images = obj?.imageArray
        return addRecipeRequest
    }
    
    func getStepRequest(step:FFStepObject) -> FFStepObject { //convert stepobject to step request
        let stepObj = FFStepObject(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["":""]))
        stepObj?.name = step.name
        if let pos = step.positionInt {
          stepObj?.position = "\(pos)"
        }
        if let isDefault = step.isdefaultInt {
            stepObj?.isdefault = "\(isDefault)"
        }
        stepObj?.image = ""
        return stepObj!
    }
    
    func getIngredientRequest(ingredient: FFRecipeTypeObject) -> FFIngredientUploadObject{ // convert recipe object to ingredient request object
        
        let ingredientObj = FFIngredientUploadObject(map: Map.init(mappingType: MappingType.fromJSON, JSON: ["" : ""]))
        ingredientObj?.name = ingredient.name_normalized
        ingredientObj?.id = ingredient.id
        if let qty = ingredient.quantityInt {
//            ingredientObj?.quantity = "\(qty)"
            ingredientObj?.quantity = Float(qty)

        }
        if let id = ingredient.measure?.idInt{
            ingredientObj?.measureId = "\(id)"
        }
        
        ingredientObj?.image = ingredient.familyImageObject?.name
        
        return ingredientObj!
        
    }
    func recipeLikePressed(id: Int?) {
        
    }
    
    func recipeDisLikePressed(id: Int?) {
        
    }
    
    func loadRecipeDetail(recipeId: String){ // recipe detail webservice
      FFLoaderView.showInView(view: self.view)
          FFLoaderView.showInView(view: self.view)
          FFManagerClass.getRecipeDetail(recipeId: recipeId, success: { (response) in
              print(response)
              FFLoaderView.hideInView(view: self.view)
              self.recipeDetail = response
//              self.populateData()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeVC")
            as! FFAddRecipeViewController
                
            vc.recipeRequest  = self.convertRecipeObj(obj: self.recipeDetail)
                   self.navigationController?.pushViewController(vc, animated: true)

          }) { (error) in
              print(error)
              FFLoaderView.hideInView(view: self.view)
              FFBaseClass.sharedInstance.showError(error: error, view: self)
          }
  }

}
