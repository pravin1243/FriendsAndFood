//
//  FFMyInterestsViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/29/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMyInterestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , InterestCellDelegate{
    
    @IBOutlet weak var interestTableView:UITableView!
    @IBOutlet weak var notConnectedView:UIView!
    var interestList : [FFRecipeTypeObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        interestTableView.dataSource = self
        interestTableView.delegate = self
        interestTableView.tableFooterView = UIView()
       // customiseNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let _ = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            loadMyInterests()
        }else {
            notConnectedView.isHidden = false
        }
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    func customiseNavBar(){ // add search and filter button in navigation bar
        
        self.title = "My Interests"
        
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
    
    
    func loadMyInterests(){ // get intererst list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyInterestsList(success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            
            self.interestList = response
            self.interestTableView.reloadData()
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyInterestsCell") as! FFMyInterestTableViewCell
        cell.interestObj = interestList[indexPath.row]
        cell.interestDelegate = self
        cell.refreshCell()
        return cell
    }
    
    @objc func favBtnTapped(isSelect:Bool){
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func interestLikePressed(id: String?) { // like interest webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeInterest(isMultiple: false, interstIDs: [], interstID: id, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.loadMyInterests()
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func interestDisLikePressed(id: String?) { // dislike inteerst webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.dislikeInterest(interstID: id, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.loadMyInterests()
            
        }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "EatWellDetailVC") as! FFEatWellRecipeViewController
        vc.interestId = self.interestList[indexPath.row].stringId
        vc.recipeName = self.interestList[indexPath.row].name
        vc.isFromSideMenu = true
        vc.interestImage = self.interestList[indexPath.row].image
        vc.isFav = self.interestList[indexPath.row].checked == 0 ? false : true
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
