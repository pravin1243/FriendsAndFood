//
//  FFEatWellRecipeViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/18/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class FFEatWellRecipeViewController: UIViewController , SwipeMenuViewDelegate, SwipeMenuViewDataSource {

    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    var isEatWell:Bool?
    var interestId:String?
    var interestImage:String?
    var recipeName:String?
    var isFromSideMenu:Bool?
    var isFav:Bool?
    var favBtn: UIButton?
    
    @IBOutlet weak var headerImgView:UIImageView!
    @IBOutlet weak var imageHeightConstraint:NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
        //        options.tabView.underlineView.backgroundColor = UIColor.primary
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)
        
        self.title = recipeName
        customiseNavigationBar()
        
        if isFromSideMenu == false {
            imageHeightConstraint.constant = 0
        }else {
            imageHeightConstraint.constant = 270
        }
        
        if let imageString = interestImage {
            let imageUrl:URL = URL(string: imageString)!
            headerImgView.kf.setImage(with:imageUrl )
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func customiseNavigationBar(){ // navigation bar mdifications

        
        favBtn = UIButton(type: UIButton.ButtonType.custom)
        favBtn?.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
        favBtn?.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
        favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControl.Event.touchUpInside)
        favBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let favButton = UIBarButtonItem(customView: favBtn!)
        
        favBtn?.isSelected = isFav!
        
        let shareBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
        shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareButton = UIBarButtonItem(customView: shareBtn)
        
        let filterBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn)
        
        self.navigationItem.rightBarButtonItems = [filterButton, shareButton, favButton]
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isEatWell == true {
            self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "BackIcon")
        }else {
            self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "menu")
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if isEatWell == true {
            self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "BackIcon")
        }else {
            self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "menu")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 3
    }
    
    //MARK:- Swipe menu delegates
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        
        if index == 0 {
            return "\(StringConstants.Labels.Entrances)".uppercased()
        }else if index == 1 {
            return "\(StringConstants.Labels.Dishes)".uppercased()
        }else {
            return "\(StringConstants.Labels.Desserts)".uppercased()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let entranceVC = self.storyboard?.instantiateViewController(withIdentifier: "entranceVC") as! FFEntranceListViewController
        entranceVC.isEatWell = true
        entranceVC.interestId = self.interestId
        let dishesVC = self.storyboard?.instantiateViewController(withIdentifier: "dishesVC") as! FFDishesListViewController
        dishesVC.isEatWell = true
        dishesVC.interestId = self.interestId
        let dessertsVC = self.storyboard?.instantiateViewController(withIdentifier: "dessertsVC") as! FFDessertsListViewController
        dessertsVC.isEatWell = true
        dessertsVC.interestId = self.interestId
        
        if index == 0 {
            addChild(entranceVC)
            return entranceVC
        }else if index == 1 {
            addChild(dishesVC)
            return dishesVC
        }else {
            addChild(dessertsVC)
            return dessertsVC
        }
    }
    
    @objc func favBtnTapped(){ // favorite button action
        
        if let _ = FFBaseClass.sharedInstance.getUser() {
            if isFav == true {
                callDislikeInterestAPI()
            }else {
                callLkeInterestAPI()
            }
        }else {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
            loginVC.isFirstLaunch = false
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    
    func callDislikeInterestAPI(){ // dislike interetst webservice
        if let _ = FFBaseClass.sharedInstance.getUser() {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.dislikeInterest(interstID: self.interestId, success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.isFav = false
                self.favBtn?.isSelected = false
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }else {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
            loginVC.isFirstLaunch = false
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    func callLkeInterestAPI(){ // like interest webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeInterest(isMultiple: false, interstIDs: [], interstID: self.interestId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.isFav = true
            self.favBtn?.isSelected = true
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }

    @objc func shareRecipeBtnTapped(){
        
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
