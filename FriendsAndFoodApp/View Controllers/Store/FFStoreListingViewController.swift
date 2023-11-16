//
//  FFStoreListingViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 06/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
class FFStoreListingViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var storeTableView:UITableView!
    @IBOutlet weak var notConnectedView:UIView!

    var storeTypeName: String?

    var storeType: String?
    var storeList:[FFStoreObject] = []
    
    var isSearchResult:Bool?
    var filterBtn: UIButton?
    
    var searchText:String = ""
    var selectedCountry:FFPlaceObject?
    var selectedRegion:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    
    var userId: String?
    var fromMenu: String?

    var fromHome: String?
    var page: Int? = 1
    var maxResult: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.dataSource = self
        storeTableView.delegate = self

        self.title = "Stores"

        customiseNavBar()
        // Do any additional setup after loading the view.
    }
    
 
    override func viewWillAppear(_ animated: Bool) { // show applied filters count
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        if let _ = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            if isSearchResult == true {
                
            
                var cnt = 0
                if  !searchText.isEmpty {
                    cnt = cnt + 1
                }
                if let _ = self.selectedCountry {
                    cnt = cnt + 1
                }
                if let _ = self.selectedRegion {
                    cnt = cnt + 1
                }
                if let _ = self.selectedCity {
                    cnt = cnt + 1
                }
                
                self.filterBtn?.setTitle("(\(cnt))", for: UIControl.State.normal)
                self.storeTableView.reloadData()
            }else {
                if self.fromHome == "Yes"{
                    self.getAllStoreList()
                }else{
                    self.getStoreList()
                    storeTableView.tableFooterView = UIView()

                }
            }

        }else {
            notConnectedView.isHidden = false
        }

    }
    
    func customiseNavBar(){ //add filter and search button in navigation bar
        if fromMenu == "yes"{
            self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        }
//        if isFavList == true {
//            self.title = "Favorite Restaurants"
//
//        }else {
//            self.title = "Find Restaurants"

        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            searchBtn.setImage(#imageLiteral(resourceName: "search") , for: .normal)
        searchBtn.addTarget(self, action: #selector(searchRecipeBtnTapped), for: UIControl.Event.touchUpInside)
            searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let searchButton = UIBarButtonItem(customView: searchBtn)
            
        let addBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            addBtn.setImage(#imageLiteral(resourceName: "addicon"),for: .normal)
        addBtn.addTarget(self, action: #selector(addRestaurantBtnTapped), for: UIControl.Event.touchUpInside)
            addBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let addButton = UIBarButtonItem(customView: addBtn)

        filterBtn = UIButton(type: UIButton.ButtonType.custom)
            filterBtn?.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterBtn?.setTitle("(0)", for: UIControl.State.normal)
        filterBtn?.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
            filterBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let filterButton = UIBarButtonItem(customView: filterBtn!)
            
            self.navigationItem.rightBarButtonItems = [filterButton, searchButton, addButton]
            
        //}
        
    }
    
     @objc func addRestaurantBtnTapped(){
          
    //          performSegue(withIdentifier: "AddRecipeSegue", sender: self)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFAddStoreStepOneVC") as! FFAddStoreStepOneVC
    //        vc.selectedCountry = self.selectedCountry
    //        vc.selectedRegion = self.selectedRegion
    //        vc.selectedCity = self.selectedCity
    //        vc.searchText = self.searchText
            self.navigationController?.pushViewController(vc, animated: true)

          }
          
        @objc func searchRecipeBtnTapped(){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
            vc.selectedCountry = self.selectedCountry
            vc.selectedRegion = self.selectedRegion
            vc.selectedCity = self.selectedCity
            vc.searchText = self.searchText
            vc.fromWhere = "search"
            vc.isStore = 1
            vc.storeTypeId = storeType
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        @objc func filterRecipeBtnTapped(){ // go to filter restaurant screen
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
            vc.selectedCountry = self.selectedCountry
            vc.selectedRegion = self.selectedRegion
            vc.selectedCity = self.selectedCity
            vc.searchText = self.searchText
            vc.fromWhere = "filter"
            vc.isStore = 1
            vc.storeTypeId = storeType
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        @objc func showMenu(){
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
        }
    
    func getAllStoreList(){ // restaurant list webservice intergration
           
           FFLoaderView.showInView(view: self.view)
        FFManagerClass.searchStores(page: "\(page ?? 0)", maxResult: "10", typeid:"", serchText: "", countryid: "" , regionid: "" , cityid: "" , success: { (response) in
               FFLoaderView.hideInView(view: self.view)
            self.storeList.append(contentsOf: response)

               self.storeTableView.reloadData()
           }) { (error) in
               FFLoaderView.hideInView(view: self.view)
               FFBaseClass.sharedInstance.showError(error: error, view: self)
           }
           
       }

 func getStoreList(){ // restaurant list webservice intergration
        
        FFLoaderView.showInView(view: self.view)
    FFManagerClass.getStoresList(id: storeType, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.storeList = response
            self.storeTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    //MARK:- Tableview Functions
       
       func numberOfSections(in tableView: UITableView) -> Int {
           
           if storeList.count > 0 {
               self.storeTableView.backgroundView = nil
               return 1
           }else {
               let emptyView = UIView()
               let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0.5 * storeTableView.bounds.size.height, width: self.storeTableView.bounds.size.width, height: 30))
//               if isFavList == true {
                  emptyLabel.text = "You have no stores"
//               }else {
//                   emptyLabel.text = isSearchResult == true ? "Sorry, we did not find any results" : "You have no restaurants"
//               }
               emptyLabel.font = UIFont.systemFont(ofSize: 15)
               emptyLabel.textAlignment = .center
               emptyLabel.textColor = UIColor.lightGray
               emptyView.addSubview(emptyLabel)
               let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
               imagView.image = #imageLiteral(resourceName: "emptyRestaurant")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
               imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 50)
               emptyView.addSubview(imagView)
               
               self.storeTableView.backgroundView = emptyView
               return 1
           }
           
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.storeList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell")
           let namelbl = cell?.viewWithTag(100) as! UILabel
           let spllbl = cell?.viewWithTag(200) as! UILabel
           let placelbl = cell?.viewWithTag(300) as! UILabel
           let imgView = cell?.viewWithTag(400) as! UIImageView
        if let storeType = self.storeList[indexPath.row].storeTypeName{
            spllbl.text = storeType.capitalizingFirstLetter()

        }
        namelbl.text = toHtmlEncodedString(encodedString:  self.storeList[indexPath.row].name!)
//
//           let splarray = storeList[indexPath.row].specialities ?? []
//           var splnamearray = [String]()
//           for item in splarray {
//               splnamearray.append(item.name!)
//           }
//
//           let splstring = splnamearray.joined(separator: ",")
        
//           spllbl.text = toHtmlEncodedString(encodedString: storeList[indexPath.row].address ?? "")
           
           
           var  place = toHtmlEncodedString(encodedString:  self.storeList[indexPath.row].address ?? "")
           
           let city = storeList[indexPath.row].cityName?.capitalizingFirstLetter()  ?? ""
           let country = storeList[indexPath.row].countryName?.capitalizingFirstLetter() ?? ""
           let postal = storeList[indexPath.row].postalCode ?? ""

//           place =  place + "\n" + city + ", " + country + " - " + postal
        place =  place + "\n" + city + ", " + postal + " " + country

           placelbl.text = place
           

           if let imageUrl:URL = URL(string: (self.storeList[indexPath.row].imageSmall ?? "")){
                     imgView.kf.setImage(with: imageUrl.standardizedFileURL)
                     }
           return cell!
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetailVC") as! FFStoreDetailViewController
           vc.storeID = self.storeList[indexPath.row].id
//           vc.isFav = isFavList
        
        vc.cityId = self.storeList[indexPath.row].cityId

           self.navigationController?.pushViewController(vc, animated: true)
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
       
    
    @IBAction func seeMoreTapped(_ sender: UIButton){
//        var currentCount = Int(totalCount ?? "")
//        currentCount = (currentCount ?? 0) + 10
//        totalCount = "\(currentCount ?? 0)"
        let pageTemp = (page ?? 0) + 1
        page = pageTemp

        
        
        getAllStoreList()
    }
}
