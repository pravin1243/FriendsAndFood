 //
//  FFIngredientDetailController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 21/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFIngredientDetailController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

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
        var recipeDetail:FFEntranceObject?
        var seasonDetail:[FFSeasonObject] = []
        var faqList:[FFFaqObject] = []
        var varietiesList:[FFIngrVarietyObject] = []

    var prefaqList:[FFFaqObject] = []

    var nutritionList:[FFNutritionObject] = []

    var showHide:[Int] = []
    var oldTag: Int?

    var whichSection: Int? = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        recipeTableView.delegate  = self

            categoryLabel.text = "\(StringConstants.Labels.Ingredientdetails)"
            getIngredientDetail()
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
    
     func populateData(){
        self.topLabel.text = responseObject?.name?.capitalizingFirstLetter()
        self.nameLabel.text = responseObject?.name?.capitalizingFirstLetter()
                   
        }
        
        func getIngredientDetail(){ // ingredient detail webservice
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getIngredientDetail(id: self.categoryId, success: { (repsonse) in
                print(repsonse)
                self.responseObject = repsonse
                self.populateData()
                let imageUrl:URL = URL(string: (self.responseObject!.familyImage?.first?.large!)!)!
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
                self.loadSeasonalData()
            
                
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)


            }
            
        }
    
    func loadSeasonalData(){ // Seasonal Data webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getSeasonalData(isFromIngredient:self.isFromIngredient, categoryId: self.categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.seasonDetail  =  response
            self.loadFAQData()
        
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    
    func loadFAQData(){ // FAQ Data webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getFAQData(isFromIngredient:self.isFromIngredient, categoryId: self.categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.prefaqList  =  response
            if self.prefaqList.count > 0{
            for i in 0...self.prefaqList.count - 1{
                if self.prefaqList[i].answer == ""{
                }else{
                    self.faqList.append(self.prefaqList[i])
                    self.showHide.append(0)
                }
            }
            }
          //  self.recipeTableView.reloadData()
            self.loadIngVarietyData()

        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    
    func loadIngVarietyData(){ // Seasonal Data webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getIngVarietyData(isFromIngredient:self.isFromIngredient, categoryId: self.categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.varietiesList  =  response
        self.loadNutritionData()

            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    
    func loadNutritionData(){ // Nutrition Data webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getNutritionData(isFromIngredient:self.isFromIngredient, categoryId: self.categoryId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.nutritionList  =  response
            self.recipeTableView.reloadData()

        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    
        //MARK:- TableView functions

        func numberOfSections(in tableView: UITableView) -> Int {
            6
            
//            if recipeList.count > 0 {
//                self.recipeTableView.backgroundView = nil
//                return 1
//            }else {
//                let emptyView = UIView()
//                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0.75 * recipeTableView.bounds.size.height, width: self.recipeTableView.bounds.size.width, height: 30))
//                emptyLabel.text = "No recipes found"
//                emptyLabel.font = UIFont.systemFont(ofSize: 15)
//                emptyLabel.textAlignment = .center
//                emptyLabel.textColor = UIColor.lightGray
//                emptyView.addSubview(emptyLabel)
//                let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                imagView.image = #imageLiteral(resourceName: "emptyRecipe")
//                imagView.contentMode = UIViewContentMode.scaleAspectFit
//                imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 40)
//                emptyView.addSubview(imagView)
//
//                self.recipeTableView.backgroundView = emptyView
//                return 1
//            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0{
                return 1
            }else if section == 1{
                if whichSection == 1{
                    return self.seasonDetail.count
                }else{
                    return 0
                }
            }else if section == 2{
                if whichSection == 1{
                    return faqList.count
                }else{
                    return 0
                }
            }else if section == 3{
                if whichSection == 1{
                return varietiesList.count
                }else{
                    return 0
                }
            }
            else if section == 4{
                if whichSection == 2{
                return nutritionList.count
                }else{
                    return 0
                }
            }else if section == 5{
                if whichSection == 3{
                return recipeList.count
                }else{
                    return 0
                }
            }
            
            else{
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var returnCell: UITableViewCell = UITableViewCell()
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell") as! FFIngredientDetailTableViewCell
                if whichSection == 1{
                    cell.infoSelectedView.isHidden = false
                    cell.recpSelectedView.isHidden = true
                    cell.nutritionSelectedView.isHidden = true
                }
                if whichSection == 2{
                    cell.infoSelectedView.isHidden = true
                    cell.recpSelectedView.isHidden = true
                    cell.nutritionSelectedView.isHidden = false
                }
                if whichSection == 3{
                    cell.infoSelectedView.isHidden = true
                    cell.recpSelectedView.isHidden = false
                    cell.nutritionSelectedView.isHidden = true
                }
                returnCell = cell
            }
            if indexPath.section == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonalCell") as! FFIngredientDetailTableViewCell
                if self.seasonDetail.count > 0{
                    if self.seasonDetail[0].isjanuary == 1{
                        cell.janView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.janView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isfebruary == 1{
                        cell.febView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.febView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].ismarch == 1{
                        cell.marchView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.marchView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isapril == 1{
                        cell.aprilView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.aprilView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].ismay == 1{
                        cell.mayView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.mayView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isjune == 1{
                        cell.junView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.junView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isjuly == 1{
                        cell.julyView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.julyView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isaugust == 1{
                        cell.augustView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.augustView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isseptember == 1{
                        cell.sepView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.sepView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isoctober == 1{
                        cell.octView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.octView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isnovember == 1{
                        cell.novView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.novView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                    if self.seasonDetail[0].isdecember == 1{
                        cell.decView.backgroundColor = #colorLiteral(red: 0.6031433344, green: 0.7597135901, blue: 0.009560740553, alpha: 1)
                    }else{
                        cell.decView.backgroundColor = #colorLiteral(red: 0.9375525117, green: 0.2276367545, blue: 0.1098066792, alpha: 1)
                    }
                }
                returnCell = cell
            }
            if indexPath.section == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FFIngredientDetailTableViewCell
                
                let question = "\(self.faqList[indexPath.row].question?.capitalizingFirstLetter() ?? "")?"
                cell.faqQuestionLbl.text = self.toHtmlEncodedString(encodedString: question)
                if self.showHide[indexPath.row] == 1{
                    let answer = "\(self.faqList[indexPath.row].answer ?? "")"
                    cell.faqAnswerLbl.text = self.toHtmlEncodedString(encodedString:  answer)
                }else{
                    cell.faqAnswerLbl.text = ""
                }
                cell.showHideFaqBtn.tag = indexPath.row
                cell.showHideFaqBtn.addTarget(self, action: #selector(showHideFaqBtn), for: .touchUpInside)
                returnCell = cell
            }
            if indexPath.section == 3{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell")
                        let imageView = cell?.viewWithTag(100) as! UIImageView
                        let namelabel = cell?.viewWithTag(200) as! UILabel

                        let variety = self.varietiesList[indexPath.row]
                        //        cell.interest = interest
                //                cell.refreshCell()
                        namelabel.text = variety.name?.capitalizingFirstLetter()
                        let imageUrl:URL = URL(string: (variety.imageName ?? ""))!
                        imageView.kf.setImage(with:imageUrl )
                      
                        returnCell = cell!

            }
            if indexPath.section == 4{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionCell") as! FFIngredientDetailTableViewCell

//                        let titleLabel = cell?.viewWithTag(100) as! UILabel
//                        let valueLabel = cell?.viewWithTag(200) as! UILabel
                        
                            let nutriObj = nutritionList[indexPath.row]
                cell.nutritionNameLbl.text = self.toHtmlEncodedString(encodedString:  nutriObj.name!)
                            if let qty = nutriObj.quantityFloat , let unit = nutriObj.code {
                                cell.nutritionUnitLbl.text = "\(qty) \(unit)"
                            }
                                
//                            valueLabel.text = self.toHtmlEncodedString(encodedString:  nutriObj.value!)

                            
                        
                returnCell = cell

            }
            if indexPath.section == 5{

            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
            cell.responseObject = recipeList[indexPath.row]
            cell.refreshCell()
                returnCell = cell

            }
            return returnCell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 1{
                return 320
            }else{
                return UITableView.automaticDimension
            }
        }
        
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
        
    @objc func showHideFaqBtn(_ sender: UIButton){
        showHide[oldTag ?? 0] = 0
            showHide[sender.tag] = 1
        if oldTag == sender.tag{
            showHide[sender.tag] = 0
        }
        self.recipeTableView.reloadData()
        oldTag = sender.tag
    }
    
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
            
            if whichSection == 3{

            if recipeList.count > 1{
                return "\(recipeList.count) Recipes"
            }else{
            return "\(recipeList.count) Recipe"
            }
            }
            else{
                if section == 2{
                    return "FAQ"
                   
                }else{
                    return "\(StringConstants.Labels.Variance)"
                }
            }
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if whichSection == 3{
        if section == 5{
            return 40
        }else{
            return 0
        }
    }
            else if whichSection == 1{
        if section == 2{
            if self.faqList.count > 0{
            return 30
            }else{
                return 0
            }
        }else if section == 3{
            if self.varietiesList.count > 0{
            return 30
            }else{
                return 0
            }
        }
        else{
            return 0
        }
    }
    else{
        return 0
        }
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
            FFManagerClass.likeCategory(isMultiple: false, categoryIDs: [], recipeID: categoryId, success: { (response) in
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
            if indexPath.section == 3{

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
            vc.recipeId = recipeList[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    
    
    @IBAction func infoBtnTapped(_ sender :Any ){ // info tab selection action
        whichSection = 1
        self.recipeTableView.reloadData()
    }
    
    @IBAction func recipeBtnTapped(_ sender :Any ){ // recipe tab selection action
        whichSection = 3
        self.recipeTableView.reloadData()

    }
    
    @IBAction func nutritionBtnTapped(_ sender :Any ){ // nutrition button sleection action
        whichSection = 2
        self.recipeTableView.reloadData()

    }
    
    func toHtmlEncodedString(encodedString:String) -> String { //decode html string
        guard let encodedData = encodedString.data(using: .utf8) else {
            return ""
        }
        
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return( attributedString.string)
        } catch {
            print("Error: \(error)")
            
        }
        return ""
    }

    
}

 extension String {
     func capitalizingFirstLetter() -> String {
       return prefix(1).uppercased() + self.lowercased().dropFirst()
     }

     mutating func capitalizeFirstLetter() {
       self = self.capitalizingFirstLetter()
     }
 }

