//
//  FFMyIngredientsViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMyIngredientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IngredientCellDelegate {
    
    @IBOutlet weak var myIngredientListTableView:UITableView!
    var favList:[FFEntranceObject] = []
    @IBOutlet weak var notConnectedView:UIView!
    
    var userIdString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myIngredientListTableView.dataSource = self
        myIngredientListTableView.delegate = self
        myIngredientListTableView.tableFooterView = UIView()
       // customiseNavBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let user = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            if let userid = user.id {
                userIdString = "\(userid)"
            }
            loadMyIngredientList()
        }else {
            notConnectedView.isHidden = false
        }
        
    }
    
    func loadMyIngredientList(){ // ingredient list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyIngredientList(userId:self.userIdString , success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.favList = responce
            if self.favList.count > 0 {
                self.myIngredientListTableView.isHidden = false
            }else {
                self.myIngredientListTableView.isHidden = true
            }
            
            self.myIngredientListTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func customiseNavBar(){ // add filter and search buton in navigation bar
        
        self.title = "My Ingredients"
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let filterBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn)
        
        self.navigationItem.rightBarButtonItems = [filterButton, searchButton]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell  = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! FFMyIngredientTableViewCell
        cell.ingredientObj = favList[indexPath.row]
        cell.ingredienDelegate = self
        cell.refreshCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailVC") as! FFCategoryDetailViewController
////        vc.categoryName = self.favList[indexPath.row].name
////        vc.categoryImage = self.favList[indexPath.row].imageArray?.first?.name
//        if let id = self.favList[indexPath.row].id {
//          vc.categoryId = "\(id)"
//        }
//        vc.isFromIngredient = true
////        vc.isFav = true
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
                let vc  = self.storyboard?.instantiateViewController(withIdentifier: "IngredientDetailVC") as! FFIngredientDetailController
                if let id = self.favList[indexPath.row].id {
                    vc.categoryId =  "\(id)"
                }
                vc.isFromIngredient = true
        //        vc.categoryName = self.list[indexPath.row].name
        //        vc.categoryImage = self.list[indexPath.row].familyImage?.first?.name
                self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func ingredientDisLikePressed(id: Int?) { // dislike ingredient webservice
        if let stringId = id {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.dislikeIngredient(recipeID: "\(stringId)", success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.loadMyIngredientList()
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
            
        }
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
 
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
