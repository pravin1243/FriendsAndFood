//
//  FFriendsListViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 03/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var friendsBtn:UIButton!
    @IBOutlet weak var requestsBtn:UIButton!
    @IBOutlet weak var invitationsBtn:UIButton!
    
    @IBOutlet weak var friendsTableView:UITableView!
    
    var selectedTab = 0
    //    @IBOutlet weak var requestsTableView:UITableView!
    //    @IBOutlet weak var invitationTableView:UITableView!
    
    var friendsArray:[FFFriendObject] = []
    //    var requestArray:[FFFriendObject] = []
    //    var invitationArray:[FFFriendObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        friendsTableView.tableFooterView = UIView()
        
        //        requestsTableView.dataSource = self
        //        requestsTableView.delegate = self
        //        requestsTableView.tableFooterView = UIView()
        //
        //
        //        invitationTableView.dataSource = self
        //        invitationTableView.delegate = self
        //        invitationTableView.tableFooterView = UIView()
        
        
        friendsBtn.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: UIControl.State.normal)
        friendsBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        requestsBtn.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: UIControl.State.normal)
        requestsBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        invitationsBtn.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: UIControl.State.normal)
        invitationsBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        self.title = "\(StringConstants.MyFriends.MyFriends)"

        customiseNavBar()
        selectedTab = 0
        self.selectFriendsBtn(self)
        //        requestsTableView.isHidden = true
        //        invitationTableView.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        customiseNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        customiseNavBar()

    }
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchRecipeBtnTapped(){
        
    }
    
    @objc func filterRecipeBtnTapped(){
        
    }
    
    @objc func addRecipeBtnTapped(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as! FFAddFriendViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func customiseNavBar(){ // adding search, filter and add friends button in navigation bar
        
        self.title = "\(StringConstants.MyFriends.MyFriends)"
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        
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
        
        let addBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        addBtn.setImage(#imageLiteral(resourceName: "addicon"),for: .normal)
        addBtn.addTarget(self, action: #selector(addRecipeBtnTapped), for: UIControl.Event.touchUpInside)
        addBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let addButton = UIBarButtonItem(customView: addBtn)
        
        self.navigationItem.rightBarButtonItems = [addButton]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if friendsArray.count > 0 {
                self.friendsTableView.backgroundView = nil
                return 1
            }else {
                let emptyView = UIView()
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0.5 * friendsTableView.bounds.size.height, width: self.friendsTableView.bounds.size.width, height: 30))
                if selectedTab == 0 {
                    emptyLabel.text = "\(StringConstants.MyFriends.Youhavenorequestsatthismoment)"
                }else if selectedTab == 1 {
                    emptyLabel.text = "\(StringConstants.MyFriends.Youhavenorequestsatthismoment)"
                }else if selectedTab == 2 {
                    emptyLabel.text = "\(StringConstants.MyFriends.Youhavenoinvitationsatthismoment)"
                }
                emptyLabel.font = UIFont.systemFont(ofSize: 15)
                emptyLabel.textAlignment = .center
                emptyLabel.textColor = UIColor.lightGray
                emptyView.addSubview(emptyLabel)
                let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                imagView.image = #imageLiteral(resourceName: "emptyFriends")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
                imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 50)
                emptyView.addSubview(imagView)
                
                self.friendsTableView.backgroundView = emptyView
                return 1
            }
            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsArray.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if selectedTab == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell")
            let lbl = cell?.viewWithTag(100) as! UILabel
            
            let profileImage = cell?.viewWithTag(400) as! UIImageView

            var name = ""
            if let lastname = self.friendsArray[indexPath.row].last_name {
                name = lastname.capitalizingFirstLetter() + " "
            }
            
            if let firstname = self.friendsArray[indexPath.row].first_name?.capitalizingFirstLetter() {
                let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                name = name + String(firstLetter)
                name = name + "."
            }

            lbl.text = name
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
            profileImage.layer.borderColor = UIColor.primary.cgColor
            profileImage.layer.borderWidth = 2

            if let profile = self.friendsArray[indexPath.row].photo {
                let isPublic = self.friendsArray[indexPath.row].ispublicphoto
                if isPublic == 0{
                    
                    if let imageUrl:URL = URL(string: profile){
                    profileImage.kf.setImage(with: imageUrl)
                    }

                }
            }
            
            
            let blockBtn = cell?.viewWithTag(300) as! UIButton
            blockBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].id!)
            blockBtn.addTarget(self, action:#selector(blockFrnd(_:)), for: UIControl.Event.touchUpInside)
            
            return cell!
        } else if selectedTab == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestCell")
            let lbl = cell?.viewWithTag(100) as! UILabel
            var name = ""
            if let lastname = self.friendsArray[indexPath.row].last_name {
                name = lastname.capitalizingFirstLetter() + " "
            }
            
            if let firstname = self.friendsArray[indexPath.row].first_name?.capitalizingFirstLetter() {
                let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
                name = name + String(firstLetter)
                name = name + "."
            }

            lbl.text = name
            
            let cancelBtn = cell?.viewWithTag(200) as! UIButton
            cancelBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].id!)

