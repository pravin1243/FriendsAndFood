//
//  FFMemberProfileViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 29/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
import Kingfisher

class FFMemberProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    @IBOutlet weak var pointslabel:UILabel!
    var editRequest = FFEditProfileRequestModel()
    @IBOutlet weak var followersCountLabel:UILabel!
    @IBOutlet weak var followingCountLabel:UILabel!

    @IBOutlet weak var namelabel:UILabel!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var sendMsgBtn:UIButton!
    @IBOutlet weak var sendInvitationBtn:UIButton!
    @IBOutlet weak var badgeImageView:UIImageView!

    @IBOutlet weak var reditProfileBtn:UIButton!
    @IBOutlet weak var rsendMsgBtn:UIButton!
    @IBOutlet weak var rsendInvitationBtn:UIButton!
    
    @IBOutlet weak var editProfileBtnHC:NSLayoutConstraint!
    @IBOutlet weak var sendMsgBtnHC:NSLayoutConstraint!
    @IBOutlet weak var sendInvitationBtnHC:NSLayoutConstraint!

    @IBOutlet weak var rsendMsgBtnHC:NSLayoutConstraint!
    @IBOutlet weak var rsendInvitationBtnHC:NSLayoutConstraint!

    @IBOutlet weak var recipeTableView:UITableView!
    
    @IBOutlet weak var infoView:UIView!
    @IBOutlet weak var infoBtn:UIButton!
    @IBOutlet weak var recipeView:UIView!
    @IBOutlet weak var recipeBtn:UIButton!
    
    @IBOutlet weak var notConnectedView:UIView!
    
    var userDetail:FFUserObject?
    var userId:Int?
    
    var recipeList:[FFEntranceObject] = []
    @IBOutlet weak var recipeTableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var sendInviteBtnHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var favRecipeLabel:UILabel!
    @IBOutlet weak var favRecipeCollectionView:UICollectionView!
    @IBOutlet weak var favRecipeHeightConstraint:NSLayoutConstraint!
    var favRecipeList:[FFRecipeTypeObject] = []

    
    @IBOutlet weak var areeaInterestsLabel:UILabel!
    @IBOutlet weak var areaOfInterestsCollectionView:UICollectionView!
    @IBOutlet weak var interestCollectionViewHeightConstraint:NSLayoutConstraint!
    var favinterestList:[FFRecipeTypeObject] = []

    @IBOutlet weak var favCategoriesLabel:UILabel!
    @IBOutlet weak var favCategoriesCollectionView:UICollectionView!
    @IBOutlet weak var favCategoriesHeightConstraint:NSLayoutConstraint!
    var favcategoryList:[FFRecipeTypeObject] = []

    @IBOutlet weak var favIngredientsLabel:UILabel!
    @IBOutlet weak var favIngredientsCollectionView:UICollectionView!
    @IBOutlet weak var favIngredientsHeightConstraint:NSLayoutConstraint!
    var favIngredientList:[FFEntranceObject] = []

    @IBOutlet weak var favStoreLabel:UILabel!
    @IBOutlet weak var favStoreCollectionView:UICollectionView!
    @IBOutlet weak var favStoreHeightConstraint:NSLayoutConstraint!
    var favStoreList:[FFRecipeTypeObject] = []

    @IBOutlet weak var favRestaurantLabel:UILabel!
    @IBOutlet weak var favRestaurantCollectionView:UICollectionView!
    @IBOutlet weak var favRestaurantHeightConstraint:NSLayoutConstraint!
    var favRestaurantList:[FFRecipeTypeObject] = []

    @IBOutlet weak var favRecipeLabelHC:NSLayoutConstraint!
    @IBOutlet weak var areeaInterestsLabelHC:NSLayoutConstraint!
    @IBOutlet weak var favCategoriesLabelHC:NSLayoutConstraint!
    @IBOutlet weak var favStoreLabelHC:NSLayoutConstraint!
    @IBOutlet weak var favRestaurantLabelHC:NSLayoutConstraint!
    @IBOutlet weak var favIngredientsLabelHC:NSLayoutConstraint!

    @IBOutlet weak var followButton:UIButton!
    @IBOutlet weak var followButtonHeightConstraint:NSLayoutConstraint!
    var favBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
