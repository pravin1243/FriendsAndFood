//
//  FFPreferencesViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFPreferencesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuTableView:UITableView!
    var menuItems = [
        StringConstants.bottomTab.Profile, StringConstants.Menu.languages,StringConstants.Menu.notifications,"CGU",StringConstants.Menu.contact_us
    ]
//    var imageItems =    [,#imageLiteral(resourceName: "language"),#imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "cgu"),#imageLiteral(resourceName: "contact")]
       var imageItems = [#imageLiteral(resourceName: "ProfileActive"),#imageLiteral(resourceName: "languageGreen"),#imageLiteral(resourceName: "notificationGreen"),#imageLiteral(resourceName: "cguGreen"),#imageLiteral(resourceName: "contactgreen")]

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
        customiseNavBar()
        menuTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
        
    func customiseNavBar(){ //add filter and search button in navigation bar
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)

        self.title = "\(StringConstants.Menu.preferences)"
        }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

      //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        let imageView = cell?.viewWithTag(100) as! UIImageView
         let nameLabel = cell?.viewWithTag(200) as! UILabel
        if FFMenuViewController.selectedRow == indexPath.row {
            imageView.image = imageItems[indexPath.row]
            nameLabel.textColor = UIColor.primary
//            cell?.backgroundColor = UIColor.black
        }else {
            imageView.image = imageItems[indexPath.row]
            nameLabel.textColor = UIColor.primary
            cell?.backgroundColor = UIColor.clear
        }
        nameLabel.text = menuItems[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FFMenuViewController.selectedRow = indexPath.row
        menuTableView.reloadData()
        
        if indexPath.row == 0 {
            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! FFProfileViewController
            if let usr = FFBaseClass.sharedInstance.getUser() {
                profileVC.userId = usr.id
            }

                   self.navigationController?.pushViewController(profileVC, animated: true)
               }
        if indexPath.row == 1 {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSelectLanguageVC") as! FFSelectLanguageViewController
                   self.navigationController?.pushViewController(vc, animated: true)
               }
        if indexPath.row == 2 {
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! FFNotificationViewController
                  self.navigationController?.pushViewController(vc, animated: true)
              }
        if indexPath.row == 3 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactVC") as! FFContactUsViewController
            vc.isContactUs = false
            self.navigationController?.pushViewController(vc, animated: true)

              }
              if indexPath.row == 4 {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactNewVC") as! FFContactUsNewViewController
                  //                  vc.isContactUs = false
                                    self.navigationController?.pushViewController(vc, animated: true)
              }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 62
    }
}
