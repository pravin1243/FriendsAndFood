//
//  FFCategoryDetailViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/15/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFCategoryDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var recipeTableView:UITableView!
//    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
//    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var categoryLabel:UILabel!

    var categoryId:String?
    var isFromIngredient:Bool = false
    var responseObject:FFRecipeTypeObject?
    var recipeList:[FFEntranceObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        recipeTableView.delegate  = self

        if isFromIngredient == true {
            categoryLabel.text = "INGREDIENT"
            getIngredientDetail()
        }else {
            categoryLabel.text = "CATEGORY"
            getCategoryDetail()
        }

        recipeTableView.tableFooterView = UIView()
        loadRecipeList()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCategoryDetail(){ // category detail webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getDisheDetail(id: self.categoryId, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.responseObject = response
            self.populateData()
            let imageUrl:URL = URL(string: (self.responseObject?.imageLarge)!)!
            self.headerImageView.kf.setImage(with:imageUrl)
            if let isFav = self.responseObject?.checked, isFav == 0{
                self.favBtn.isSelected = false
            }else {
                self.favBtn.isSelected = true
            }
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func populateData(){
        self.topLabel.text = responseObject?.name
        self.nameLabel.text = responseObject?.name
               
    }
    
    func getIngredientDetail(){ // ingredient detail webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getIngredientDetail(id: self.categoryId, success: { (repsonse) in
            print(repsonse)
            self.responseObject = repsonse
            self.populateData()
            let imageUrl:URL = URL(string: (self.responseObject!.familyImage?.first?.name!)!)!
            self.headerImageView.kf.setImage(with:imageUrl )
            if let isFav = self.responseObject?.isLiked , isFav == "0" {
                self.favBtn.isSelected = false
            }else {
                self.favBtn.isSelected = true
            }
            FFLoaderView.hideInView(view: self.view)
        }) { (erroe) in
            FFLoaderView.hideInView(view: self.view)
            print(erroe)
        }
    }    
    
    func loadRecipeList(){ // recipe list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getRecipeList(isFromIngredient:self.isFromIngredient, categoryId: self.categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.recipeList  =  response
            self.recipeTableView.reloadData()
           
        
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    //MARK:- TableView functions

    func numberOfSections(in tableView: UITableView) -> Int {
        if recipeList.count > 0 {
            self.recipeTableView.backgroundView = nil
            return 1
        }else {
            let emptyView = UIView()
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0.75 * recipeTableView.bounds.size.height, width: self.recipeTableView.bounds.size.width, height: 30))
            emptyLabel.text = "\(StringConstants.Labels.Norecipesfound)"
            emptyLabel.font = UIFont.systemFont(ofSize: 15)
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = UIColor.lightGray
            emptyView.addSubview(emptyLabel)
            let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imagView.image = #imageLiteral(resourceName: "emptyRecipe")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
            imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 40)
            emptyView.addSubview(imagView)
            
            self.recipeTableView.backgroundView = emptyView
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
        cell.responseObject = recipeList[indexPath.row]
        cell.refreshCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // hide/show top bar when scrollview is scriolled up
        
        if scrollView.contentOffset.y >= (self.recipeTableView.tableHeaderView?.frame.size.height)!{
            topView.backgroundColor = FFBaseClass.primaryColor
            topLabel.textColor = UIColor.white
           // favBtn.tintColor = UIColor.white
            shareBtn.tintColor = UIColor.white
            backBtn.tintColor = UIColor.white
        }else{
            topView.backgroundColor = UIColor.clear
            topLabel.textColor = UIColor.black
            //favBtn.tintColor = UIColor.black
            shareBtn.tintColor = UIColor.black
            backBtn.tintColor = UIColor.black
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(recipeList.count) Recipes"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
  
    @IBAction func favBtnTapped(_ sender: Any){ // favorite button action
        if let _ = FFBaseClass.sharedInstance.getUser() {
            if isFromIngredient == false {
                
                if favBtn.isSelected  {
                    callDislikeCategoryAPI()
                }else {
                    callLikeCategoryAPI()
                }
            }else {
                if favBtn.isSelected  {
                    callDisLikeIngredientAPI()
                }else {
                    callLikeIngredientAPI()
                }
            }
        }else {
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
            loginVC.isFirstLaunch = false
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        }
    }
    
    func callLikeCategoryAPI(){ // like category webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeCategory(isMultiple: false, categoryIDs: [],recipeID: categoryId, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.favBtn.isSelected = true
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    
    func callLikeIngredientAPI(){ // like ingredient webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeIngredient(isMultiple: false, ingredientIDs: [],recipeID: categoryId, success: { (response) in
            self.favBtn.isSelected = true
            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func callDislikeCategoryAPI(){ // disike category webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeCategory(recipeID: categoryId, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.favBtn.isSelected = false
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    
    func callDisLikeIngredientAPI(){ // dislike ingredient webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeIngredient(recipeID: categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.favBtn.isSelected = false
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    @IBAction func shareBtnTapped(_ sender: Any){
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = recipeList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
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
