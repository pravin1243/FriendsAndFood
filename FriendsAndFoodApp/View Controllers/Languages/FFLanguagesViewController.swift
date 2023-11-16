//
//  FFLanguagesViewController.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 30/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
class FFLanguagesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var langList:[FFLanguageObject] = []
    @IBOutlet weak var languageTableView:UITableView!
    var isFirstInstalled: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        languageTableView.dataSource = self
        languageTableView.delegate = self
        loadLanguages()
        if isFirstInstalled == true{
//            self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBarBg"), for: UIBarMetrics.default)
            if let navBar = navigationController?.navigationBar {
                navBar.setBackgroundImage(UIImage(named: "navigationBarBg"), for: .default)
            }
            self.navigationItem.setHidesBackButton(true, animated: true)

            self.title = "Preferred Language"
        }else{
            customiseNavBar()
        }
        let langStr = Locale.current.languageCode
        print("Current device language is \(langStr ?? "")")
        // Do any additional setup after loading the view.
    }
    

    func loadLanguages(){ // language list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getLanguages(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.langList = responce
            self.languageTableView.reloadData()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func customiseNavBar(){ // add filter and search buton in navigation bar
        
        self.title = "Languages"
        
//        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
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
        return langList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell  = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguagesTableViewCell
        cell.langObject = langList[indexPath.row]
        cell.refreshCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FFBaseClass.sharedInstance.setStringValue(stringValue: "no", key: "isJustInstalled")
        if isFirstInstalled == true{
//        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
//        loginVC.isFirstLaunch = true
//        self.navigationController?.pushViewController(loginVC, animated: true)

         
        }
        
        let language = langList[indexPath.row].code
                 UserDefault.standard.setSelectedLanguage(language: langList[indexPath.row].code ?? "")

                 if language == "fr"{
                     self.callChangeLanguageService(.french)
                 }else if language == "en"{
                     self.callChangeLanguageService(.english)
                 }else if language == "it"{
                     self.callChangeLanguageService(.italian)
                 }else if language == "de"{
                     self.callChangeLanguageService(.german)
                 }else if language == "es"{
                     self.callChangeLanguageService(.spanish)
                 }


    }
    
    
    func callChangeLanguageService(_ lang: Localization){

          Localization.language = lang
        if isFirstInstalled == true{

                      let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
                      loginVC.isFirstLaunch = true
                      self.navigationController?.pushViewController(loginVC, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }

          }
}
