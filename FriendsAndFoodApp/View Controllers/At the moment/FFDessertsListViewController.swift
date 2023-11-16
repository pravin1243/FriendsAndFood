//
//  FFDessertsListViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/7/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFDessertsListViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak var recipeTableView:UITableView!

    @IBOutlet weak var collectionView:UICollectionView!
    var dessertsArray : [FFEntranceObject] = []
    
    var isEatWell:Bool?
    var interestId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.delegate  = self
        recipeTableView.tableFooterView = UIView()

//        if isEatWell == true {
//            loadIsWellDesserts()
//        }else {
//            loadDesserts()
//        }
        //        loadDesserts()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.isHidden  = true
        if isEatWell == true {
            loadIsWellDesserts()
        }else {
            loadDesserts()
        }
    }
    
    func loadDesserts(){ // desserts webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.loadEntranceList(withTypeId: "3", success: { response in
            self.dessertsArray = response
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
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    
    func loadIsWellDesserts(){ // is well desserts webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.loadEatWellEntranceList(withTypeId: "3", interestId: self.interestId, success: { (response ) in
            self.dessertsArray = response
            FFLoaderView.hideInView(view: self.view)
            
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                self.recipeTableView.reloadData()

            }
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    //MARK:- Collection View datasource and delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if dessertsArray.count > 0 {
            collectionView.backgroundView = nil
            return 1
            
        }else {
            let emptyView = UIView()
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.width))
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
            self.collectionView.backgroundView = emptyView
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dessertsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entranceCell", for: indexPath) as! FFEntranceCollectionViewCell
        cell.responseObject = dessertsArray[indexPath.row]
        cell.refreshCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.bounds.width / 2
        return CGSize(width: cellWidth, height: (cellWidth * 4/3))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = dessertsArray[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dessertsArray.count > 0 {
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
            return dessertsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
            cell.responseObject = dessertsArray[indexPath.row]
            cell.refreshCell()
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = dessertsArray[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)

    }
        
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
        
//        func scrollViewDidScroll(_ scrollView: UIScrollView) { // hide/show top bar when scrollview is scriolled up
//
//            if scrollView.contentOffset.y >= (self.recipeTableView.tableHeaderView?.frame.size.height)!{
//                topView.backgroundColor = FFBaseClass.primaryColor
//                topLabel.textColor = UIColor.white
//               // favBtn.tintColor = UIColor.white
//                shareBtn.tintColor = UIColor.white
//                backBtn.tintColor = UIColor.white
//            }else{
//                topView.backgroundColor = UIColor.clear
//                topLabel.textColor = UIColor.black
//                //favBtn.tintColor = UIColor.black
//                shareBtn.tintColor = UIColor.black
//                backBtn.tintColor = UIColor.black
//            }
//
//        }
    
}
