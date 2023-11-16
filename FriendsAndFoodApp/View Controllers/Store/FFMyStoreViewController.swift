//
//  FFMyStoreViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 30/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFMyStoreViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var storeTypeList:[FFStoreTypeObject] = []
    @IBOutlet weak var myStoreTableView:UITableView!
    var fromMenu:Bool?
    var fromHome: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        myStoreTableView.dataSource = self
        myStoreTableView.delegate = self
        myStoreTableView.tableFooterView = UIView()

        loadStoreTypes()
        if fromMenu == true{
            customiseNavBar()
        }
        // Do any additional setup after loading the view.
    }
        
    func customiseNavBar(){ // adding search, filter and add friends button in navigation bar
        
        self.title = "\(StringConstants.Menu.stores)"
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
//        let searchBtn: UIButton = UIButton(type: UIButtonType.custom)
//        searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
//        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControlEvents.touchUpInside)
//        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let searchButton = UIBarButtonItem(customView: searchBtn)
//
//        let filterBtn: UIButton = UIButton(type: UIButtonType.custom)
//        filterBtn.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
//        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControlEvents.touchUpInside)
//        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let filterButton = UIBarButtonItem(customView: filterBtn)
//
//        self.navigationItem.rightBarButtonItems = [filterButton, searchButton]
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
      }
      
      @objc func searchRecipeBtnTapped(){
          
      }
      
      @objc func filterRecipeBtnTapped(){
          
      }
      
    
    func loadStoreTypes(){ // ingredient list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getStoreTypes(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.storeTypeList = responce
            self.myStoreTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if fromHome == 1{
                return 0
            }else{
            return 1
            }
        }else{
          return storeTypeList.count
        }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            let  cell  = tableView.dequeueReusableCell(withIdentifier: "StoreTypeCell") as! FFStoreTypeTableViewCell
            if fromMenu == true{
            cell.storeTypeName.text = "Restaurant"
            }else{
                cell.storeTypeName.text = "My Favourite Restaurant"

            }
            returnCell = cell

        }else{
          let  cell  = tableView.dequeueReusableCell(withIdentifier: "StoreTypeCell") as! FFStoreTypeTableViewCell
            
          cell.storeTypeObject = storeTypeList[indexPath.row]
            cell.fromMenu = fromMenu
          cell.refreshCell()
          returnCell = cell
        }
        return returnCell
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FFBaseClass.sharedInstance.currentFavouriteIndex = 1
        
        if indexPath.section == 0{
            if fromMenu == true{

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
            vc.isFavList = false
            self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantListVC") as! FFRestaurantListViewController
                vc.isFavList = true
                self.navigationController?.pushViewController(vc, animated: true)
            }

        }else{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreListVC") as! FFStoreListingViewController
        vc.storeType = "\(storeTypeList[indexPath.row].storeTypeId ?? 0)"
            vc.storeTypeName = "\(storeTypeList[indexPath.row].name?.capitalizingFirstLetter() ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
        }
      }


}
