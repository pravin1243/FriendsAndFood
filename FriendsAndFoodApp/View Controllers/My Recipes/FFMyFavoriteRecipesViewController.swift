//
//  FFMyFavoriteRecipesViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/22/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMyFavoriteRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecipeCellDelegate {
    func deleteRecipeTapped(obj: FFEntranceObject?) {
        
    }
    
    func editRecipeTapped(obj: FFEntranceObject?) {
        
    }
    
    
    @IBOutlet weak var recipeFavListTableView:UITableView!
    var favList:[FFEntranceObject] = []
    @IBOutlet weak var notConnectedView:UIView!
    
    @IBOutlet weak var emptyLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeFavListTableView.dataSource = self
        recipeFavListTableView.delegate = self
        
        customiseNavBar()
        setEmptyLabelText()
        
        recipeFavListTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = FFBaseClass.sharedInstance.getUser() {
            callMyFavRecipesAPI()
            notConnectedView.isHidden = true
        }else {
            notConnectedView.isHidden = false
        }
    }
    
    func customiseNavBar(){
        
        self.title = "My Favorite Recipes"
        
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
    
    func setEmptyLabelText(){ // add empty recipe view
//        Des que vous etes sur une recette,
//        cliquer sur le signe J'aime, celle-ci se retrouvera ici.
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "FavRecipeRed")
        attachment.bounds = CGRect(x: 0, y: -5, width: (attachment.image?.size.width)!, height: (attachment.image?.size.height)!)
        let attachmentString = NSAttributedString(attachment: attachment)
        let emptyString = NSMutableAttributedString(string: " As soon as you are on a recipe, click on the Like sign ")
        emptyString.append(attachmentString)
        emptyString.append(NSAttributedString(string: ", it will be found here."))
        emptyLabel.attributedText = emptyString
        
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRecipeCell") as! FFMyRecipeTableViewCell
        cell.recipeObj = favList[indexPath.row]
        cell.cellDelegate = self
        cell.refreshCell()
        return cell
        
    }
    
    func callMyFavRecipesAPI(){ // favorite recipe webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyFavRecipesList(success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.favList = response
            self.recipeFavListTableView.reloadData()
            if self.favList.count > 0 {
                self.recipeFavListTableView.isHidden = false
            }else {
                self.recipeFavListTableView.isHidden = true
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = favList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func recipeLikePressed(id: Int?) { // recipe like webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeRecipe(recipeID:id, success: { (resp) in
            print(resp)
            FFLoaderView.hideInView(view: self.view)
            self.callMyFavRecipesAPI()
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    func recipeDisLikePressed(id: Int?) { // recipe dislike webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeRecipe(recipeID:id, success: { (resp) in
            print(resp)
            FFLoaderView.hideInView(view: self.view)
            self.callMyFavRecipesAPI()
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
            
        }
    }
    
    func editRecipeTapped(id: Int?) {
        
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
