//
//  FFFollowViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 28/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFFollowViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var notConnectedView:UIView!
    @IBOutlet weak var followListTableView:UITableView!
    var followList:[FFFollowObject] = []
    @IBOutlet weak var followerBtn:UIButton!
    @IBOutlet weak var followingBtn:UIButton!
    var selectedTab = 0
    var fromWhere: String?
    var userId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        followListTableView.dataSource = self
        followListTableView.delegate = self
        followListTableView.tableFooterView = UIView()

        followerBtn.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: UIControl.State.normal)
        followerBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        followingBtn.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: UIControl.State.normal)
        followingBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)

        if fromWhere == "profile"{
            self.title = "Follow"
        }
        if let usrId = userId{
            
        }else{
            if let user = FFBaseClass.sharedInstance.getUser(){
                userId = user.id
            }

        }
        
        if selectedTab == 0{
        self.followersBtnTapped(self)
        }else{
            self.followingsBtnTapped(self)
        }
        // Do any additional setup after loading the view.
    }
    

 override func viewWillAppear(_ animated: Bool) { // call categories webservice if user is connected, otherwise show not connected text message
            
            if let user = FFBaseClass.sharedInstance.getUser() {
                notConnectedView.isHidden = true
//                loadMyFollow(whichType: "follower")
            }else {
                notConnectedView.isHidden = false
            }
            
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return followList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell")
            let lbl = cell?.viewWithTag(100) as! UILabel
            
            let profileImage = cell?.viewWithTag(400) as! UIImageView

            var name = ""
            if let lastname = self.followList[indexPath.row].lastname {
                name = lastname.capitalizingFirstLetter() + " "
            }
            
            if let firstname = self.followList[indexPath.row].firstname?.capitalizingFirstLetter() {
                let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                name = name + String(firstLetter)
                name = name + "."
            }

            lbl.text = name
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
            profileImage.layer.borderColor = UIColor.primary.cgColor
            profileImage.layer.borderWidth = 2

            if let profile = self.followList[indexPath.row].photo {
                if let imageUrl:URL = URL(string: (profile)){
                profileImage.kf.setImage(with: imageUrl)
                }
            }
            
            
            let followBtn = cell?.viewWithTag(300) as! UIButton
//            followBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].id!)
//            followBtn.addTarget(self, action:#selector(blockFrnd(_:)), for: UIControlEvents.touchUpInside)
            
            return cell!
        }
        
        
    func loadMyFollow(whichType: String?){ // category list webservice itergration
        if let userId = FFBaseClass.sharedInstance.getUser()?.id {
            notConnectedView.isHidden = true
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getFollowList(userId:userId, whichType:whichType ,success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.followList = response
                
                self.followListTableView.reloadData()
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                print(error)
            }
        }
        else {
            notConnectedView.isHidden = false
        }
            
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
     
        
        @objc func searchRecipeBtnTapped(){
            
        }
        
        @objc func filterRecipeBtnTapped(){
            
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberProfileVC") as! FFMemberProfileViewController
            if selectedTab == 0{
                vc.userId = Int((self.followList[indexPath.row].followerid)!)

            }else{
                vc.userId = Int((self.followList[indexPath.row].followedid)!)

            }
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        
        @IBAction func goToLogin(_ sender:Any){
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
            loginVC.isFirstLaunch = false
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        
        @IBAction func goToRegistration(_ sender: Any) {
            let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! FFRegistrationViewController
            registerVC.isFirstLaunch = false
            self.navigationController?.pushViewController(registerVC, animated: true)
        }

      @IBAction func followersBtnTapped(_ sender : Any){
            deselectAllTabs()
            followerBtn.isSelected = true
            //        requestsTableView.isHidden = false
            selectedTab = 0
            loadMyFollow(whichType: "follower")

        }
        
        @IBAction func followingsBtnTapped(_ sender : Any){
            deselectAllTabs()
            followingBtn.isSelected = true
            //        invitationTableView.isHidden = false
            selectedTab = 1
            loadMyFollow(whichType: "following")

        }
        
        func deselectAllTabs(){
            followerBtn.isSelected = false
            followingBtn.isSelected = false
        }

}
