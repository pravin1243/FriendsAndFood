//
//  FFNotificationSettingsViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 25/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFNotificationSettingsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var settingsTableView:UITableView!
    var settingsArray:[FFNotificationObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.dataSource = self
        settingsTableView.delegate  = self
        settingsTableView.tableFooterView = UIView()
        
        self.title = "Notification Settings"
        getNotificationSettings()
        // Do any additional setup after loading the view.
    }
    
    func getNotificationSettings(){ // notification settings webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getNotifcationSettingsList(success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.settingsArray = response
            self.settingsTableView.reloadData()
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")
        let nameLabel = cell?.viewWithTag(100) as! UILabel
        
        nameLabel.text = settingsArray[indexPath.row].name
        
        let settingSwitch = UISwitch()
        settingSwitch.onTintColor = UIColor.primary
        settingSwitch.isOn = settingsArray[indexPath.row].notificationStatus == 1 ? true : false
        settingSwitch.addTarget(self, action: #selector(notificationChanged(_:)), for: UIControl.Event.valueChanged)
        cell?.accessoryView = settingSwitch
        
        
        return cell!
    }
    
    @objc func notificationChanged( _ sender : UISwitch){ // modify notification value in array when switch is turned on/off
        
        let rowPoint = sender.convert(sender.bounds.origin, to: self.settingsTableView)
        let indexPath = self.settingsTableView.indexPathForRow(at: rowPoint)
        
        let status =  settingsArray[(indexPath?.row)!].notificationStatus
        
        if status == 1 {
            settingsArray[(indexPath?.row)!].notificationStatus = 0
            disableNotification(notifId: "\(settingsArray[(indexPath?.row)!].idInt ?? 0)")
        }else {
            settingsArray[(indexPath?.row)!].notificationStatus = 1
            enableNotification(notifId: "\(settingsArray[(indexPath?.row)!].idInt ?? 0)")
        }
      
        
    }
    
    
    func enableNotification(notifId: String){ // post notification webservice
//        var onNotificationArray:[String] = []
//
//
//        for item in settingsArray {
//            if item.notificationStatus == 1 {
//                onNotificationArray.append(item.id!)
//            }
//        }
//
//        let selectedNotificationIdString = onNotificationArray.joined(separator: ",")
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.enableNotifcationSettings(notifId: notifId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.settingsTableView.reloadData()
            
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func disableNotification(notifId: String){ // post notification webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.disableNotifcationSettings(notifId: notifId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.settingsTableView.reloadData()
            
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