//            cancelBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].userInvitedId!)!
            
            cancelBtn.addTarget(self, action:#selector(cancelFrndRequest(_:)), for: UIControl.Event.touchUpInside)
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendInvitationCell")
            let lbl = cell?.viewWithTag(100) as! UILabel
            var name = ""
            if let lastname = self.friendsArray[indexPath.row].last_name {
              name = lastname.capitalizingFirstLetter() + " "
          }
          
          if let firstname = self.friendsArray[indexPath.row].first_name?.capitalizingFirstLetter() {
              let firstLetter = firstname[firstname.index(firstname.startIndex, offsetBy: 0)]
              name = name + String(firstLetter)
              name = name + "."
          }
            lbl.text = name
            
            let acceptBtn = cell?.viewWithTag(200) as! UIButton
            acceptBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].id ?? 0)
            acceptBtn.addTarget(self, action:#selector(acceptFrndRequest(_:)), for: UIControl.Event.touchUpInside)
            
            let rejectBtn = cell?.viewWithTag(300) as! UIButton
            rejectBtn.titleLabel?.tag = Int(self.friendsArray[indexPath.row].id ?? 0)
            rejectBtn.addTarget(self, action:#selector(rejectFrndRequest(_:)), for: UIControl.Event.touchUpInside)
            
            
            return cell!
        }
    }
    
    @IBAction func cancelFrndRequest(_ sender : UIButton){ // friends requestcancel webservice
        let alert = UIAlertController(title: "", message: "Are you sure you want to cancel this request?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler:  { action in
            //                    self.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler:  { action in
            if let userid = sender.titleLabel?.tag {
                FFLoaderView.showInView(view: self.view)
                FFManagerClass.cancelFriendRequest(id: "\(userid)", success: { (response) in
                    FFLoaderView.hideInView(view: self.view)
                    self.callRequestsAPI()
                    
                }) { (error) in
                    FFLoaderView.hideInView(view: self.view)
                    FFBaseClass.sharedInstance.showError(error: error, view: self)
                }
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
            
    }
    
    @IBAction func acceptFrndRequest(_ sender : UIButton){ // accept freind request webservice
        
        if let userid = sender.titleLabel?.tag {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.acceptFriendRequest(id: "\(userid)", success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.callInvitationsAPI()
                
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
        
    }
    
    @IBAction func rejectFrndRequest(_ sender : UIButton){ // reject friend request webservice  integration
        
        if let userid = sender.titleLabel?.tag {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.rejectFriendRequest(id: "\(userid)", success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.callInvitationsAPI()
                
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
    }
    
    @IBAction func blockFrnd(_ sender : UIButton){ // block friend webservice integration
        
        if let userid = sender.titleLabel?.tag {
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.blockFriendRequest(id: "\(userid)", success: { (response) in
                FFLoaderView.hideInView(view: self.view)
                self.callFriendsAPI()
                
            }) { (error) in
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberProfileVC") as! FFMemberProfileViewController
        vc.userId = Int((self.friendsArray[indexPath.row].id)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callFriendsAPI(){
        let requestModel = FFriendListRequestModel()
        requestModel.mode = "all"
        requestModel.status = "1"
        requestModel.statusInvited = "1"
        requestModel.userId = "\(FFBaseClass.sharedInstance.getUser()?.id ?? 0)"
        requestModel.page = "1"
        requestModel.whichTab = 0
        callAPI(requestModel: requestModel)
    }
    
    func callRequestsAPI(){
        let requestModel = FFriendListRequestModel()
//        requestModel.mode = ""
        requestModel.status = "1"
        requestModel.statusInvited = "0"
        requestModel.userId = "\(FFBaseClass.sharedInstance.getUser()?.id ?? 0)"
        requestModel.page = "1"
        requestModel.whichTab = 1
        callAPI(requestModel: requestModel)
    }
    
    func callInvitationsAPI(){
        let requestModel = FFriendListRequestModel()
        requestModel.mode = "invitation"
        requestModel.status = "1"
        requestModel.statusInvited = "0"
       // requestModel.userId = "\(FFBaseClass.sharedInstance.getUser()?.id ?? 0)"
        requestModel.page = "1"
        requestModel.whichTab = 2
        callAPI(requestModel: requestModel)
        
    }
    
    func callAPI(requestModel:FFriendListRequestModel){ // friends list webservvice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getFriendsList(requestModel: requestModel, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.friendsArray = response.friendsList!
            self.friendsTableView.reloadData()
//            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    
    @IBAction func selectFriendsBtn(_ sender : Any){
        deselectAllTabs()
        friendsBtn.isSelected = true
        selectedTab = 0
//        friendsTableView.isHidden = false
        if let id = FFBaseClass.sharedInstance.getUser()?.id {
            callFriendsAPI()
        }
        else {
            friendsTableView.reloadData()
        }
    }
    
    @IBAction func selectRequestBtn(_ sender : Any){
        deselectAllTabs()
        requestsBtn.isSelected = true
        //        requestsTableView.isHidden = false
        selectedTab = 1
        if let id = FFBaseClass.sharedInstance.getUser()?.id {
            callRequestsAPI()
        }
        else {
            friendsTableView.reloadData()
        }
        
    }
    
    @IBAction func selectInvitationsBtn(_ sender : Any){
        deselectAllTabs()
        invitationsBtn.isSelected = true
        //        invitationTableView.isHidden = false
        selectedTab = 2
        if let id = FFBaseClass.sharedInstance.getUser()?.id {
            callInvitationsAPI()
        }
        else {
            friendsTableView.reloadData()
        }
    }
    
    
    
    func deselectAllTabs(){
        friendsBtn.isSelected = false
        requestsBtn.isSelected = false
        invitationsBtn.isSelected = false
        
//        friendsTableView.isHidden = true
        //        requestsTableView.isHidden = true
        //        invitationTableView.isHidden = true
    }
    
}
