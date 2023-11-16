//
//  FFNotificationViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 25/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFNotificationViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var notificationTableView:UITableView!
    @IBOutlet weak var emptyNotificationView:UIView!
    var totalCnt:Int = 0
    
    var notificationList:[FFNotificationObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTableView.dataSource = self
        notificationTableView.delegate = self

        notificationTableView.tableFooterView = UIView()
        
        customiseNavBar()
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            emptyNotificationView.isHidden = true
            loadNotifications()
        }else {
            emptyNotificationView.isHidden = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customiseNavBar(){ // add filterbutton in navgation bar
        
        self.title = "Notifications"
        
//        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
        let filterBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        filterBtn.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let filterButton = UIBarButtonItem(customView: filterBtn)
        self.navigationItem.rightBarButtonItems = [filterButton]
    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func filterRecipeBtnTapped(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationSettingsVC") as! FFNotificationSettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! FFNotificationTableViewCell
        cell.notificationObj = notificationList[indexPath.row]
        cell.refreshCell()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    func loadNotifications(){ // notification list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getNotifcationList(page: "1", success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
//            self.totalCnt = response.totalCountInt!
            self.notificationList = response
            if self.notificationList.count > 0 {
                self.notificationTableView.reloadData()
                self.emptyNotificationView.isHidden = true
            }else {
                self.emptyNotificationView.isHidden = false
            }
            
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
        
    }
    
    
    
    


}
