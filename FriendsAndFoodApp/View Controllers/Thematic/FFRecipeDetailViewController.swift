//
//  FFRecipeDetailViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/15/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Cosmos

class FFRecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ingredientsTableView:UITableView!
    @IBOutlet weak var ingredientTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var prepTableView:UITableView!
    @IBOutlet weak var prepTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nutriTableView:UITableView!
    @IBOutlet weak var nutriTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ingredientBtn:UIButton!
    @IBOutlet weak var ingredientSelectedView:UIImageView!
    
    @IBOutlet weak var prepBtn:UIButton!
    @IBOutlet weak var prepSelectedView:UIImageView!
    
    @IBOutlet weak var nutritionBtn:UIButton!
    @IBOutlet weak var nutritionSelectedView:UIImageView!
    
    @IBOutlet weak var reviewTableView:UITableView!
    @IBOutlet weak var reviewTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emptyReviewView:UIView!
    
    @IBOutlet weak var topView:UIView!
    @IBOutlet weak var recipeImageView:UIImageView!
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var topLabel:UILabel!
    @IBOutlet weak var favBtn:UIButton!
    
    
    @IBOutlet weak var categoryLabel:UILabel!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var usernameLabel:UILabel!
    @IBOutlet weak var toughnessLabel:UILabel!
    @IBOutlet weak var preparationTimelabel:UILabel!
    @IBOutlet weak var cookingTimeLabel:UILabel!
    @IBOutlet weak var ratingLabel:UILabel!
    @IBOutlet weak var totalTimeLabel:UILabel!
    @IBOutlet weak var imgCountLabel:UILabel!
    @IBOutlet weak var reviewCountLabel:UILabel!
    
    
    @IBOutlet weak var loadMoreBtn:UIButton!
    
    
    @IBOutlet weak var reviewTextView:UITextView!
    @IBOutlet weak var reviewRatingView:CosmosView!
    @IBOutlet weak var reviewRatingLabel:UILabel!
    @IBOutlet weak var addReviewView:UIView!
    
    
    
    var recipeDetail:FFEntranceObject?
    var recipeId:Int?
    
    var maxResults:String = "2"
    var reviewList:[FFReviewObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        
        ingredientsTableView.reloadData()
        ingredientTableHeightConstraint.constant = ingredientsTableView.contentSize.height
        
        prepTableView.dataSource = self
        prepTableView.delegate = self
        
        prepTableView.reloadData()
        prepTableHeightConstraint.constant = prepTableView.contentSize.height
        
        nutriTableView.dataSource = self
        nutriTableView.delegate = self
        
        nutriTableView.reloadData()
        nutriTableHeightConstraint.constant = nutriTableView.contentSize.height
        
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        
        scrollView.delegate = self
        
        loadRecipeDetail()
        loadReviews()
        
        view.layoutIfNeeded()
        
        self.ingBtnTapped(self)
        

        
     //  to navigate  to user profile on clicking user name
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(goToUserDetails))
        usernameLabel.isUserInteractionEnabled = true
        usernameLabel.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() { // modify tableview heght according to its content
        ingredientTableHeightConstraint.constant = ingredientsTableView.contentSize.height
        prepTableHeightConstraint.constant = prepTableView.contentSize.height
        nutriTableHeightConstraint.constant = nutriTableView.contentSize.height
        reviewTableHeightConstraint.constant = reviewTableView.contentSize.height
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == ingredientsTableView {
            return recipeDetail?.ingredients?.count ?? 0
        }else if tableView == prepTableView {
            return recipeDetail?.steps?.count ?? 0
        }else if tableView == reviewTableView{
            return reviewList.count
        }else if tableView == nutriTableView {
            return recipeDetail?.nutrition?.count ?? 0
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.ingredientsTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetailIngredientCell")
            
            let noLabel = cell?.viewWithTag(100) as! UILabel
            noLabel.text = "\(indexPath.row + 1 )"
            
            let ingImageView = cell?.viewWithTag(200)  as! UIImageView
            let nameLabel = cell?.viewWithTag(300) as! UILabel
            let unitLabel = cell?.viewWithTag(400) as! UILabel

            if let ingredientObject  = recipeDetail?.ingredients {
                let imageUrl:URL = URL(string: (ingredientObject[indexPath.row].familyImageObject?.name)!)!
                ingImageView.kf.setImage(with:imageUrl)
                if let name = ingredientObject[indexPath.row].name{
                    nameLabel.text = self.toHtmlEncodedString(encodedString: name.capitalizingFirstLetter())
                }
                
                if let quantity = ingredientObject[indexPath.row].quantityFloat{
                    let quan = rationalApproximation(of: Double(quantity)) // (1, 3)
                    print("Quantities is \(quan)")
                    if quan.den == 1{
                        unitLabel.text = "\(self.toHtmlEncodedString(encodedString: "\(quan.num)")) \(self.toHtmlEncodedString(encodedString: ingredientObject[indexPath.row].measure?.code ?? ""))"

                    }else{
                        
                        unitLabel.text = "\(self.toHtmlEncodedString(encodedString: "\(quan.num)/\(quan.den)")) \(self.toHtmlEncodedString(encodedString: ingredientObject[indexPath.row].measure?.code ?? ""))"

                    }
                }
//                if let quantity = ingredientObject[indexPath.row].quantityFloat?.clean{
//                unitLabel.text = "\(self.toHtmlEncodedString(encodedString: quantity)) \(self.toHtmlEncodedString(encodedString: ingredientObject[indexPath.row].measure?.code ?? ""))"
//                }
            }
            
            return cell!
        }else if tableView == self.prepTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailPrepCell")
            let titleLabel = cell?.viewWithTag(100) as! UILabel
            titleLabel.text = "\(StringConstants.Labels.step) \(indexPath.row + 1)"
            let subtitleLabel = cell?.viewWithTag(200) as! UILabel
            if let prepObj = recipeDetail?.steps {
                subtitleLabel.text = self.toHtmlEncodedString(encodedString: prepObj[indexPath.row].name!)
            }
            return cell!
        }else if tableView == self.nutriTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailNutritionCell")
            
            let titleLabel = cell?.viewWithTag(100) as! UILabel
            let valueLabel = cell?.viewWithTag(200) as! UILabel
            
            if let nutriList = recipeDetail?.nutrition  {
                let nutriObj = nutriList[indexPath.row]
                titleLabel.text = self.toHtmlEncodedString(encodedString:  nutriObj.name!)
//                if let qty = nutriObj.quantity , let unit = nutriObj.unit {
//                    valueLabel.text = "\(qty) \(unit)"
//                }
                valueLabel.text = self.toHtmlEncodedString(encodedString:  nutriObj.value!)

                
            }
            
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! FFReviewTableViewCell
            cell.reviewObject = reviewList[indexPath.row]
            cell.refreshCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- IBAction methods
    
    @IBAction func ingBtnTapped(_ sender :Any ){ // ingredients tab selection action
        refreshBtns()
        ingredientBtn.isSelected = true
        ingredientSelectedView.isHidden = false
        ingredientsTableView.isHidden = false
    }
    
    @IBAction func prepBtnTapped(_ sender :Any ){ // preparation tab selection action
        refreshBtns()
        prepBtn.isSelected = true
        prepSelectedView.isHidden = false
        prepTableView.isHidden = false
    }
    
    @IBAction func nutritionBtnTapped(_ sender :Any ){ // nutrition button sleection action
        refreshBtns()
        nutritionBtn.isSelected = true
        nutritionSelectedView.isHidden = false
        nutriTableView.isHidden = false
    }
    
    @IBAction func loadMoreReviewsBtnTapped(_ sender :Any ){ // see ore button ction
        print("load more tapped")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewListVC") as! FFReviewListViewController
        vc.recipeId = self.recipeId
        vc.totalCount = self.maxResults
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func favBtnTapped(_ sender :Any){ //favorite button action
        if let _ = FFBaseClass.sharedInstance.getUser() {
            if self.favBtn.isSelected {
                callDisLikeRecipeAPI()
            }else {
                callLikeRecipeAPI()
            }
            
        }else {
            
            goToLogin()
            
        }
        
    }
    
    
    @IBAction func shareBtnTapped(_ sender :Any){
        
    }
    
    @IBAction func backBtnTapped(_ sender :Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backToReviewsBtnTapped(_ sender :Any){
        showOrHideReviews()
    }
    
    @IBAction func postReviewBtnTapped(_ sender :Any){ //post review button action
        
        if let _ = FFBaseClass.sharedInstance.getUser() {
        }else {
//            FFBaseClass.sharedInstance.showAlert(mesage: "Log in to continue!", view: self)
            
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotConnectedVC") as! NotConnectedVC
            self.navigationController?.pushViewController(vc, animated: true)

            return
        }
        
        
        
        reviewRatingView.didTouchCosmos = {
            rating in
            
            self.reviewRatingLabel.text = "\(Int(rating))/5"
        }
        
        if addReviewView.isHidden == true {
            addReviewView.isHidden  =  false
            emptyReviewView.isHidden = true
            reviewTableView.isHidden = true
        }else {
    
            callAddReviewAPI()
   
        }
        
    }
    
    
    //MARK:- API calls
    
    func loadReviews(){ // recipe reviews webservice
        if let recipID = recipeId {
            let stringId = "\(recipID)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getRecipeReviewList(recipeId: stringId, maxResults: "5", success: { (response:FFBaseResponseModel) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.reviewList = response.reviewList ?? []
                self.maxResults = "\(response.totalCountInt ?? 0)"
                self.reviewTableView.reloadData()
                
                self.showOrHideReviews()
                self.reviewCountLabel.text = "\(self.maxResults) \(StringConstants.Labels.reviewsonthisrecipe)"
                let reviewCountString = "\(self.reviewList.count)"
                if reviewCountString == self.maxResults {
                    self.loadMoreBtn.isHidden = true
                }else {
                    self.loadMoreBtn.isHidden = false
                }
                
                self.reviewTableView.layoutIfNeeded()
                
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                
            }
            
        }
        
        
        
    }
    
    
    
    func loadRecipeDetail(){ // recipe detail webservice
        FFLoaderView.showInView(view: self.view)
        if let recipID = recipeId {
            let stringId = "\(recipID)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getRecipeDetail(recipeId: stringId, success: { (response) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.recipeDetail = response
                self.populateData()
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
        
    }
    
    func callLikeRecipeAPI(){ //like recipe webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeRecipe(recipeID:self.recipeId, success: { (resp) in
            print(resp)
            FFLoaderView.hideInView(view: self.view)
            self.favBtn.isSelected = true
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    func callDisLikeRecipeAPI(){ //dislike recipe webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeRecipe(recipeID:self.recipeId, success: { (resp) in
            print(resp)
            FFLoaderView.hideInView(view: self.view)
            self.favBtn.isSelected = false
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
            
        }
    }
    
    func callAddReviewAPI(){ // addreview webservice
        
        if validateReview() {
            
            if let recipeID = self.recipeId {
                FFLoaderView.showInView(view: self.view)
                FFManagerClass.postRecipeReview(recipeId: "\(recipeID)", review: self.reviewTextView.text, rate: "\(self.reviewRatingView.rating)", success: { (response) in
                    print(response)
                    

//                    self.reviewList.insert(response, at: 0)
//                    self.reviewList.append(response)
                    FFLoaderView.hideInView(view: self.view)
                    
                    self.loadReviews()
                    return
                    if let x = Int(self.maxResults) {
                        self.maxResults = "\(x + 1)"
                    }
                    else {
                        self.maxResults = ""
                    }
                    self.reviewTextView.text = ""
                    self.reviewRatingView.rating = 1
                    
                    self.reviewCountLabel.text = "\(self.maxResults) \(StringConstants.Labels.reviewsonthisrecipe)"
                    self.reviewTableView.reloadData()
                    self.showOrHideReviews()
                    self.reviewTableView.layoutIfNeeded()
                    
                }) { (error) in
                    print(error)
                    FFLoaderView.hideInView(view: self.view)
                    FFBaseClass.sharedInstance.showError(error: error, view: self)
                }
            }
        }
        
    }
    
    
    
    //MARK:- Custom Functions
    
    func refreshBtns(){
        ingredientBtn.isSelected = false
        prepBtn.isSelected = false
        nutritionBtn.isSelected  = false
        
        ingredientSelectedView.isHidden = true
        prepSelectedView.isHidden = true
        nutritionSelectedView.isHidden = true
        
        ingredientsTableView.isHidden = true
        prepTableView.isHidden = true
        nutriTableView.isHidden = true
        
    }
    
    @objc func goToUserDetails(){ // go to user profile
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberProfileVC") as! FFMemberProfileViewController
        vc.userId = self.recipeDetail?.user?.id
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func populateData(){ // populate fields foem webservice response
        
        if recipeDetail?.isFavorite == 1 {
            favBtn.isSelected = true
        }else {
            favBtn.isSelected = false
        }
        
        self.topLabel.text = recipeDetail?.name
        
        if let imageList = recipeDetail?.imageArray {
            let imageUrl:URL = URL(string: (imageList.first?.name)!)!
            recipeImageView.kf.setImage(with: imageUrl)
        }
        
//        if let imageList = recipeDetail?.imageObject {
//            let imageUrl:URL = URL(string: (imageList.name)!)!
//            recipeImageView.kf.setImage(with: imageUrl)
//        }
        
//        if let ingredientObject  = recipeDetail?.ingredients {
//                      let imageUrl:URL = URL(string: (ingredientObject[indexPath.row].familyImageObject?.name)!)!
//                      ingImageView.kf.setImage(with:imageUrl)
//                      nameLabel.text = self.toHtmlEncodedString(encodedString: ingredientObject[indexPath.row].name!)
//                  }
        
        if let imgCnt = recipeDetail?.nbImages {
            imgCountLabel.text = "\(imgCnt)"
        }
        
        if let category = recipeDetail?.categories {
            categoryLabel.text = category.first?.name_normalized?.uppercased()
        }
        
        self.nameLabel.text = recipeDetail?.name
        var name = ""

        if let usr = FFBaseClass.sharedInstance.getUser(){
            if recipeDetail?.userDetail?.id == usr.id{
                name = "\(StringConstants.Labels.MYSELF)"
                self.usernameLabel.text = name
                usernameLabel.isUserInteractionEnabled = false

            }else{
                if let lastname = recipeDetail?.userDetail?.lastName,!lastname.isEmpty {
                    name = lastname + " "
                }
                
                if let firstname = recipeDetail?.userDetail?.firstName,!firstname.isEmpty {
                    let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                    name = name + String(firstLetter)
                    name = name + "."
                }
                
                self.usernameLabel.text = name.uppercased()

            }
        
        }else{
            if let lastname = recipeDetail?.userDetail?.lastName,!lastname.isEmpty {
                name = lastname + " "
            }
            
            if let firstname = recipeDetail?.userDetail?.firstName,!firstname.isEmpty {
                let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                name = name + String(firstLetter)
                name = name + "."
            }
            
            self.usernameLabel.text = name.uppercased()

        }
        
        
        self.toughnessLabel.text = recipeDetail?.toughness?.name
        var totalTime = 0
        
        if let prepTime = recipeDetail?.preparationTime {
            self.preparationTimelabel.text = convertMinToHours(minute: prepTime)
            totalTime = totalTime + prepTime
        }
        
        if let bakingTime = recipeDetail?.bakingTime {
            self.cookingTimeLabel.text = convertMinToHours(minute: bakingTime)
            totalTime = totalTime + bakingTime
        }
        
        if let rate = recipeDetail?.scoreString {
            self.ratingLabel.text  = "\(rate)/5"
            
        }else {
            if let rate = recipeDetail?.score {
                 self.ratingLabel.text  = "\(rate)/5"
            }
        }
        
        totalTimeLabel.text = convertMinToHours(minute: totalTime)

        
        if let personCnt = recipeDetail?.noOfPersons {
            let ingredientCount = ingredientsTableView.tableHeaderView?.viewWithTag(100) as! UILabel
            ingredientCount.text = "\(StringConstants.Labels.forlabel) \(personCnt) \(StringConstants.Labels.persons)"
        }
        
        ingredientsTableView.reloadData()
        prepTableView.reloadData()
        nutriTableView.reloadData()
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // show/hide top view on scroll up
        if scrollView.contentOffset.y >= (self.recipeImageView.frame.size.height){
            topView.backgroundColor = UIColor.primary
            topLabel.isHidden = false
        }else {
            topView.backgroundColor = UIColor.clear
            topLabel.isHidden = true
        }
    }
    
    
    func goToLogin(){
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
        loginVC.isFirstLaunch = false
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    @objc func showOrHideReviews(){ // show reveiew list else show empty view
        
        addReviewView.isHidden = true
        
        if reviewList.count > 0 {
            reviewTableView.isHidden = false
            emptyReviewView.isHidden = true
        }else{
            reviewTableView.isHidden = true
            emptyReviewView.isHidden = false
        }
        
    }
    
    func validateReview() -> Bool { // review alidation
        
        if  self.reviewTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            return false
        }
        
        if reviewRatingView.rating < 1 {
            return false
        }
        
        return true
    }
    
    
    func convertMinToHours(minute:Int) -> String{
        
        let hr = minute / 60
        let min = minute % 60
        
        if hr <= 0 {
            return "\(min) \(StringConstants.Labels.min)"
        }
        if min <= 0  {
            return "\(hr) \(StringConstants.Labels.hr)"
        }
        return "\(hr)\(StringConstants.Labels.hr) \(min)\(StringConstants.Labels.min)"
        
    }
    
}
