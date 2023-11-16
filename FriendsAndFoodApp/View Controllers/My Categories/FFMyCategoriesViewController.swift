//
//  FFMyCategoriesViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMyCategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CategoryCellDelegate {


    @IBOutlet weak var notConnectedView:UIView!
    @IBOutlet weak var myCategoryListTableView:UITableView!
    var categoryList:[FFRecipeTypeObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myCategoryListTableView.dataSource = self
        myCategoryListTableView.delegate = self
        myCategoryListTableView.tableFooterView = UIView()

//        customiseNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) { // call categories webservice if user is connected, otherwise show not connected text message
        
        if let user = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            loadMyCategories()
        }else {
            notConnectedView.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCategoryCell") as! FFMyCategoriesTableViewCell
        cell.categoryObj = categoryList[indexPath.row]
        
        cell.categoryDelegate = self
        cell.refreshCell()
        return cell
    }
    
    
    func loadMyCategories(){ // category list webservice itergration
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyCategoriesList(success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.categoryList = response
            var likeList:[FFRecipeTypeObject] = []
            var dislikeList:[FFRecipeTypeObject] = []

            
            for  categoryItem in self.categoryList {
                if categoryItem.checked == 0{
                    dislikeList.append(categoryItem)
                }else {
                    likeList.append(categoryItem)
                }
            }
        
            self.categoryList.removeAll()
            self.categoryList.append(contentsOf: likeList)
            self.categoryList.append(contentsOf: dislikeList)
            
            self.myCategoryListTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func customiseNavBar(){
        
        self.title = "My Favorite Categories"
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    func categoryLikePressed(id: String?) { // like a category webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeCategory(isMultiple: false, categoryIDs: [], recipeID: id, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.loadMyCategories()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    
    func categoryDisLikePressed(id: String?) { // dislike a category webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeCategory(recipeID: id, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.loadMyCategories()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailVC") as! FFCategoryDetailViewController
//        vc.categoryName = self.categoryList[indexPath.row].name
//        vc.categoryImage = self.categoryList[indexPath.row].image
        vc.categoryId = "\(self.categoryList[indexPath.row].id ?? 0)"
        vc.isFromIngredient = false
//        vc.isFav = self.categoryList[indexPath.row].checked == "0" ? false : true
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
