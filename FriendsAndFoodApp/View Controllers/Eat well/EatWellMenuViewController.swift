//
//  EatWellMenuViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/24/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class EatWellMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuTableView:UITableView!
    var menuItems = [
        StringConstants.bottomTab.EatWell,StringConstants.bottomTab.Thematic,StringConstants.nonProfessionalHome.QA
    ]
    
       var imageItems = [#imageLiteral(resourceName: "TopRecipeActive"),#imageLiteral(resourceName: "ThematicActive"),#imageLiteral(resourceName: "faq")]

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

        self.title = "\(StringConstants.bottomTab.EatWell)"
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
            let topRecipesVC = self.storyboard?.instantiateViewController(withIdentifier: "EatWellVC") as! FFEatWellListViewController
                   self.navigationController?.pushViewController(topRecipesVC, animated: true)
               }
        if indexPath.row == 1 {
            let thematicVC = self.storyboard?.instantiateViewController(withIdentifier: "ThematicVC") as! FFThematicViewController
                  self.navigationController?.pushViewController(thematicVC, animated: true)
              }
        if indexPath.row == 2 {
            let faqvc = self.storyboard?.instantiateViewController(withIdentifier: "FFFaqViewController") as! FFFaqViewController
            self.navigationController?.pushViewController(faqvc, animated: true)
              }

    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 62
    }
}
