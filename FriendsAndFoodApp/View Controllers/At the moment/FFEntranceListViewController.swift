//
//  FFEntranceListViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFEntranceListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDataSource, UITableViewDelegate, EntranceCellDelegate,findRecipeDelegate {
    func didFinishedRecipeFilter(isSearchResult: Bool, recipeList: [FFEntranceObject], selectedinterest: FFRecipeTypeObject?, selectedcategory: FFRecipeTypeObject?, selectedrecipeType: FFRecipeTypeObject?, searchText: String) {
        self.isSearchResult = isSearchResult
        self.entranceArray = recipeList
        self.selectedinterest = selectedinterest
        self.selectedcategory = selectedcategory
        self.selectedrecipeType = selectedrecipeType
        self.searchText = searchText
        self.recipeTableView.reloadData()

    }
    var selectedcategory:FFRecipeTypeObject?
    var selectedinterest:FFRecipeTypeObject?
    var selectedrecipeType:FFRecipeTypeObject?

    var searchText:String = ""

    var isSearchResult:Bool?

    var totalCount:String?
    
    @IBOutlet weak var seeMoreButton:UIButton!
    @IBOutlet weak var seeMoreView:UIView!

    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var recipeTableView:UITableView!

    var entranceArray : [FFEntranceObject] = []
    var isEatWell:Bool?
    var interestId:String?
    var fromNonProfessionalHome: Int?
    var filterBtn: UIButton?
    var fromMenu: Int?

    var page: Int? = 1
    var maxResult: Int?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.delegate  = self

        collectionView.isHidden = true

        if isEatWell == true {
            loadIsWellEntrance()
                    recipeTableView.tableFooterView = UIView()

        }else {
            if fromNonProfessionalHome == 1{
                self.title = "\(StringConstants.nonProfessionalHome.Recipes)"

                loadAllRecipes()
                
            }else{
            loadEntrance()
            }
        }
        //        loadEntrance()
        // Do any additional setup after loading the view
    }
    func customiseNavigationBar(){ // add search , add and filter buton in navigation bar

        if fromMenu == 1{
            
            self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)

        }
        
        filterBtn = UIButton(type: UIButton.ButtonType.custom)
        filterBtn?.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn?.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let filterButton = UIBarButtonItem(customView: filterBtn!)
//        if self.entranceArray.count > 0{
            self.navigationItem.rightBarButtonItems = [filterButton]

//        }else{
//            self.navigationItem.rightBarButtonItems = [ ]
//
//        }
    }
    
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func filterRecipeBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFindRecipeVC") as! FFFindRecipeViewController
        vc.selectedinterest = self.selectedinterest
        vc.selectedcategory = self.selectedcategory
         vc.selectedrecipeType = self.selectedrecipeType
        vc.searchText = self.searchText
        vc.fromWhere = "filter"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        customiseNavigationBar()
      
    }
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadEntrance(){ // starter lisrt webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.loadEntranceList(withTypeId: "1", success: { response in
            self.entranceArray = response
            FFLoaderView.hideInView(view: self.view)
            
            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.recipeTableView.isHidden = false
                self.recipeTableView.reloadData()

                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
            }
            
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func loadAllRecipes(){ // starter lisrt webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.loadAllRecipeList(page: "\(page ?? 0)", maxResult: "10", success: { response in
            self.entranceArray.append(contentsOf: response)

            FFLoaderView.hideInView(view: self.view)
           
            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.recipeTableView.isHidden = false
                self.recipeTableView.reloadData()

                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
            }
            if self.entranceArray.count < 11{
//                self.moreButton.isHidden = true
            }
            
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func loadIsWellEntrance(){ // is well list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.loadEatWellEntranceList(withTypeId: "1", interestId: self.interestId, success: { (response ) in
            self.entranceArray = response
            FFLoaderView.hideInView(view: self.view)
            
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                self.recipeTableView.reloadData()
                self.collectionView.layoutIfNeeded()
            }
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if entranceArray.count > 0 {
            collectionView.backgroundView = nil
            return 1
            
        }else {
            let emptyView = UIView()
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.width))
            emptyLabel.text = "\(StringConstants.Labels.Norecipesfound)"
            emptyLabel.font = UIFont.systemFont(ofSize: 15)
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = UIColor.lightGray
            emptyLabel.backgroundColor = UIColor.clear
            emptyView.addSubview(emptyLabel)
            
            let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imagView.image = #imageLiteral(resourceName: "emptyRecipe")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
            imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 40)
            emptyView.addSubview(imagView)
            self.collectionView.backgroundView = emptyView
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entranceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entranceCell", for: indexPath) as! FFEntranceCollectionViewCell
        cell.responseObject = self.entranceArray[indexPath.row]
        cell.entranceDelegate = self
        cell.refreshCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.bounds.width / 2
        return CGSize(width: cellWidth, height: (cellWidth * 4/3))
        
    }
    
    func shareBtnPressed(url: String) {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = entranceArray[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if entranceArray.count > 0 {
            recipeTableView.backgroundView = nil
            return 1
            
        }else {
            let emptyView = UIView()
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.recipeTableView.bounds.size.width, height: self.recipeTableView.bounds.size.width))
            emptyLabel.text = "\(StringConstants.Labels.Norecipesfound)"
            emptyLabel.font = UIFont.systemFont(ofSize: 15)
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = UIColor.lightGray
            emptyView.addSubview(emptyLabel)
            
            let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imagView.image = #imageLiteral(resourceName: "emptyRecipe")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
            imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 40)
            emptyView.addSubview(imagView)
            
            self.recipeTableView.backgroundView = emptyView
            return 0
        }
    }
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return entranceArray.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
             cell.responseObject = entranceArray[indexPath.row]
             cell.refreshCell()
             return cell
         }
         
         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
         }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
         vc.recipeId = entranceArray[indexPath.row].id
         self.navigationController?.pushViewController(vc, animated: true)

     }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func seeMoreTapped(_ sender: UIButton){
//        var currentCount = Int(totalCount ?? "")
//        currentCount = (currentCount ?? 0) + 10
//        totalCount = "\(currentCount ?? 0)"
        let pageTemp = (page ?? 0) + 1
        page = pageTemp

        loadAllRecipes()
        
   
    }
    
}