//        userId = 3402
//        userId = 25555
        // style info and recipe buttons
        infoBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        infoBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        recipeBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        recipeBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        infoBtn.isSelected = true
        recipeView.isHidden = true
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
        favRecipeCollectionView.dataSource = self
        favRecipeCollectionView.delegate = self

        areaOfInterestsCollectionView.dataSource = self
        areaOfInterestsCollectionView.delegate = self

        favCategoriesCollectionView.dataSource = self
        favCategoriesCollectionView.delegate = self
        
        favIngredientsCollectionView.dataSource = self
        favIngredientsCollectionView.delegate = self
        
        favStoreCollectionView.dataSource = self
        favStoreCollectionView.delegate = self
        
        favRestaurantCollectionView.dataSource = self
        favRestaurantCollectionView.delegate = self

        // customise profile imageview
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.primary.cgColor
        profileImageView.layer.borderWidth = 2
        
        hideMainButtons()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customiseNavBar()
        getProfile()
        
    }
    
    func checkFreind(userid:Int?){ // check if user is friend or not
        
        FFLoaderView.showInView(view: self.view)
        
        FFManagerClass.checkFreind(userId: userid, success: { (response:FFBaseResponseModel) in
            FFLoaderView.hideInView(view: self.view)
            
            self.sendMsgBtn.isHidden = true
            self.sendInvitationBtn.isHidden = true
            self.rsendMsgBtn.isHidden = true
            self.rsendInvitationBtn.isHidden = true
            

            if response.message == "1" {
                self.sendMsgBtn.isHidden = false
                self.sendMsgBtnHC.constant = 40.0
            }else if response.message == "-1"{
                self.sendInvitationBtn.isHidden = false
                self.sendInvitationBtn.isEnabled = true
                self.sendInvitationBtn.alpha = 1
                self.rsendInvitationBtn.isHidden = false
                self.rsendInvitationBtn.isEnabled = true
                self.rsendInvitationBtn.alpha = 1
                self.sendInvitationBtnHC.constant = 40.0
                self.rsendInvitationBtnHC.constant = 40.0

                
            }else if response.message == "2" || response.message == "0" {
                self.sendInvitationBtn.isHidden = false
                self.sendInvitationBtn.isEnabled = false
                self.sendInvitationBtn.alpha = 0.5
                self.rsendInvitationBtn.isHidden = false
                self.rsendInvitationBtn.isEnabled = false
                self.rsendInvitationBtn.alpha = 0.5
                self.sendMsgBtnHC.constant = 40.0
                self.rsendInvitationBtnHC.constant = 40.0

                
            }
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
        
    }
    
    func getProfile(){ // get profil webservice
        
        if let _ = userId { // recipe detial
            
            notConnectedView.isHidden = true
            
            callMyProfileAPI()
            callMyRecipesAPI()
            
            if let usr = FFBaseClass.sharedInstance.getUser() , self.userId == usr.id {

                //                checkFreind(userid: userId)
            }else {
                self.callMemberFavouritesAPI()
                
                if let _ = FFBaseClass.sharedInstance.getUser(){
                    checkFreind(userid: userId)
                    
                }else {
                    sendMsgBtn.isHidden = true
                    sendInvitationBtn.isHidden = true
                    rsendMsgBtn.isHidden = true
                    rsendInvitationBtn.isHidden = true
                    
                }
            }
            
        }else {
            notConnectedView.isHidden = false
            
        }
        
    }
    
    func customiseNavBar(){
        
        self.title = "Profile"
        
        favBtn = UIButton(type: UIButton.ButtonType.custom)
            favBtn?.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
        favBtn?.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
        favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControl.Event.touchUpInside)
            favBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            let favButton = UIBarButtonItem(customView: favBtn!)
        
        let shareBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
        //            shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControlEvents.touchUpInside)
        shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareButton = UIBarButtonItem(customView: shareBtn)
        self.navigationItem.rightBarButtonItems = [ favButton]
    }
    func hideMainButtons (){
        sendInvitationBtnHC.constant = 0
        sendMsgBtnHC.constant = 0
        rsendMsgBtnHC.constant = 0
        rsendInvitationBtnHC.constant = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc  func favBtnTapped(){
        if favBtn?.isSelected == true {
            followMember(isDelete: 1)
        }else {
            followMember(isDelete: 0)

        }

    }
    
    
    @IBAction func infoButtonSelected(_ sender : Any){ // info button slection action
        infoBtn.isSelected = true
        recipeBtn.isSelected = false
        infoView.isHidden = false
        recipeView.isHidden = true
        
    }
    
    @IBAction func recipeButtonSelected(_ sender : Any){ // recipe button slection action
        infoBtn.isSelected = false
        recipeBtn.isSelected = true
        infoView.isHidden = true
        recipeView.isHidden = false
    }
    
    
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func callMyProfileAPI(){ // profile webservice selction
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getUserDetails(userID: userId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.userDetail = response
            
            if (self.userDetail?.interests?.count)! > 0 {
                self.areaOfInterestsCollectionView.reloadData()
            }
            
            if let isfollow = self.userDetail?.isfollowed{
                if isfollow == 1{
                    self.favBtn?.isSelected = true

                }else{
//                    self.followButton.setTitle("Follow", for: .normal)
                    self.favBtn?.isSelected = false

                }
            }
            if let followers = self.userDetail?.followerscount {
                         self.followersCountLabel.text = "\(followers)"
                     }
                     if let following = self.userDetail?.followingcount {
                                 self.followingCountLabel.text = "\(following)"
                             }
            
            if let photo = self.userDetail?.photo , !photo.isEmpty{
                let imageUrl:URL = URL(string: photo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
                self.profileImageView.kf.setImage(with: imageUrl, options: [.forceRefresh])
            }
            
            if let badgephoto = self.userDetail?.gamification?.image , !badgephoto.isEmpty{
                let imageUrlnew:URL = URL(string: badgephoto.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
                self.badgeImageView.kf.setImage(with: imageUrlnew, options: [.forceRefresh])
            }
            
            if let points = self.userDetail?.gamification?.points{
                self.pointslabel.text = "\(points) points"
                
            }
            var name:String = ""
            if let firstname = self.userDetail?.firstName {
                name = firstname + " "
            }
            if let lastname = self.userDetail?.lastName {
                name = name + lastname
            }
            self.namelabel.text = name
          self.title = name
            
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callMyRecipesAPI(){ // recipe list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyRecipesList(userID:userId,success: { (response) in
            self.recipeList = response
            FFLoaderView.hideInView(view: self.view)
            if self.recipeList.count > 0 {
                self.recipeTableView.isHidden = false
            }else {
                self.recipeTableView.isHidden = true
            }
            self.recipeTableView.reloadData()
            //            self.recipeTableViewHeightConstraint.constant = self.recipeTableView.contentSize.height
            self.recipeTableViewHeightConstraint.constant = CGFloat(90 * self.recipeList.count)
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callMemberFavouritesAPI(){ // recipe list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMemberfavourites(memberID:userId,success: { (response) in
            self.favRecipeList = response.favoriterecipe!
            self.favinterestList = response.favoriteinterests!
            self.favcategoryList = response.favoritecategory!
            self.favIngredientList = response.favoriteingredient!
            self.favStoreList = response.favoritestore!
            self.favRestaurantList = response.favoriterestaurant!

            FFLoaderView.hideInView(view: self.view)
            
            if self.favRecipeList.count > 0{
                self.favRecipeCollectionView.reloadData()
                self.favRecipeCollectionView.layoutIfNeeded()
                self.favRecipeHeightConstraint.constant = self.favRecipeCollectionView.contentSize.height
            }else{
                self.favRecipeLabelHC.constant = 0
                self.favRecipeHeightConstraint.constant = 0
            }

            if self.favinterestList.count > 0{
                self.areaOfInterestsCollectionView.reloadData()
                self.areaOfInterestsCollectionView.layoutIfNeeded()
                self.interestCollectionViewHeightConstraint.constant = self.areaOfInterestsCollectionView.contentSize.height
            }else{
                self.areeaInterestsLabelHC.constant = 0
                self.interestCollectionViewHeightConstraint.constant = 0
            }
       if self.favcategoryList.count > 0{
           self.favCategoriesCollectionView.reloadData()
           self.favCategoriesCollectionView.layoutIfNeeded()
           self.favCategoriesHeightConstraint.constant = self.favCategoriesCollectionView.contentSize.height
       }else{
           self.favCategoriesLabelHC.constant = 0
           self.favCategoriesHeightConstraint.constant = 0
       }
        if self.favIngredientList.count > 0{
            self.favIngredientsCollectionView.reloadData()
            self.favIngredientsCollectionView.layoutIfNeeded()
            self.favIngredientsHeightConstraint.constant = self.favIngredientsCollectionView.contentSize.height
        }else{
            self.favIngredientsLabelHC.constant = 0
            self.favIngredientsHeightConstraint.constant = 0
        }
        if self.favStoreList.count > 0{
            self.favStoreCollectionView.reloadData()
            self.favStoreCollectionView.layoutIfNeeded()
            self.favStoreHeightConstraint.constant = self.favStoreCollectionView.contentSize.height
        }else{
            self.favStoreLabelHC.constant = 0
            self.favStoreHeightConstraint.constant = 0
        }
            if self.favRestaurantList.count > 0{
                self.favRestaurantCollectionView.reloadData()
                self.favRestaurantCollectionView.layoutIfNeeded()
                self.favRestaurantHeightConstraint.constant = self.favRestaurantCollectionView.contentSize.height
            }else{
                self.favRestaurantLabelHC.constant = 0
                self.favRestaurantHeightConstraint.constant = 0
            }



        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    //MARK:- TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
        cell.responseObject = self.recipeList[indexPath.row]
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
    

    
    @IBAction func sendMsgBtntapped(_ sender : Any){ // message button slection action
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! FFChatViewController
        vc.chatTitle = self.title
        vc.userId = userId
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func sendInvitationBtntapped(_ sender : Any){ // invittation send buttona ction
        
        if let nname =   self.userDetail?.nickName {
            callSearchFriendByNicknameAPI(nickname: nname)
        }else if let email = self.userDetail?.email {
            callInviteFriendAPI(email: email)
        }
        
        
    }
    
    func callInviteFriendAPI(email:String?){ // invite friend webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByEmail(email: email, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.sendInvitationBtn.isEnabled = false
            self.sendInvitationBtn.alpha = 0.5
            self.rsendInvitationBtn.isEnabled = false
            self.rsendInvitationBtn.alpha = 0.5
            
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callSearchFriendByNicknameAPI(nickname:String){ // search friend wewbservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByNickname(nickname: nickname, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.sendInvitationBtn.isEnabled = false
            self.sendInvitationBtn.alpha = 0.5
            self.rsendInvitationBtn.isEnabled = false
            self.rsendInvitationBtn.alpha = 0.5
            
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    //MARK:- CollectionView functions
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == favRecipeCollectionView{
            return favRecipeList.count
            }else if collectionView == areaOfInterestsCollectionView{
            return favinterestList.count
            }else if collectionView == favCategoriesCollectionView{
            return favcategoryList.count
            }else if collectionView == favIngredientsCollectionView{
            return favIngredientList.count
            }else if collectionView == favStoreCollectionView{
            return favStoreList.count
            }else if collectionView == favRestaurantCollectionView{
            return favRestaurantList.count
            }else{
                return 0
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var collectCell: UICollectionViewCell = UICollectionViewCell()
            if collectionView == favRecipeCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favRecipeList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }else if collectionView == areaOfInterestsCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favinterestList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }else if collectionView == favCategoriesCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favcategoryList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }else if collectionView == favIngredientsCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngrdientCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favIngredientList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }else if collectionView == favStoreCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favStoreList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }else {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.favRestaurantList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
                
                collectCell = cell

            }

            return collectCell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        selectedTheme = self.interestList[indexPath.row].stringId!
//            selectedTheme = "\(self.interestList[indexPath.row].id ?? 0)"
//
//            collectionView.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellSize = collectionView.bounds.size.width / 3
            return CGSize(width: cellSize, height: 60)
        }

    

    func followMember(isDelete: Int?) { // recipe dislike webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.followMember(memberID:userId, isDelete: isDelete, success: { (resp) in
            print(resp)
            FFLoaderView.hideInView(view: self.view)
            self.getProfile()
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
            
        }
    }
    
    @IBAction func followersBtntapped(_ sender : Any){ // followers button slection action
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC") as! FFFollowViewController
      vc.selectedTab = 0
      vc.fromWhere = "profile"
      vc.userId = userId
      self.navigationController?.pushViewController(vc, animated: true)

      }
      
      @IBAction func followingBtntapped(_ sender : Any){ // following button slection action
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC") as! FFFollowViewController
          vc.selectedTab = 1
          vc.fromWhere = "profile"
          vc.userId = userId
          self.navigationController?.pushViewController(vc, animated: true)

      }
}
