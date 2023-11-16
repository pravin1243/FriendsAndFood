//
//  FFTabViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import AZTabBar
import SideMenu

protocol TabbarDelegate: AnyObject {
    func showRightNavigationItem()
}
class CustomNavigationBar: UINavigationBar {
    private var backgroundImage: UIImage?

    init(backgroundImage: UIImage) {
        self.backgroundImage = backgroundImage
        super.init(frame: .zero)
        self.isTranslucent = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}


class FFTabViewController: UIViewController {
    weak var delegate: TabbarDelegate?
   var tabController : AZTabBarController?
    var  isRightNavigation: Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "navigationBarBg")
        let customNavBar = CustomNavigationBar(backgroundImage: backgroundImage!)
        self.navigationController?.setValue(customNavBar, forKey: "navigationBar")
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showLeftMenu))
        self.navigationItem.leftBarButtonItem = menuBtn
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.action = #selector(showLeftMenu)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if let usr = FFBaseClass.sharedInstance.getUser(){
            if usr.isProfessional == 1{
                if usr.isRestaurant == 1{
                    setProfessionalbottomTab(isStore: 0)
                    
                }
                else if usr.isStore == 1{
                    setProfessionalbottomTab(isStore: 1)
                    
                }else{
                    setUnProfessionalbottomTab()
                    
                }
            }else{
                setUnProfessionalbottomTab()
            }
            
        }else{
            
            setUnProfessionalbottomTab()
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func showLeftMenu(){
        performSegue(withIdentifier: "hello", sender: self)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
//        self.navigationController?.pushViewController(vc, animated: true)

//        let menu = SideMenuNavigationController(rootViewController: YourViewController)
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
//         let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
//        present(menu, animated: true, completion: nil)
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! FFMenuViewController
//
//        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: vc)
//        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController


    }
    
    
    func setUnProfessionalbottomTab(){ // customise Non Professional bottom tab
        var icons = [UIImage]()
        icons.append(#imageLiteral(resourceName: "recipeList"))
        icons.append(#imageLiteral(resourceName: "FavRestaurant"))
        icons.append(#imageLiteral(resourceName: "FavRestaurant"))
        icons.append(#imageLiteral(resourceName: "friends"))
        
        var selectedIcons = [UIImage]()
        selectedIcons.append(#imageLiteral(resourceName: "recipeListGreen"))
        selectedIcons.append(#imageLiteral(resourceName: "TopRecipeActive"))
        selectedIcons.append(#imageLiteral(resourceName: "TopRecipeActive"))
        selectedIcons.append(#imageLiteral(resourceName: "friendsGreen"))
        
        tabController =  AZTabBarController.insert(into: self, withTabIcons: icons, andSelectedIcons: selectedIcons)
        
        let allRecipeVC = self.storyboard?.instantiateViewController(withIdentifier: "entranceVC") as! FFEntranceListViewController
        allRecipeVC.isEatWell = false
        allRecipeVC.fromNonProfessionalHome = 1
        tabController?.setViewController(allRecipeVC, atIndex: 0)
        let restvc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
        restvc.isFavList = false
        restvc.fromHome = 1
        tabController?.setViewController(restvc, atIndex: 1)
        let storevc = self.storyboard?.instantiateViewController(withIdentifier: "StoreListVC") as! FFStoreListingViewController
        storevc.fromHome = "Yes"
        tabController?.setViewController(storevc, atIndex: 2)
        let friendvc = self.storyboard?.instantiateViewController(withIdentifier: "FriendsVC") as! FFriendsListViewController
        tabController?.setViewController(friendvc, atIndex: 3)
        
        tabController?.defaultColor = .black
        tabController?.selectedColor = UIColor.primary
        tabController?.buttonsBackgroundColor = .white
        tabController?.selectionIndicatorColor = UIColor.primary
        tabController?.animateTabChange = true
        tabController?.tabBarHeight = 60
        
        tabController?.setTitle("\(StringConstants.nonProfessionalHome.Recipes)", atIndex: 0)
        tabController?.setTitle("\(StringConstants.nonProfessionalHome.Restaurants)", atIndex: 1)
        tabController?.setTitle("\(StringConstants.nonProfessionalHome.Commerces)", atIndex: 2)
        tabController?.setTitle("\(StringConstants.nonProfessionalHome.Friends)", atIndex: 3)

        tabController?.setAction(atIndex: 0, action: {
            self.navigationItem.title = "\(StringConstants.nonProfessionalHome.Recipes)"
            //self.customiseNavBar()
            self.navigationItem.rightBarButtonItems = [ ]

        })
        tabController?.setAction(atIndex: 1, action: {
            self.navigationItem.title = "\(StringConstants.nonProfessionalHome.Restaurants)"
            self.navigationItem.backBarButtonItem?.title = "\(StringConstants.nonProfessionalHome.Restaurants)"
            //self.navigationItem.rightBarButtonItems = [ ]
            
            self.customiseResturantNavBar()

//            let nav =  self.tabController?.childViewControllers
//            nav.popToRootViewController(animated: true)
        })
        tabController?.setAction(atIndex: 2, action: {
            
           // self.customiseNavBar()
            self.navigationItem.title = "\(StringConstants.nonProfessionalHome.Commerces)"
            self.navigationItem.backBarButtonItem?.title = ""
            self.navigationItem.rightBarButtonItems = [ ]

        })
        tabController?.setAction(atIndex: 3, action: {
            self.title = "\(StringConstants.MyFriends.MyFriends)"
            
            let addBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            addBtn.setImage(#imageLiteral(resourceName: "addicon"),for: .normal)
            addBtn.addTarget(self, action: #selector(self.addRecipeBtnTapped), for: UIControl.Event.touchUpInside)
            addBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let addButton = UIBarButtonItem(customView: addBtn)
            self.navigationItem.rightBarButtonItems = [ addButton]

            
        })
        
    }
    
    
    @objc func addRecipeBtnTapped(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as! FFAddFriendViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setUnProfessionalbottomTabOld(){ // customise Non Professional bottom tab
        var icons = [UIImage]()
        icons.append(#imageLiteral(resourceName: "atTheMoment"))
//        icons.append(#imageLiteral(resourceName: "TopRecipes"))
//        icons.append(#imageLiteral(resourceName: "Thematic"))
//        icons.append(#imageLiteral(resourceName: "Profile"))
        
        var selectedIcons = [UIImage]()
        selectedIcons.append(#imageLiteral(resourceName: "AtTheMomentActive"))
//        selectedIcons.append(#imageLiteral(resourceName: "TopRecipeActive"))
//        selectedIcons.append(#imageLiteral(resourceName: "ThematicActive"))
//        selectedIcons.append(#imageLiteral(resourceName: "ProfileActive"))
        
        tabController =  AZTabBarController.insert(into: self, withTabIcons: icons, andSelectedIcons: selectedIcons)
        
        let nonProfessionalHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "FFNonProfessionalHomeViewController")
        tabController?.setViewController(nonProfessionalHomeVC!, atIndex: 0)
        let topRecipesVC = self.storyboard?.instantiateViewController(withIdentifier: "EatWellVC")
        tabController?.setViewController(topRecipesVC!, atIndex: 1)
        let thematicVC = self.storyboard?.instantiateViewController(withIdentifier: "ThematicVC")
        tabController?.setViewController(thematicVC!, atIndex: 2)
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! FFProfileViewController
        if let usr = FFBaseClass.sharedInstance.getUser() {
            profileVC.userId = usr.id
        }
        tabController?.setViewController(profileVC, atIndex: 3)
        
        tabController?.defaultColor = .black
        tabController?.selectedColor = UIColor.primary
        tabController?.buttonsBackgroundColor = .white
        tabController?.selectionIndicatorColor = UIColor.primary
        tabController?.animateTabChange = true
        tabController?.tabBarHeight = 60
        
        tabController?.setTitle("\(StringConstants.Menu.home)", atIndex: 0)
        tabController?.setTitle("\(StringConstants.bottomTab.EatWell)", atIndex: 1)
        tabController?.setTitle("\(StringConstants.bottomTab.Thematic)", atIndex: 2)
        tabController?.setTitle("\(StringConstants.bottomTab.Profile)", atIndex: 3)

        tabController?.setAction(atIndex: 0, action: {
            self.navigationItem.title = "\(StringConstants.Menu.home)"
            //self.customiseNavBar()
            self.navigationItem.rightBarButtonItems = [ ]

        })
        tabController?.setAction(atIndex: 1, action: {
            self.navigationItem.title = "\(StringConstants.bottomTab.EatWell)"
            self.navigationItem.backBarButtonItem?.title = ""
            self.navigationItem.rightBarButtonItems = [ ]

            //self.customiseNavBar()

//            let nav =  self.tabController?.childViewControllers
//            nav.popToRootViewController(animated: true)
        })
        tabController?.setAction(atIndex: 2, action: {
            
           // self.customiseNavBar()
            self.navigationItem.title = "\(StringConstants.bottomTab.Thematic)"
            self.navigationItem.backBarButtonItem?.title = ""
            self.navigationItem.rightBarButtonItems = [ ]

        })
        tabController?.setAction(atIndex: 3, action: {
            self.navigationItem.title = "\(StringConstants.bottomTab.Profile)"
  
            
            let favBtn = UIButton(type: UIButton.ButtonType.custom)
            favBtn.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
            favBtn.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
//            favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControlEvents.touchUpInside)
            favBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let favButton = UIBarButtonItem(customView: favBtn)
            
//            favBtn?.isSelected = isFav!
            
            let shareBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
//            shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControlEvents.touchUpInside)
            shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let shareButton = UIBarButtonItem(customView: shareBtn)
            
//            let filterBtn: UIButton = UIButton(type: UIButtonType.custom)
//            filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
//            filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControlEvents.touchUpInside)
//            filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            let filterButton = UIBarButtonItem(customView: filterBtn)
            
//            self.navigationItem.rightBarButtonItems = [ ]
            
            
        })
        
    }
    
    func setProfessionalbottomTab(isStore: Int?){ // customise Professional bottom tab
            var icons = [UIImage]()
            icons.append(#imageLiteral(resourceName: "atTheMoment"))
            icons.append(#imageLiteral(resourceName: "followers"))
            icons.append(#imageLiteral(resourceName: "review"))
            icons.append(#imageLiteral(resourceName: "Profile"))
            
            var selectedIcons = [UIImage]()
            selectedIcons.append(#imageLiteral(resourceName: "AtTheMomentActive"))
            selectedIcons.append(#imageLiteral(resourceName: "followersActive"))
            selectedIcons.append(#imageLiteral(resourceName: "reviewActive"))
            selectedIcons.append(#imageLiteral(resourceName: "ProfileActive"))
            
            tabController =  AZTabBarController.insert(into: self, withTabIcons: icons, andSelectedIcons: selectedIcons)
            
            let professionalvc = self.storyboard?.instantiateViewController(withIdentifier: "FFProfessionalHomeViewController") as! FFProfessionalHomeViewController
        professionalvc.isStore = isStore
        tabController?.setViewController(professionalvc, atIndex: 0)
            let topFollowVC = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC")
            tabController?.setViewController(topFollowVC!, atIndex: 1)
        let reviewvc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewListVC") as! FFReviewListViewController
        reviewvc.fromWere = "restaurant"
        if let usr = FFBaseClass.sharedInstance.getUser() {
            reviewvc.restaurantId = usr.ownerofrestaurant
        }

        reviewvc.totalCount = "10"
//        reviewvc.reviewTitle = restaurantdetail?[0].name
        tabController?.setViewController(reviewvc, atIndex: 2)

            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! FFProfileViewController
            if let usr = FFBaseClass.sharedInstance.getUser() {
                profileVC.userId = usr.id
            }
            tabController?.setViewController(profileVC, atIndex: 3)
            tabController?.defaultColor = .black
            tabController?.selectedColor = UIColor.primary
            tabController?.buttonsBackgroundColor = .white
            tabController?.selectionIndicatorColor = UIColor.primary
            tabController?.animateTabChange = true
            tabController?.tabBarHeight = 60
        tabController?.setTitle("\(StringConstants.Menu.home)", atIndex: 0)
            tabController?.setTitle("Followers", atIndex: 1)
            tabController?.setTitle("Reviews", atIndex: 2)
            tabController?.setTitle("Profile", atIndex: 3)

            tabController?.setAction(atIndex: 0, action: {
                self.navigationItem.title = "\(StringConstants.Menu.home)"
                self.customiseNavBar()
            })
            tabController?.setAction(atIndex: 1, action: {
                self.navigationItem.title = "\(StringConstants.bottomTab.Followers)"
                self.navigationItem.backBarButtonItem?.title = ""
                
                self.customiseNavBar()

    //            let nav =  self.tabController?.childViewControllers
    //            nav.popToRootViewController(animated: true)
            })
            tabController?.setAction(atIndex: 2, action: {
                
                self.customiseNavBar()
                self.navigationItem.title = "\(StringConstants.bottomTab.Reviews)"
                self.navigationItem.backBarButtonItem?.title = ""
            })
            tabController?.setAction(atIndex: 3, action: {
                self.navigationItem.title = "Profile"
      
                
                let favBtn = UIButton(type: UIButton.ButtonType.custom)
                favBtn.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
                favBtn.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
    //            favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControlEvents.touchUpInside)
                favBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let favButton = UIBarButtonItem(customView: favBtn)
                
    //            favBtn?.isSelected = isFav!
                
                let shareBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
                shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
    //            shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControlEvents.touchUpInside)
                shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let shareButton = UIBarButtonItem(customView: shareBtn)
                
    //            let filterBtn: UIButton = UIButton(type: UIButtonType.custom)
    //            filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
    //            filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControlEvents.touchUpInside)
    //            filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    //            let filterButton = UIBarButtonItem(customView: filterBtn)
                
                self.navigationItem.rightBarButtonItems = [ ]
                
                
            })
            
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Add Resturant Button Tapped
    @objc func addRestaurantBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRestaurantVC") as! FFAddRestaurantViewController
        self.navigationController?.pushViewController(vc, animated: true)
      }
     
    // MARK: Search Resturant Button Tappded
    @objc func searchResturantBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
//        vc.selectedCountry = self.selectedCountry
//        vc.selectedRegion = self.selectedRegion
//        vc.selectedCity = self.selectedCity
//        vc.searchText = self.searchText
        vc.fromWhere = "search"
//        vc.delegate = self
        FFBaseClass.sharedInstance.isAddFriend = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    // MARK: Filter Resturant Button Tapped
    @objc func filterResturantBtnTapped(){ // go to filter restaurant screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
//        vc.selectedCountry = self.selectedCountry
//        vc.selectedRegion = self.selectedRegion
//        vc.selectedCity = self.selectedCity
//        vc.searchText = self.searchText
        vc.fromWhere = "filter"
        //vc.delegate = self
        FFBaseClass.sharedInstance.isAddFriend = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Customise Resturant Navigation Bar
    func customiseResturantNavBar(){ //add filter and search button in navigation bar
        self.title = "\(StringConstants.nonProfessionalHome.Restaurants)"

        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
        searchBtn.addTarget(self, action: #selector(self.searchResturantBtnTapped), for: UIControl.Event.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let addBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        addBtn.setImage(#imageLiteral(resourceName: "addicon"),for: .normal)
        addBtn.addTarget(self, action: #selector(self.addRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        addBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let addButton = UIBarButtonItem(customView: addBtn)

        let filterBtn = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn.setTitle("(0)", for: UIControl.State.normal)
        filterBtn.addTarget(self, action: #selector(self.filterResturantBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn)
        
        self.navigationItem.rightBarButtonItems = [filterButton, searchButton, addButton]
        
    }
    
    func customiseNavBar(){
        
        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
//        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControlEvents.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let filterBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
//        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControlEvents.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn)
        
//        self.navigationItem.rightBarButtonItems = [filterButton, searchButton]
        self.navigationItem.rightBarButtonItems = []

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if FFBaseClass.sharedInstance.isAddFriend == false{
            self.navigationItem.rightBarButtonItems = [ ]

        }
//        setUnProfessionalbottomTab()
    }

}
