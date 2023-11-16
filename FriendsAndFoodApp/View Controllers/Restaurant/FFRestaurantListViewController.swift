//
//  FFRestaurantListViewController.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 19/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFRestaurantListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, findRestaurantDelegate {
    func didFinishedFilter(restauratList: [FFRestaurantObject], isSearchResult: Bool, selectedCountry: FFPlaceObject?, selectedRegion: FFPlaceObject?, selectedCity: FFPlaceObject?, searchText: String) {
        self.restauratList = restauratList
        self.isSearchResult = isSearchResult
        self.selectedCountry = selectedCountry
        self.selectedRegion = selectedRegion
        self.selectedCity = selectedCity
        self.searchText = searchText

    }
    

    @IBOutlet weak var restaurantTableView:UITableView!
    @IBOutlet weak var notConnectedView:UIView!

    var restauratList:[FFRestaurantObject] = []
    var restauratListSliced : ArraySlice<FFRestaurantObject> = []

    var isFavList:Bool?
    var isSearchResult:Bool?
    var filterBtn: UIButton?
    
    var searchText:String = ""
    var selectedCountry:FFPlaceObject?
    var selectedRegion:FFPlaceObject?
    var selectedCity:FFPlaceObject?
    
    var userId: String?
    var fromMenu: String?
    var fromHome: Int?
    var page: Int?
    var maxResult: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        maxResult = 10
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        if fromHome == 1{
            
        }else{
            customiseNavBar()

//        restaurantTableView.tableFooterView = UIView()
        }
        self.navigationItem.backBarButtonItem?.title = ""

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) { // show applied filters count
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        if let _ = FFBaseClass.sharedInstance.getUser() {
            notConnectedView.isHidden = true
            if isFavList == true {
                getFavRestaurantList()

            }else {
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
                    self.restaurantTableView.reloadData()
                }else {
                 getRestaurantList()
                }
            }

        }else {
            notConnectedView.isHidden = false
        }
        
    }
    
    
    func getRestaurantList(){ // restaurant list webservice intergration
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getRestaurantsList(page: "\(page ?? 0)", maxResult: "\(maxResult ?? 0)",success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.restauratList.append(contentsOf: response)
            if self.fromHome == 1{
            self.restauratListSliced = self.restauratList.prefix(10)
            }
            self.restaurantTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }

    
    func getFavRestaurantList(){ // restaurant favorite list webservice
        if let user = FFBaseClass.sharedInstance.getUser() {
            if let userid = user.id {
                userId = "\(userid)"
            }
        }
       FFLoaderView.showInView(view: self.view)
        FFManagerClass.getFavRestaurantsList(id:userId ,success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.restauratList = response
            self.restaurantTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    
    func customiseNavBar(){ //add filter and search button in navigation bar
        if fromMenu == "yes"{
            self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        }
        if isFavList == true {
            self.title = "Favorite Restaurants"

        }else {
            self.title = "\(StringConstants.nonProfessionalHome.Restaurants)"

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
            
        }
        
    }
    
    @objc func addRestaurantBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRestaurantVC") as! FFAddRestaurantViewController
        self.navigationController?.pushViewController(vc, animated: true)

      }
      
    @objc func searchRecipeBtnTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
        vc.selectedCountry = self.selectedCountry
        vc.selectedRegion = self.selectedRegion
        vc.selectedCity = self.selectedCity
        vc.searchText = self.searchText
        vc.fromWhere = "search"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func filterRecipeBtnTapped(){ // go to filter restaurant screen
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindRestaurantVC") as! FFFindRestaurantViewController
        vc.selectedCountry = self.selectedCountry
        vc.selectedRegion = self.selectedRegion
        vc.selectedCity = self.selectedCity
        vc.searchText = self.searchText
        vc.fromWhere = "filter"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Tableview Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if restauratList.count > 0 {
            self.restaurantTableView.backgroundView = nil
            return 1
        }else {
            let emptyView = UIView()
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0.5 * restaurantTableView.bounds.size.height, width: self.restaurantTableView.bounds.size.width, height: 30))
            if isFavList == true {
               emptyLabel.text = "\(StringConstants.restaurantstore.Sorrywedidnotfindanyresults)"
            }else {
                emptyLabel.text = isSearchResult == true ? "\(StringConstants.restaurantstore.Sorrywedidnotfindanyresults)" : "\(StringConstants.restaurantstore.Sorrywedidnotfindanyresults)"
            }
            emptyLabel.font = UIFont.systemFont(ofSize: 15)
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = UIColor.lightGray
            emptyView.addSubview(emptyLabel)
            let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imagView.image = #imageLiteral(resourceName: "emptyRestaurant")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
            imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 50)
            emptyView.addSubview(imagView)
            
            self.restaurantTableView.backgroundView = emptyView
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromHome == 1{
            return self.restauratListSliced.count
        }else{
        return self.restauratList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell")
        let namelbl = cell?.viewWithTag(100) as! UILabel
        let spllbl = cell?.viewWithTag(200) as! UILabel
        let placelbl = cell?.viewWithTag(300) as! UILabel
        let imgView = cell?.viewWithTag(400) as! UIImageView

        namelbl.text = self.restauratList[indexPath.row].name
        
        let splarray = restauratList[indexPath.row].specialities ?? []
        var splnamearray = [String]()
        if splarray.count > 0 {
            for item in splarray {
                splnamearray.append(item.name!)
            }
            
            let splstring = splnamearray.joined(separator: ",")
            spllbl.text = toHtmlEncodedString(encodedString: splstring)
        }
        
        
        var  place = toHtmlEncodedString(encodedString:  self.restauratList[indexPath.row].streetAddress!)
        
        let city = restauratList[indexPath.row].addressLocality?.capitalizingFirstLetter()  ?? ""
        let country = restauratList[indexPath.row].country?.capitalizingFirstLetter() ?? ""
        let postal = restauratList[indexPath.row].postalCode ?? ""

        place =  place + "\n" + city + ", " + postal + " " + country
        placelbl.text = place

        if let image = self.restauratList[indexPath.row].imageSmall {
            if let imageUrl:URL = URL(string: (image )){
            imgView.kf.setImage(with: imageUrl.standardizedFileURL)
            }
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! FFRestaurantDetailViewController
        vc.restaurantID = self.restauratList[indexPath.row].id
        vc.cityId = self.restauratList[indexPath.row].cityId

        vc.isFav = isFavList
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
        self.fromHome = 0
        let pageTemp = (page ?? 0) + 1
        page = pageTemp
        getRestaurantList()
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
//            let indexPath = IndexPath(row: self.dataArray.count-1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }


}
