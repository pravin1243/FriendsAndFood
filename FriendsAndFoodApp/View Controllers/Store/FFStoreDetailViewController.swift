//
//  FFStoreDetailViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 07/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
import Cosmos

class FFStoreDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var clickhereDeclarebtn:UIButton!
    var currentIndexPath : IndexPath?

    @IBOutlet weak var infoBtn:UIButton!
    @IBOutlet weak var recipeBtn:UIButton!
    @IBOutlet weak var activityBtn:UIButton!
    
    @IBOutlet weak var infoView:UIView!
    @IBOutlet weak var recipeView:UIView!
    @IBOutlet weak var activityView:UIView!
    
    @IBOutlet weak var recipeTableView:UITableView!
    @IBOutlet weak var recipeTableViewHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var activityTableView:UITableView!
    @IBOutlet weak var activityTableViewHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var openHourTableView:UITableView!
    @IBOutlet weak var openHourTableViewHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var getInTouchTableView:UITableView!
    @IBOutlet weak var getInToucTableViewHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var ownerDeclarationView1:UIView!
    @IBOutlet weak var ownerDeclarationView2:UIView!
    @IBOutlet weak var ownerDeclarationView3:UIView!

    var getInTouchArray:[String] = []
    var getInTouchColorArray:[UIColor] = []
    var getInTouchImageArray = [#imageLiteral(resourceName: "phone"),#imageLiteral(resourceName: "contactgreen"),#imageLiteral(resourceName: "link"),#imageLiteral(resourceName: "facebook"),#imageLiteral(resourceName: "search-1")]
//    var openHourArray = ["Sunday", "Monday","Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ]
    var openHourArray:[String] = []

    var openHourTimeArray:[String] = []
    var restaurantdetail:[FFRestaurantObject]?
    var restaurantID:Int?
    var cityId: Int?
    var recipeList:[FFEntranceObject] = []
    var activityList:[FFRestaurantObject] = []
    var menuList:[FFRestaurantMenuObject] = []

    var firstList:[FFRestMenuObject] = []
    var secondList:[FFRestMenuObject] = []
    var thirdList:[FFRestMenuObject] = []

    
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var phoneLbl:UILabel!
    @IBOutlet weak var adrsLbl:UILabel!
    
    var favBtn: UIButton?
    var isFav:Bool?
    var isOwner:Bool?
    var restauratList:[FFRestaurantObject] = []
    var storeList:[FFStoreObject] = []
    
    var storeID:Int?
    var storedetail:FFStoreObject?
    var storeRestList:[FFResStoreObject]? = [FFResStoreObject]()
    var storeResObject: FFResStoreObject?
    var storeProductCategoriesList:[FFStoreProductCategoriesObject] = []
    var storeProductsList: [FFStoreProductsObject] = []

    var storeProductsTempList: [FFStoreProductsObject] = []

    
    @IBOutlet weak var reviewTableView:UITableView!
    @IBOutlet weak var reviewTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emptyReviewView:UIView!
    @IBOutlet weak var reviewTextView:UITextView!
    @IBOutlet weak var reviewRatingView:CosmosView!
    @IBOutlet weak var reviewRatingLabel:UILabel!
    @IBOutlet weak var addReviewView:UIView!
    @IBOutlet weak var reviewCountLabel:UILabel!
    @IBOutlet weak var loadMoreBtn:UIButton!

    @IBOutlet weak var emptyReviewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var addReviewHeightConstraint: NSLayoutConstraint!

    var recipeDetail:FFEntranceObject?
    var recipeId:Int?
    
    var maxResults:String = "2"
    var reviewList:[FFReviewObject] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.tableFooterView = UIView()
        
        
        openHourTableView.dataSource = self
        openHourTableView.delegate = self

        
        getInTouchTableView.dataSource = self
        getInTouchTableView.delegate = self

        
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.tableFooterView = UIView()

        infoBtn.setTitle("\(StringConstants.Labels.Info)", for: .normal)
        infoBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        infoBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        infoBtn.isSelected = true
        
        recipeBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        recipeBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)

        activityBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        activityBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        infoBtnTapped(self)
        
        DispatchQueue.main.async {
            if let _ = self.storeID {
                self.callStoreDetailAPI()

                self.callStoreProductCategoriesAPI()
                self.loadReviews()
            }
            self.getStoreList()

        }
        customiseNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(self.storeInfoUpdated(notification:)), name: Notification.Name("storeInfoUpdated"), object: nil)


        // Do any additional setup after loading the view.
    }
    @objc func storeInfoUpdated(notification: NSNotification){
         callStoreDetailAPI()

     }
      func hideOwnerDeclaration(){ // modify owner declaration banner according to if is owner or not
            
    //        let clbl = ownerDeclarationView1.viewWithTag(444) as! UILabel
            for subview in ownerDeclarationView1.subviews {
                subview.isHidden = true
            }
    //        clbl.isHidden = false
            ownerDeclarationView1.backgroundColor = UIColor.clear

        }
    override func viewDidLayoutSubviews() { // modify tableview heght according to its content
//         ingredientTableHeightConstraint.constant = ingredientsTableView.contentSize.height
//         prepTableHeightConstraint.constant = prepTableView.contentSize.height
//         nutriTableHeightConstraint.constant = nutriTableView.contentSize.height
//         reviewTableHeightConstraint.constant = reviewTableView.contentSize.height
//         self.reviewTableHeightConstraint.constant = self.reviewTableView.contentSize.height * CGFloat(self.reviewList.count)
//        self.reviewTableHeightConstraint.constant = self.reviewTableView.contentSize.height

//        self.reviewTableHeightConstraint.constant = CGFloat(107 * reviewList.count)

     }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Custom Functions
    
    func setOwnerDeclaration(){ // modify owner declaration banner according to if is owner or not
        
        if isOwner == true {
            
            
            let clbl = ownerDeclarationView1.viewWithTag(444) as! UILabel
            for subview in ownerDeclarationView1.subviews {
                subview.isHidden = true
            }
            clbl.isHidden = false
            ownerDeclarationView1.backgroundColor = UIColor.clear
            
            let clb2 = ownerDeclarationView2.viewWithTag(444) as! UILabel
            for subview in ownerDeclarationView2.subviews {
                subview.isHidden = true
            }
            clb2.isHidden = false
            ownerDeclarationView2.backgroundColor = UIColor.clear

            
            let clb3 = ownerDeclarationView3.viewWithTag(444) as! UILabel
            for subview in ownerDeclarationView3.subviews {
                subview.isHidden = true
            }
            clb3.isHidden = false
            ownerDeclarationView3.backgroundColor = UIColor.clear

            
        }
    }
    
    func callStoreDetailAPI() { // restaurant detail webservice integration
        
        FFManagerClass.getStoreDetail(id: self.storeID, success: { (response) in
            self.storedetail = response
            self.populateData()
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func callStoreProductCategoriesAPI() { // Store Product Categories webservice integration
           
        FFManagerClass.getStoreProductCategories(id: self.storeID, success: { (response) in
               self.storeProductCategoriesList = response
            if self.storeProductCategoriesList.count > 0{
            DispatchQueue.main.async {
                self.callStoreProductsAPI()
            }
            }
           }) { (error) in
               FFBaseClass.sharedInstance.showError(error: error, view: self)
           }
       }
    
    func callStoreProductsAPI() { // Store Product Categories webservice integration
           
           FFManagerClass.getStoreProducts(id: self.storeID, success: { (response) in
               self.storeProductsList = response
            var emptyIndex = [Int]()
            if self.storeProductsList.count > 0{
            for i in 0...self.storeProductCategoriesList.count - 1{
                self.storeProductsTempList.removeAll()
                for j in 0...self.storeProductsList.count - 1{
                    if self.storeProductCategoriesList[i].id == self.storeProductsList[j].storecategoryid{
                        self.storeProductsTempList.append(self.storeProductsList[j])
                    }
                }
                self.storeProductCategoriesList[i].products = self.storeProductsTempList
                if self.storeProductsTempList.count > 3{
                    self.storeProductCategoriesList[i].count = 3
                }else{
                self.storeProductCategoriesList[i].count = self.storeProductsTempList.count
                }
                if self.storeProductsTempList.count == 0{
                    emptyIndex.append(i)
                }
                
            }
            }else{
                self.storeProductCategoriesList.removeAll()
            }
            
            if emptyIndex.count > 0{
                self.storeProductCategoriesList.remove(at: emptyIndex)
            }
            self.recipeTableView.isHidden = false
//            self.emptyMenuLbl.isHidden = true
//            self.emptyMenuBtn.isHidden = true

            self.recipeTableView.reloadData()
            self.recipeTableView.layoutIfNeeded()
            self.recipeTableViewHeightConstraint.constant = self.recipeTableView.contentSize.height == 0 ? 200 : self.recipeTableView.contentSize.height

           }) { (error) in
               FFBaseClass.sharedInstance.showError(error: error, view: self)
           }
       }
    
    func getStoreList(){ // restaurant list webservice intergration
           
           FFLoaderView.showInView(view: self.view)
       FFManagerClass.getStoresListCityWise(id: String(cityId ?? 0), success: { (response) in
               FFLoaderView.hideInView(view: self.view)
               self.storeList = response
        
        if self.storeList.count > 0{
              for i in 0...self.storeList.count - 1{
                self.storeRestList?.append(FFResStoreObject(storeType:"Store" ,sid: self.storeList[i].id, sglobalStoreId: self.storeList[i].globalStoreId, sname: self.storeList[i].name, snameNormalized: self.storeList[i].nameNormalized, sstoreTypeId: self.storeList[i].storeTypeId, sratingValue: self.storeList[i].ratingValue, sreviewCount: self.storeList[i].reviewCount, sphone: self.storeList[i].phone, semailStore: self.storeList[i].emailStore, swebsite: self.storeList[i].website, slatitude: self.storeList[i].latitude, slongitude: self.storeList[i].longitude, saddress: self.storeList[i].address, spostalCode: self.storeList[i].postalCode, sregionId: self.storeList[i].regionId, sdepartmentId: self.storeList[i].departmentId, sdistrictId: self.storeList[i].districtId, scityId: self.storeList[i].cityId, scountryId: self.storeList[i].countryId, scountryName: self.storeList[i].countryName, scityName: self.storeList[i].cityName, storeTypeName: self.storeList[i].storeTypeName, imageSmall: self.storeList[i].imageSmall, imageMedium: self.storeList[i].imageMedium, imageLarge: self.storeList[i].imageLarge))
              }
              }
        self.getRestaurantList()

        self.activityTableView.reloadData()
        self.activityTableView.layoutIfNeeded()
        self.activityTableViewHeightConstraint.constant = self.activityTableView.contentSize.height == 0 ? 90 : self.activityTableView.contentSize.height

           }) { (error) in
               FFLoaderView.hideInView(view: self.view)
               FFBaseClass.sharedInstance.showError(error: error, view: self)
           }
           
       }
    
    func getRestaurantList(){ // restaurant list webservice intergration
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getRestaurantsListCityWise(id: String(cityId ?? 0), success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.restauratList = response
            
            let odds = (0...100).filter { $0 % 2 == 1 }

            if self.restauratList.count > 0{
                  for i in 0...self.restauratList.count - 1{
                    if i < self.storeList.count{
                    self.storeRestList?.insert(FFResStoreObject(storeType:"Restaurant", rid: self.restauratList[i].id, rname: self.restauratList[i].name, raddress: self.restauratList[i].address, rphone: self.restauratList[i].phone, rcity: self.restauratList[i].city, rlatitude: self.restauratList[i].latitude, rlongtude: self.restauratList[i].longtude, rcountry: self.restauratList[i].country, rpostalcode: 0, rating: self.restauratList[i].rating, isLiking: self.restauratList[i].isLiking, isVerified: self.restauratList[i].isVerified, image: self.restauratList[i].image, streetAddress: self.restauratList[i].streetAddress, postalCode: self.restauratList[i].postalCode, addressLocality: self.restauratList[i].addressLocality, cityId: self.restauratList[i].cityId, imageSmall: self.restauratList[i].imageSmall, imageMedium: self.restauratList[i].imageMedium, imageLarge: self.restauratList[i].imageLarge), at: odds[i])
                    }else{
                        self.storeRestList?.append(FFResStoreObject(storeType:"Restaurant", rid: self.restauratList[i].id, rname: self.restauratList[i].name, raddress: self.restauratList[i].address, rphone: self.restauratList[i].phone, rcity: self.restauratList[i].city, rlatitude: self.restauratList[i].latitude, rlongtude: self.restauratList[i].longtude, rcountry: self.restauratList[i].country, rpostalcode: 0, rating: self.restauratList[i].rating, isLiking: self.restauratList[i].isLiking, isVerified: self.restauratList[i].isVerified, image: self.restauratList[i].image, streetAddress: self.restauratList[i].streetAddress, postalCode: self.restauratList[i].postalCode, addressLocality: self.restauratList[i].addressLocality, cityId: self.restauratList[i].cityId, imageSmall: self.restauratList[i].imageSmall, imageMedium: self.restauratList[i].imageMedium, imageLarge: self.restauratList[i].imageLarge))

                    }
                }
            }
            self.activityTableView.reloadData()
            self.activityTableView.layoutIfNeeded()
            self.activityTableViewHeightConstraint.constant = self.activityTableView.contentSize.height == 0 ? 90 : self.activityTableView.contentSize.height

        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }

    func customiseNavigationBar(){ // add fav button and share button in navigation bar
        
        
        favBtn = UIButton(type: UIButton.ButtonType.custom)
        favBtn?.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
        favBtn?.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
        favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControl.Event.touchUpInside)
        favBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let favButton = UIBarButtonItem(customView: favBtn!)
        
        
        let shareBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
        shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareButton = UIBarButtonItem(customView: shareBtn)
        
        self.navigationItem.rightBarButtonItems = [ favButton]
    }
    
   
    
    
    func likeRestaurant(){ // like restaurant webservice
        FFManagerClass.likeStore(id: storeID, success: { (response) in
            FFBaseClass.sharedInstance.showAlert(mesage: response.message!, view: self)
            self.favBtn?.isSelected = true
            
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func dislikeRestaurant(){ // dislike restaurant webservice
        
        FFManagerClass.dislikeStore(id: storeID, success: { (response) in
            FFBaseClass.sharedInstance.showAlert(mesage: response.message!, view: self)
            self.favBtn?.isSelected = false
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func populateData(){ // populate fields with restaurant detail webservice response
        
        if restaurantdetail?[0].isVerified == 0 {
            self.isOwner = true
        }else {
            self.isOwner = false
        }
//        setOwnerDeclaration()
        
        
        print(self.storedetail?.id)
        self.title = storedetail?.name
        if let user = FFBaseClass.sharedInstance.getUser() {

            if storedetail?.storeuserid == user.id {
//                        self.emptyMenuBtn.isHidden = false
                        self.clickhereDeclarebtn.setTitle(StringConstants.restaurantstore.UpdateInfo, for: .normal)
                        self.isOwner = true

                    }else{
                
                
                        if storedetail?.storeuserid == nil {
                            if let ownerofstore = user.ownerofstore{
                                if ownerofstore == 0{
                                    self.isOwner = false
                                }else{
                                    self.hideOwnerDeclaration()
                                }
                            }
                        }else{
                            self.hideOwnerDeclaration()
                        }
                    }
//
//                    if let ownerofrestaurant = user.ownerofrestaurant{
//                        if ownerofrestaurant == 0{
//
//                        }else{
//                            self.hideOwnerDeclaration()
//                        }
//                    }
                    
                }
        
        if let phn = storedetail?.phone {
            phoneLbl.text = phn
        }
        
//        if let photo = restaurantdetail?[0].images?.first?.name {
//            let imageUrl:URL = URL(string: photo)!
//            imgView.kf.setImage(with: imageUrl)
//        }
        if let photo = storedetail?.imageMedium {
                   let imageUrl:URL = URL(string: photo)!
                   imgView.kf.setImage(with: imageUrl)
               }
        
        var adresstring = ""
        
        if let adres = storedetail?.address {
            adresstring = adres
        }
        
        adresstring = FFBaseClass.sharedInstance.toHtmlEncodedString(encodedString: adresstring)
        
        if let city = storedetail?.cityName {
            adresstring = "\(adresstring) \n\(city)"
        }
        if let country = storedetail?.countryName {
            adresstring = "\(adresstring), \(country)"
        }
        adrsLbl.text = adresstring
        
        
        if restaurantdetail?[0].isLiking == "0" {
            favBtn?.isSelected = false
        }else {
            favBtn?.isSelected = true
        }
        
        

        getInTouchArray.removeAll()
        openHourArray.removeAll()
        openHourTimeArray.removeAll()
        getInTouchColorArray.removeAll()
        getInTouchColorArray.removeAll()
        //MARK:Sunday Open hours
        var sundayHour: String?
        var mondayHour: String?
        var tuesdayHour: String?
        var wednesdayHour: String?
        var thursdayHour: String?
        var fridayHour: String?
        var saturdayHour: String?




        

        
        
        if let sunday = storedetail?.displayHoursSunday {
                        self.openHourArray.append(StringConstants.restaurantstore.Sunday)
                        if !sunday.isEmpty{
                            if sunday == "-1"{
                                self.openHourTimeArray.append(StringConstants.restaurantstore.closed)
                            }else{
                            self.openHourTimeArray.append(sunday)
                            }
                        }else{
                            
                            if let morsunday = storedetail?.morningdisplayHoursSunday {
                                if !morsunday.isEmpty{
                                    if morsunday == "-1"{
                                        sundayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                    }else{
                                    sundayHour = "\(StringConstants.restaurantstore.Inthemorning): \(morsunday)"
                                    }
                                }else{
                                    
                                    sundayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                }
                            }
                                    if let evsunday = storedetail?.eveningdisplayHoursSunday {
                                        if !evsunday.isEmpty{
                                            if evsunday == "-1"{
                                                self.openHourTimeArray.append("\(sundayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                            }else{
                                            self.openHourTimeArray.append("\(sundayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evsunday)")
                                        }
                                        }
                                        else{
                                            if !(sundayHour ?? "").isEmpty{
    //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                                self.openHourTimeArray.append("\(sundayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                            }
                                        }
                                    }
                        }
                    }
            
            if self.openHourTimeArray.count == 0{
                self.openHourTimeArray.append(StringConstants.restaurantstore.nodataowner)
            }
            
            
            //MARK:Monday Open hours
            if let monday = storedetail?.displayHoursMonday {
                self.openHourArray.append(StringConstants.restaurantstore.Monday)
                        if !monday.isEmpty{
                            if monday == "-1"{
                                self.openHourTimeArray.append(StringConstants.restaurantstore.closed)
                            }else{
                            self.openHourTimeArray.append(monday)
                            }
                        }else{
                            
                            if let mormonday = storedetail?.morningdisplayHoursMonday {
                                               if !mormonday.isEmpty{
                                                if mormonday == "-1"{
                                                 mondayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                                }else{
                                                mondayHour = "\(StringConstants.restaurantstore.Inthemorning): \(mormonday)"
                                                }
                                               }else{
                                                
                                                mondayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                            }
                                           }
                            if let evmonday = storedetail?.eveningdisplayHoursMonday {
                                               if !evmonday.isEmpty{
                                                if evmonday == "-1"{
                                                 self.openHourTimeArray.append("\(mondayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                                }else{
                                                self.openHourTimeArray.append("\(mondayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evmonday)")
                                                }
                                               }
                                            else{
                                                if !(mondayHour ?? "").isEmpty{
        //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                                    self.openHourTimeArray.append("\(mondayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                                }
                                            }
                                           }
                            
                        }
                    }
            
         
            if self.openHourTimeArray.count == 1{
                self.openHourTimeArray.append(StringConstants.restaurantstore.nodataowner)
            }
            
            //MARK:Tuesday Open hours

                    if let tuesday = storedetail?.displayHoursTuesday {
                        self.openHourArray.append("\(StringConstants.restaurantstore.Tuesday)")
                              if !tuesday.isEmpty{
                                if tuesday == "-1"{
                                    self.openHourTimeArray.append("\(StringConstants.restaurantstore.closed)")
                                }else{
                                self.openHourTimeArray.append(tuesday)
                                }
                              }else{
                                if let mortuesday = storedetail?.morningdisplayHoursTuesday {
                                    if !mortuesday.isEmpty{
                                     if mortuesday == "-1"{
                                        tuesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                     }else{
                                        tuesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(mortuesday)"
                                     }
                                    }else{
                                     
                                        tuesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                 }
                                }
                                if let evtuesday = storedetail?.eveningdisplayHoursTuesday {
                                    if !evtuesday.isEmpty{
                                     if evtuesday == "-1"{
                                      self.openHourTimeArray.append("\(tuesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                     }else{
                                     self.openHourTimeArray.append("\(tuesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evtuesday)")
                                     }
                                    }
                                 else{
                                     if !(tuesdayHour ?? "").isEmpty{
    //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                         self.openHourTimeArray.append("\(tuesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                     }
                                 }
                                }

                              }
                          }
            if self.openHourTimeArray.count == 2{
                      self.openHourTimeArray.append("\(StringConstants.restaurantstore.nodataowner)")
                  }
            //MARK:Wednesday Open hours

                    if let wednesday = storedetail?.displayHoursWednesday {
                        self.openHourArray.append("\(StringConstants.restaurantstore.Wednesday)")
                                   if !wednesday.isEmpty{
                                       if wednesday == "-1"{
                                           self.openHourTimeArray.append("\(StringConstants.restaurantstore.closed)")
                                       }else{
                                       self.openHourTimeArray.append(wednesday)
                                       }
                                   }else{
                                    if let morwednesday = storedetail?.morningdisplayHoursWednesday {
                                        if !morwednesday.isEmpty{
                                         if morwednesday == "-1"{
                                            wednesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                         }else{
                                            wednesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(morwednesday)"
                                         }
                                        }else{
                                         
                                            wednesdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                     }
                                    }
                                    if let evwednesday = storedetail?.eveningdisplayHoursWednesday {
                                        if !evwednesday.isEmpty{
                                         if evwednesday == "-1"{
                                          self.openHourTimeArray.append("\(wednesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                         }else{
                                         self.openHourTimeArray.append("\(wednesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evwednesday)")
                                         }
                                        }
                                     else{
                                         if !(wednesdayHour ?? "").isEmpty{
        //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                             self.openHourTimeArray.append("\(wednesdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                         }
                                     }
                                    }
                                    
                                   }
                               }
            
      
            if self.openHourTimeArray.count == 3{
                        self.openHourTimeArray.append("\(StringConstants.restaurantstore.nodataowner)")
                    }
            //MARK:Thursday Open hours


                    if let thursday = storedetail?.displayHoursThursday {
                        self.openHourArray.append("\(StringConstants.restaurantstore.Thursday)")
                                    if !thursday.isEmpty{
                                        if thursday == "-1"{
                                            self.openHourTimeArray.append("\(StringConstants.restaurantstore.closed)")
                                        }else{
                                        self.openHourTimeArray.append(thursday)
                                        }
                                    }else{
                                        if let morthursday = storedetail?.morningdisplayHoursThursday {
                                            if !morthursday.isEmpty{
                                             if morthursday == "-1"{
                                                thursdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                             }else{
                                                thursdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(morthursday)"
                                             }
                                            }else{
                                             
                                                thursdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                         }
                                        }
                                        
                                        if let evthursday = storedetail?.eveningdisplayHoursThursday {
                                            if !evthursday.isEmpty{
                                             if evthursday == "-1"{
                                              self.openHourTimeArray.append("\(thursdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                             }else{
                                             self.openHourTimeArray.append("\(thursdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evthursday)")
                                             }
                                            }
                                         else{
                                             if !(thursdayHour ?? "").isEmpty{
            //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                                 self.openHourTimeArray.append("\(thursdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                             }
                                         }
                                        }

                                        
                                    }
                                }
            
            
            if self.openHourTimeArray.count == 4{
                self.openHourTimeArray.append("\(StringConstants.restaurantstore.nodataowner)")
            }
            
            //MARK:Friday Open hours

            
                    if let friday = storedetail?.displayHoursFriday {
                        self.openHourArray.append("\(StringConstants.restaurantstore.Friday)")
                                    if !friday.isEmpty{
                                        if friday == "-1"{
                                            self.openHourTimeArray.append("\(StringConstants.restaurantstore.closed)")
                                        }else{
                                        self.openHourTimeArray.append(friday)
                                        }
                                    }else{
                                        
                                        if let morfriday = storedetail?.morningdisplayHoursFriday {
                                            if !morfriday.isEmpty{
                                             if morfriday == "-1"{
                                                fridayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                             }else{
                                                fridayHour = "\(StringConstants.restaurantstore.Inthemorning): \(morfriday)"
                                             }
                                            }else{
                                             
                                                fridayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                                         }
                                        }
                                        if let evfriday = storedetail?.eveningdisplayHoursFriday {
                                            if !evfriday.isEmpty{
                                             if evfriday == "-1"{
                                              self.openHourTimeArray.append("\(fridayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                                             }else{
                                             self.openHourTimeArray.append("\(fridayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evfriday)")
                                             }
                                            }
                                         else{
                                             if !(fridayHour ?? "").isEmpty{
            //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                                                 self.openHourTimeArray.append("\(fridayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                                             }
                                         }
                                        }
                                        
                                    }
                                }
            
            if self.openHourTimeArray.count == 5{
                       self.openHourTimeArray.append("\(StringConstants.restaurantstore.nodataowner)")
                   }
            
            //MARK:Saturday Open hours

                    if let saturday = storedetail?.displayHoursSaturday {
                        self.openHourArray.append("\(StringConstants.restaurantstore.Saturday)")
                        if !saturday.isEmpty{
                            if saturday == "-1"{
                                self.openHourTimeArray.append("\(StringConstants.restaurantstore.closed)")
                            }else{
                            self.openHourTimeArray.append(saturday)
                            }
                        }else{
                            
                            if let morsaturday = storedetail?.morningdisplayHoursSaturday {
                                if !morsaturday.isEmpty{
                                 if morsaturday == "-1"{
                                    saturdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.closed)"
                                 }else{
                                    saturdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(morsaturday)"
                                 }
                                }else{
                                 
                                    saturdayHour = "\(StringConstants.restaurantstore.Inthemorning): \(StringConstants.restaurantstore.nodataowner)"
                             }
                            }
                    if let evsaturday = storedetail?.eveningdisplayHoursSaturday {
                        if !evsaturday.isEmpty{
                         if evsaturday == "-1"{
                          self.openHourTimeArray.append("\(saturdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.closed)")
                         }else{
                         self.openHourTimeArray.append("\(saturdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(evsaturday)")
                         }
                        }
                     else{
                         if !(saturdayHour ?? "").isEmpty{
    //                                            self.openHourTimeArray.append("\(sundayHour ?? "")")
                             self.openHourTimeArray.append("\(saturdayHour ?? ""), \(StringConstants.restaurantstore.Intheevening): \(StringConstants.restaurantstore.nodataowner)")

                         }
                     }
                    }

                            
                        }
                    }
            if self.openHourTimeArray.count == 6{
                             self.openHourTimeArray.append("\(StringConstants.restaurantstore.nodataowner)")
                         }



        //MARK:Get In  Touch

            if let phn = storedetail?.phone {
                getInTouchArray.append("\(StringConstants.restaurantstore.Callus)")
                getInTouchColorArray.append(#colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1))
            }else{
                getInTouchArray.append("\(StringConstants.restaurantstore.nodataowner)")
                getInTouchColorArray.append(UIColor.red)

            }
        
        if let email = storedetail?.emailStore {
            
            getInTouchArray.append("\(StringConstants.restaurantstore.Sendemail)")
            getInTouchColorArray.append(#colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1))
        }else{
            getInTouchArray.append("\(StringConstants.restaurantstore.emailnotgivenbyowner)")
            getInTouchColorArray.append(UIColor.red)
            
        }
        
        if let website = storedetail?.website {
                   
                   getInTouchArray.append("\(StringConstants.restaurantstore.Website)")
                   getInTouchColorArray.append(#colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1))
               }else{
                   getInTouchArray.append("\(StringConstants.restaurantstore.websitenotgivenbyowner)")
                   getInTouchColorArray.append(UIColor.red)
                   
               }
        
        if let facebook = storedetail?.facebook {
                         
                         getInTouchArray.append("\(StringConstants.restaurantstore.Facebook)")
                         getInTouchColorArray.append(#colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1))
                     }else{
                         getInTouchArray.append("\(StringConstants.restaurantstore.facebooknotgivenbyowner)")
                         getInTouchColorArray.append(UIColor.red)
                         
                     }
        
        if self.openHourArray.count == 0{
            self.openHourArray.append("\(StringConstants.restaurantstore.nodataowner)")
              }
        self.openHourTableView.reloadData()
        self.getInTouchTableView.reloadData()

        self.openHourTableView.layoutIfNeeded()
//        self.openHourTableViewHeightConstraint.constant = self.openHourTableView.contentSize.height == 0 ? 80 : self.openHourTableView.contentSize.height
        self.openHourTableViewHeightConstraint.constant = 70 * CGFloat(self.openHourArray.count)
        self.getInTouchTableView.layoutIfNeeded()
//        self.getInToucTableViewHeightConstraint.constant = self.getInTouchTableView.contentSize.height == 0 ? 80 : self.getInTouchTableView.contentSize.height
        self.getInToucTableViewHeightConstraint.constant = 60 * CGFloat(self.getInTouchArray.count)


    }
    
  
    
    func hideThreeViews(){
        activityView.isHidden = true
        recipeView.isHidden = true
        infoView.isHidden = true
        
        activityBtn.isSelected = false
        infoBtn.isSelected = false
        recipeBtn.isSelected = false

        
    }
    
    //MARK:- TableView Datasource and delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == recipeTableView {
            if self.storeProductCategoriesList.count > 0 {
                self.recipeTableView.backgroundView = nil
                return self.storeProductCategoriesList.count
            }else {
                let emptyView = UIView()
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.recipeTableView.bounds.size.width, height: 60))
                emptyLabel.text = "\(StringConstants.restaurantstore.noproducts)"
                emptyLabel.font = UIFont.systemFont(ofSize: 15)
                emptyLabel.textAlignment = .center
                emptyLabel.textColor = UIColor.lightGray
                emptyLabel.numberOfLines = 2
                emptyView.addSubview(emptyLabel)
                let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                imagView.image = #imageLiteral(resourceName: "emptyRecipe")
                imagView.contentMode = UIView.ContentMode.scaleAspectFit
                imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 50)
                emptyView.addSubview(imagView)
                
                self.recipeTableView.backgroundView = emptyView
                return 1
            }
            
        }else if tableView == openHourTableView {
            
            return 1
        }else if tableView == getInTouchTableView {
            return 1
        }
            else if tableView == reviewTableView {
                return 1
            }
        else if tableView == activityTableView {
//            if storeList.count > 0 {
                self.activityTableView.backgroundView = nil
                return 2
        }else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recipeTableView {
            if self.storeProductCategoriesList.count > 0 {

                return (self.storeProductCategoriesList[section].count ?? 0) + 1
            }else{
                return 0
            }
        }
        else if tableView == openHourTableView {
            
            return openHourArray.count
        }else if tableView == getInTouchTableView {
            return getInTouchArray.count
        }

        else if tableView == activityTableView  {
            if section == 0{
                return self.storeRestList?.count ?? 0
            }else{
                return 0
            }
        }else if tableView == reviewTableView{
            return reviewList.count
        }
        else{
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == activityTableView {
            
            var returnCell: UITableViewCell = UITableViewCell()
            if indexPath.section == 0{
                
                                           let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell")
                                           let namelbl = cell?.viewWithTag(100) as! UILabel
                                           let spllbl = cell?.viewWithTag(200) as! UILabel
                                           let placelbl = cell?.viewWithTag(300) as! UILabel
                                           let imgView = cell?.viewWithTag(400) as! UIImageView
                //                        spllbl.text = storeTypeName
                
                let storeType = self.storeRestList?[indexPath.row].storeType
                if storeType == "Store"{
                    namelbl.text = toHtmlEncodedString(encodedString:  self.storeRestList?[indexPath.row].sname ?? "")
                                           var  place = toHtmlEncodedString(encodedString:  self.storeRestList?[indexPath.row].saddress ?? "")
                                           let city = self.storeRestList?[indexPath.row].scityName?.capitalizingFirstLetter()  ?? ""
                                           let country = self.storeRestList?[indexPath.row].scountryName?.capitalizingFirstLetter() ?? ""
                                           let postal = self.storeRestList?[indexPath.row].spostalCode ?? ""
//                                           place =  place + "\n" + city + ", " + country + " - " + postal
                                           place =  place + "\n" + postal + " " + city + ", " + country

                                           placelbl.text = place
                    spllbl.text = self.storeRestList?[indexPath.row].storeTypeName?.capitalizingFirstLetter()
                    if let image = self.storeRestList?[indexPath.row].imageSmall {
                        if let imageUrl:URL = URL(string: (image )){
                        imgView.kf.setImage(with: imageUrl.standardizedFileURL)
                        }
                    }

                }else{
                    
                    namelbl.text = toHtmlEncodedString(encodedString:  self.storeRestList?[indexPath.row].rname ?? "")
                                           var  place = toHtmlEncodedString(encodedString:  self.storeRestList?[indexPath.row].streetAddress ?? "")
                                           let city = self.storeRestList?[indexPath.row].addressLocality?.capitalizingFirstLetter()  ?? ""
                                           let country = self.storeRestList?[indexPath.row].rcountry?.capitalizingFirstLetter() ?? ""
                                           let postal = self.storeRestList?[indexPath.row].postalCode ?? ""
                                           //place =  place + "\n" + city + ", " + country + " - " + postal
                                            place =  place + "\n" + postal + " " + city + ", " + country

                                           placelbl.text = place
                    spllbl.text = storeType
                    if let image = self.storeRestList?[indexPath.row].imageSmall {
                        if let imageUrl:URL = URL(string: (image )){
                        imgView.kf.setImage(with: imageUrl.standardizedFileURL)
                        }
                    }

                }

                returnCell = cell!

            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell")
                let namelbl = cell?.viewWithTag(100) as! UILabel
                let spllbl = cell?.viewWithTag(200) as! UILabel
                let placelbl = cell?.viewWithTag(300) as! UILabel
                let imgView = cell?.viewWithTag(400) as! UIImageView

                namelbl.text = self.restauratList[indexPath.row].name
                
                let splarray = restauratList[indexPath.row].specialities ?? []
                var splnamearray = [String]()
                for item in splarray {
                    splnamearray.append(item.name!)
                }
                
                let splstring = splnamearray.joined(separator: ",")
                spllbl.text = toHtmlEncodedString(encodedString: splstring)
                
                
                var  place = toHtmlEncodedString(encodedString:  self.restauratList[indexPath.row].streetAddress!)
                
                let city = restauratList[indexPath.row].addressLocality  ?? ""
                let country = restauratList[indexPath.row].postalCode ?? ""
                
                place =  place + "\n" + city + "- " + country
                placelbl.text = place
                
                
                let imageUrl:URL = URL(string: (self.restauratList[indexPath.row].image)!)!
                imgView.kf.setImage(with: imageUrl)


                returnCell = cell!

            }
            
            return returnCell
        }else if tableView == openHourTableView {
                            
                                           let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell")
                                           let dayLbl = cell?.viewWithTag(100) as! UILabel
                                           let timelbl = cell?.viewWithTag(200) as! UILabel
            let cellView = cell?.viewWithTag(300)!

            
               let editHourButton = cell?.viewWithTag(500) as? UIButton
                        editHourButton?.tag = indexPath.row
                        editHourButton?.addTarget(self, action: #selector(editHourButtonAction), for: .touchUpInside)

                        if self.isOwner == true{
                            editHourButton?.isHidden = false
                        }
            //            if self.openHourArray[indexPath.row] == "no data given by the owner"{
            //                cell?.textLabel?.text = "no data given by the owner"
            //                cell?.textLabel?.textColor = UIColor.red
            //                cellView?.backgroundColor = UIColor.clear
            //            }else{
                            cellView?.layer.cornerRadius = 10
                            cellView?.layer.shadowOpacity = 1
                            cellView?.layer.shadowRadius = 2
                            cellView?.layer.shadowColor = UIColor.gray.cgColor
                            cellView?.layer.shadowOffset = CGSize(width: 3, height: 3)
                            dayLbl.text = openHourArray[indexPath.row]
                            timelbl.text = openHourTimeArray[indexPath.row]
                       // }
                        if self.openHourTimeArray[indexPath.row] == "\(StringConstants.restaurantstore.nodataowner)" || self.openHourTimeArray[indexPath.row] == "\(StringConstants.restaurantstore.closed)"{
                            timelbl.textColor = UIColor.red
                        }else{
                            timelbl.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                        }
            return cell!
        }
        else if tableView == getInTouchTableView {
                            
                                           let cell = tableView.dequeueReusableCell(withIdentifier: "GetInTouchCell")
                                           let touchButton = cell?.viewWithTag(100) as? UIButton
                                           let itemLbl = cell?.viewWithTag(200) as! UILabel
            let clickButton = cell?.viewWithTag(400) as? UIButton

            let editGetInTouchButton = cell?.viewWithTag(500) as? UIButton
            editGetInTouchButton?.tag = indexPath.row
            editGetInTouchButton?.addTarget(self, action: #selector(editGetInTouchButtonAction), for: .touchUpInside)
            if self.isOwner == true{
                           editGetInTouchButton?.isHidden = false
                       }

            let cellView = cell?.viewWithTag(300)!
            cellView?.layer.cornerRadius = 10
            cellView?.layer.shadowOpacity = 1
            cellView?.layer.shadowRadius = 2
            cellView?.layer.shadowColor = UIColor.gray.cgColor
            cellView?.layer.shadowOffset = CGSize(width: 3, height: 3)
            
            
            touchButton?.setBackgroundImage(getInTouchImageArray[indexPath.row], for: .normal)
            clickButton?.tag = indexPath.row
            clickButton?.addTarget(self, action: #selector(getInTouchAction), for: .touchUpInside)
            itemLbl.text = getInTouchArray[indexPath.row]
            itemLbl.textColor = getInTouchColorArray[indexPath.row]
            
            
            return cell!
        }else if tableView == reviewTableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! FFReviewTableViewCell
                cell.reviewObject = reviewList[indexPath.row]
                cell.refreshCell()
                return cell
            }
        else {
            var returnCell: UITableViewCell = UITableViewCell()
            
            if indexPath.row == 0 {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderCell") as! FFMenuTableViewCell
                cell.headerLabel.text = self.storeProductCategoriesList[indexPath.section].name
                cell.expandButton.tag = indexPath.section
                cell.expandButton.addTarget(self, action: #selector(expandButton), for: .touchUpInside)
                if self.storeProductCategoriesList[indexPath.section].products?.count ?? 0 < 4{
                    cell.expandButton.setBackgroundImage(#imageLiteral(resourceName: "minus"), for: .normal)

                }else{
                    
                    if self.storeProductCategoriesList[indexPath.section].count ?? 0 < 4{
                        cell.expandButton.setBackgroundImage(#imageLiteral(resourceName: "add"), for: .normal)

                    }else{
                        cell.expandButton.setBackgroundImage(#imageLiteral(resourceName: "minus"), for: .normal)

                    }

                }

                returnCell = cell
            }else{
                            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDataCell") as! FFMenuTableViewCell
                cell.menuLabel.text = self.storeProductCategoriesList[indexPath.section].products?[indexPath.row - 1].name
                cell.currencyLabel.text = "\(self.storeProductCategoriesList[indexPath.section].products?[indexPath.row - 1].price ?? "")\(self.storeProductCategoriesList[indexPath.section].products?[indexPath.row - 1].currency?.symbol ?? "")"
                returnCell = cell
                
            }
            

            return returnCell
            
        }
    }
    
    @objc func expandButton(_ sender: UIButton){
        let cell: FFMenuTableViewCell = self.recipeTableView.cellForRow(at: IndexPath(row: 0, section: sender.tag)) as! FFMenuTableViewCell
        if self.storeProductCategoriesList[sender.tag].products?.count ?? 0 < 4{
            return
        }
        if cell.expandButton.currentBackgroundImage == UIImage(imageLiteralResourceName: "add"){
//            cell.expandButton.setBackgroundImage(#imageLiteral(resourceName: "minus"), for: .normal)
            self.storeProductCategoriesList[sender.tag].count = self.storeProductCategoriesList[sender.tag].products?.count

            
        }else{
//            cell.expandButton.setBackgroundImage(#imageLiteral(resourceName: "add"), for: .normal)
            self.storeProductCategoriesList[sender.tag].count = 3
        }
        self.recipeTableView.reloadData()
        self.recipeTableView.layoutIfNeeded()
        self.recipeTableViewHeightConstraint.constant = self.recipeTableView.contentSize.height == 0 ? 200 : self.recipeTableView.contentSize.height

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == activityTableView {
            if section == 0{
                return "Stores"
            }else{
                return "Restaurants"
            }
            
        }else{
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == activityTableView {
            if section == 0{
                if storeList.count > 0{
                    return 0
                }else{
                    return 0
                }
            }else{
                if restauratList.count > 0{
                                  return 0
                              }else{
                                  return 0
                              }
            }
        }else{
            return 0

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == activityTableView {
            if indexPath.section == 0{
                let storeType = self.storeRestList?[indexPath.row].storeType
                if storeType == "Store"{
                               let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetailVC") as! FFStoreDetailViewController
                               vc.storeID = self.storeRestList?[indexPath.row].sid
                            vc.cityId = self.storeRestList?[indexPath.row].scityId

                               self.navigationController?.pushViewController(vc, animated: true)

                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! FFRestaurantDetailViewController
                    vc.restaurantID = self.storeRestList?[indexPath.row].rid
                    vc.cityId = self.storeRestList?[indexPath.row].cityId

//                    vc.isFav = isFavList
                    self.navigationController?.pushViewController(vc, animated: true)

                    
                }
            }
        }
        if tableView == recipeTableView {
            if indexPath.row > 0{
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFStoreProductDetailVC") as! FFStoreProductDetailVC
               vc.storeProductObject = self.storeProductCategoriesList[indexPath.section].products?[indexPath.row - 1]
            vc.storeName = storedetail?.name
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    @objc func editHourButtonAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFUpdateHoursVC") as! FFUpdateHoursViewController
        vc.day = openHourArray[sender.tag]
        vc.selectedDay = sender.tag
        vc.storeID = storeID
        vc.isStore = 1

        if sender.tag == 0{
        vc.allDayDisplay = storedetail?.displayHoursSunday
            vc.morningDisplay = storedetail?.morningdisplayHoursSunday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursSunday
        }else if sender.tag == 1{
        vc.allDayDisplay = storedetail?.displayHoursMonday
            vc.morningDisplay = storedetail?.morningdisplayHoursMonday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursMonday
        }else if sender.tag == 2{
        vc.allDayDisplay = storedetail?.displayHoursTuesday
            vc.morningDisplay = storedetail?.morningdisplayHoursTuesday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursTuesday
        }else if sender.tag == 3{
        vc.allDayDisplay = storedetail?.displayHoursWednesday
            vc.morningDisplay = storedetail?.morningdisplayHoursWednesday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursWednesday
        }else if sender.tag == 4{
        vc.allDayDisplay = storedetail?.displayHoursThursday
            vc.morningDisplay = storedetail?.morningdisplayHoursThursday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursSaturday
        }else if sender.tag == 5{
        vc.allDayDisplay = storedetail?.displayHoursFriday
            vc.morningDisplay = storedetail?.morningdisplayHoursFriday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursFriday
        }else if sender.tag == 6{
        vc.allDayDisplay = storedetail?.displayHoursSaturday
            vc.morningDisplay = storedetail?.morningdisplayHoursSaturday
            vc.eveningDisplay = storedetail?.eveningdisplayHoursSaturday
        }
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)

    }
    
    @objc func editGetInTouchButtonAction(_ sender: UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFUpdateGetInTouchVC") as! FFUpdateGetInTouchViewController
        vc.storeID = storeID
        vc.isStore = 1
        if sender.tag == 0{
        vc.fromWhere = "phone"
            vc.textData = phoneLbl.text
        }else if sender.tag == 1{
            vc.textData = storedetail?.emailStore
            vc.fromWhere = "email"
        }else if sender.tag == 2{
            vc.textData = storedetail?.website
            vc.fromWhere = "website"
        }else if sender.tag == 3{
            vc.fromWhere = "facebook"
            vc.textData = storedetail?.facebook
        }else if sender.tag == 4{
            vc.fromWhere = "reach"
        }else{
            
        }
        vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(vc, animated: true, completion: nil)
    }

    
    @objc func getInTouchAction(_ sender: UIButton){
        if sender.tag == 0{
            if let url = URL(string: "tel://\(phoneLbl.text ?? "")"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }

        }else if sender.tag == 1{
            
            if let email = storedetail?.email{
            
            if let url = URL(string: "mailto:\(email)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
        }
            
        }else if sender.tag == 2{
            if let website = storedetail?.website{

            guard let url = URL(string: website) else { return }
            if #available(iOS 10.0, *) {
              UIApplication.shared.open(url)
            } else {
              UIApplication.shared.openURL(url)
            }
            }
        }else if sender.tag == 3{
            if let facebook = storedetail?.facebook{

            guard let url = URL(string: facebook) else { return }
            if #available(iOS 10.0, *) {
              UIApplication.shared.open(url)
            } else {
              UIApplication.shared.openURL(url)
            }
            }
        }else if sender.tag == 4{
            
        }
        
    }
    
    //MARK:- Custom Functions
    
    func toHtmlEncodedString(encodedString:String) -> String { // decode html string
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- Button Actions
    
    @IBAction func infoBtnTapped(_ sender : Any){ // info buton action
        hideThreeViews()
        
        infoView.isHidden = false
        infoBtn.isSelected = true
        
    }
    
    @IBAction func recipeBtnTapped(_ sender : Any){ // recipe buton action
        hideThreeViews()
        recipeBtn.isSelected = true
        recipeView.isHidden = false
        
    }

    
    @IBAction func activityBtnTapped(_ sender : Any){ // activity buton action
        hideThreeViews()
        activityView.isHidden = false
        activityBtn.isSelected = true
        activityTableView.reloadData()
        activityTableView.layoutIfNeeded()
        activityTableViewHeightConstraint.constant = activityTableView.contentSize.height == 0 ? 90 : activityTableView.contentSize.height
        
    }
    
    @IBAction func storeSubscribeBtnPressed(_ sender : Any){ // go to subcribe store screen on suscribe restaurant button action
        
        if self.clickhereDeclarebtn.currentTitle == "Update Info"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFDeclareOwnerVC") as! FFDeclareOwnerRestaurantViewController
            vc.storeID = self.storedetail?.id
            vc.isStore = 1

            vc.storedetail = storedetail
            self.navigationController?.pushViewController(vc, animated: true)

        }
        else{
            presentAlertWithTitle(title: "\(StringConstants.restaurantstore.Ownerconfirmation)", message: "\(StringConstants.restaurantstore.areyouowner)", options: "\(StringConstants.restaurantstore.Yes)", "\(StringConstants.restaurantstore.No)") { (option) in
                   print("option: \(option)")
                   switch(option) {
                       case 0:
                           print("option one")
                           self.addOwnerDetailAPI(isProfessional: "")
                           break
                       case 1:
                           print("option two")
                       default:
                           break
                   }
               }
            }
        
    }
    
    func addOwnerDetailAPI(isProfessional: String?){
        //addOwnerDetails
        if let storeID = self.storeID {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.addStoreOwnerDetails(isProfessional:isProfessional, storeId: "\(storeID)", success: { (response) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                if let message = response.message{
                    if message == "USER_NON_PROFESSIONAL"{
                        self.presentAlertWithTitle(title: "\(StringConstants.restaurantstore.Confirmation)", message: "\(StringConstants.restaurantstore.Pleaseconfirmthatprofessional)", options: "\(StringConstants.restaurantstore.Iconfirm)", "\(StringConstants.restaurantstore.Later)") { (option) in
                            print("option: \(option)")
                            switch(option) {
                            case 0:
                                print("option one")
                                self.addOwnerDetailAPI(isProfessional: "1")
                                break
                            case 1:
                                print("option two")
                            default:
                                break
                            }
                        }
                    }else if message == "ERROR_ALREADY_EXIST"{
                        self.clickhereDeclarebtn.setTitle("\(StringConstants.restaurantstore.UpdateInfo)", for: .normal)
                    }
                    
                }
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
        
    }
    
    @IBAction func restaurantSubscribeCloseTapped1(_ sender : UIButton){
        
        let sv = sender.superview
        sv?.isHidden = true
        
    }
    @IBAction func restaurantSubscribeCloseTapped2(_ sender : UIButton){
        
        let sv = sender.superview
        sv?.isHidden = true
        
    }
    @IBAction func restaurantSubscribeCloseTapped3(_ sender : UIButton){
        
        let sv = sender.superview
        sv?.isHidden = true
        
    }
    
    @objc func favBtnTapped(){ // favorite button action -  to like/dislike restaurants
        
        if let _ = FFBaseClass.sharedInstance.getUser() {
            if favBtn?.isSelected == true {
                dislikeRestaurant()
            }else {
                likeRestaurant()
                
            }
        }else {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
            loginVC.isFirstLaunch = false
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @objc func shareRecipeBtnTapped(){
        
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
            reviewTableHeightConstraint.constant = 0
            emptyReviewHeightConstraint.constant = 0
            addReviewHeightConstraint.constant = 175.0
         }else {
     
             callAddReviewAPI()
    
         }
         
     }
    
    @IBAction func loadMoreReviewsBtnTapped(_ sender :Any ){ // see ore button ction
        print("load more tapped")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewListVC") as! FFReviewListViewController
        vc.fromWere = "store"
        vc.reviewTitle = storedetail?.name
        vc.storeId = self.storeID
        vc.totalCount = self.maxResults
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func callAddReviewAPI(){ // addreview webservice
            
            if validateReview() {
                
                if let storeID = self.storeID {
                    FFLoaderView.showInView(view: self.view)
                    FFManagerClass.postStoreReview(storeID: "\(storeID)", review: self.reviewTextView.text, rate: "\(self.reviewRatingView.rating)", success: { (response) in
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
                        
                        self.reviewCountLabel.text = "\(self.maxResults) \(StringConstants.restaurantstore.reviewsonthisstore)"
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
    
    func validateReview() -> Bool { // review alidation
        
        if  self.reviewTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            return false
        }
        
        if reviewRatingView.rating < 1 {
            return false
        }
        
        return true
    }
    
    @objc func showOrHideReviews(){ // show reveiew list else show empty view
//        reviewTableHeightConstraint.constant = 0
//        emptyReviewHeightConstraint.constant = 0
//        addReviewHeightConstraint.constant = 175.0

        addReviewView.isHidden = true
        addReviewHeightConstraint.constant = 0
        if reviewList.count > 0 {
            reviewTableView.isHidden = false
            emptyReviewView.isHidden = true
            emptyReviewHeightConstraint.constant = 0

//            self.reviewTableView.reloadData()
            self.reviewTableView.layoutIfNeeded()
//            self.reviewTableView.reloadData()

//            self.reviewTableHeightConstraint.constant = self.reviewTableView.contentSize.height * CGFloat(self.reviewList.count)
            if CGFloat(107 * reviewList.count) == 214{
                self.reviewTableHeightConstraint.constant = 220

            }else{
            self.reviewTableHeightConstraint.constant = CGFloat(107 * reviewList.count)
            }

        }else{
            reviewTableView.isHidden = true
            emptyReviewView.isHidden = false
            reviewTableHeightConstraint.constant = 0
            emptyReviewHeightConstraint.constant = 155.0

        }
        
    }
    
    //MARK:- API calls
    
    func loadReviews(){ // recipe reviews webservice
        if let storeID = storeID {
            let stringId = "\(storeID)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getStoreReviewList(storeId: stringId, maxResults: "5", success: { (response:FFBaseResponseModel) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.reviewList = response.reviewList ?? []
                self.maxResults = "\(response.totalCountInt ?? 0)"
                self.reviewTableView.reloadData()
                
                if self.reviewList.count < 4{
                    self.loadMoreBtn.isHidden = true
                }
                
                self.reviewCountLabel.text = "\(self.maxResults) \(StringConstants.restaurantstore.reviewsonthisstore)"
                let reviewCountString = "\(self.reviewList.count)"
                if reviewCountString == self.maxResults {
                    self.loadMoreBtn.isHidden = true
                }else {
                    self.loadMoreBtn.isHidden = false
                }
                
//                self.reviewTableView.layoutIfNeeded()
//                self.reviewTableHeightConstraint.constant = self.reviewTableView.contentSize.height * CGFloat(self.reviewList.count)
//                self.reviewTableHeightConstraint.constant = self.reviewTableView.contentSize.height

                self.showOrHideReviews()

            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                self.loadMoreBtn.isHidden = true

            }
            
        }
    }
    
    @IBAction func backToReviewsBtnTapped(_ sender :Any){
         showOrHideReviews()
     }
     
    
}
extension Array {
  mutating func remove(at indexes: [Int]) {
    for index in indexes.sorted(by: >) {
      remove(at: index)
    }
  }
}
