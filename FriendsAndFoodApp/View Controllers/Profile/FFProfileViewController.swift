//
//  FFProfileViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu
import Kingfisher

class FFProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var yesBtn:UIButton!
    @IBOutlet weak var noBtn:UIButton!
    @IBOutlet weak var followersCountLabel:UILabel!
    @IBOutlet weak var followingCountLabel:UILabel!

    @IBOutlet weak var pointslabel:UILabel!
    var editRequest = FFEditProfileRequestModel()
    
    @IBOutlet weak var genderlabel:UILabel!
    @IBOutlet weak var birthdatelabel:UILabel!
    @IBOutlet weak var phonelabel:UILabel!
    @IBOutlet weak var basicaddresslabel:UILabel!
    @IBOutlet weak var emaillabel:UILabel!
    
    @IBOutlet weak var genderHeadlabel:UILabel!
    @IBOutlet weak var birthdateHeadlabel:UILabel!
    @IBOutlet weak var phoneHeadlabel:UILabel!
    @IBOutlet weak var basicaddressHeadlabel:UILabel!
    @IBOutlet weak var emailHeadlabel:UILabel!

    
    @IBOutlet weak var genderlabelHC:NSLayoutConstraint!
    @IBOutlet weak var birthdatelabelHC:NSLayoutConstraint!
    @IBOutlet weak var phonelabelHC:NSLayoutConstraint!
    @IBOutlet weak var basicaddresslabelHC:NSLayoutConstraint!
    @IBOutlet weak var emaillabelHC:NSLayoutConstraint!
    
    @IBOutlet weak var genderHeadlabelHC:NSLayoutConstraint!
    @IBOutlet weak var birthdateHeadlabelHC:NSLayoutConstraint!
    @IBOutlet weak var phoneHeadlabelHC:NSLayoutConstraint!
    @IBOutlet weak var editbasicaddressHC:NSLayoutConstraint!
    @IBOutlet weak var emailHeadlabelHC:NSLayoutConstraint!

    
    @IBOutlet weak var companyNamelabel:UILabel!
    @IBOutlet weak var companyNumberlabel:UILabel!
    @IBOutlet weak var companyAddresslabel:UILabel!
    
    @IBOutlet weak var companyNameHeadlabel:UILabel!
    @IBOutlet weak var companyNumberHeadlabel:UILabel!
    @IBOutlet weak var companyAddressHeadlabel:UILabel!
    
    @IBOutlet weak var namelabel:UILabel!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var aboutLbl:UILabel!
    @IBOutlet weak var editProfileBtn:UIButton!
    @IBOutlet weak var sendMsgBtn:UIButton!
    @IBOutlet weak var sendInvitationBtn:UIButton!
    @IBOutlet weak var badgeImageView:UIImageView!
    @IBOutlet weak var aboutHeadLbl:UILabel!

    @IBOutlet weak var reditProfileBtn:UIButton!
    @IBOutlet weak var rsendMsgBtn:UIButton!
    @IBOutlet weak var rsendInvitationBtn:UIButton!
    
    @IBOutlet weak var reditProfileBtnHC:NSLayoutConstraint!

    @IBOutlet weak var rsendMsgBtnHC:NSLayoutConstraint!
    @IBOutlet weak var rsendInvitationBtnHC:NSLayoutConstraint!

    @IBOutlet weak var recipeTableView:UITableView!
    
    @IBOutlet weak var infoView:UIView!
    @IBOutlet weak var infoBtn:UIButton!
    @IBOutlet weak var recipeView:UIView!
    @IBOutlet weak var recipeBtn:UIButton!
    
    @IBOutlet weak var notConnectedView:UIView!
    
    var userDetail:FFUserObject?
    var userId:Int?
    
    var recipeList:[FFEntranceObject] = []
    @IBOutlet weak var recipeTableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var sendInviteBtnHeightConstraint:NSLayoutConstraint!
    
    
    @IBOutlet weak var areyouproffesionalLabelHC:NSLayoutConstraint!
    @IBOutlet weak var areyouproffesionalOptionHC:NSLayoutConstraint!
    
    @IBOutlet weak var changePasswordLabel:UILabel!
    @IBOutlet weak var changePasswordSeparator:NSLayoutConstraint!
    @IBOutlet weak var changePasswordBtnHC:NSLayoutConstraint!

    @IBOutlet weak var editBasicProfileBtn:UIButton!
    @IBOutlet weak var editProfessionalProfileBtn:UIButton!
    @IBOutlet weak var editBasicAddressBtn:UIButton!
    @IBOutlet weak var editProfessionalAddressBtn:UIButton!
    @IBOutlet weak var changePasswordBtn:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        userId = 3402
//        userId = 25555
        customiseBtn(button: yesBtn)
        customiseBtn(button: noBtn)
        
        // style info and recipe buttons
        infoBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        infoBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        recipeBtn.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        recipeBtn.setTitleColor(UIColor.primary, for: UIControl.State.selected)
        
        infoBtn.isSelected = true
        recipeView.isHidden = true
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
        // customise profile imageview
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.primary.cgColor
        profileImageView.layer.borderWidth = 2
        
        reditProfileBtn.layer.cornerRadius = reditProfileBtn.frame.size.height / 2
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.profileUpdated(notification:)), name: Notification.Name("profileUpdated"), object: nil)
        hideMainButtons()
        if let usr = FFBaseClass.sharedInstance.getUser() , self.userId == usr.id {
                     self.reditProfileBtn.isHidden = false
                     self.reditProfileBtnHC.constant = 40.0

                     //                checkFreind(userid: userId)
                 }else {
                     //self.hideSectionsforMember()
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotConnectedVC") as! NotConnectedVC
//            self.navigationController?.pushViewController(vc, animated: true)
//
                    
                    let containerView = UIView()
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(containerView)
                    NSLayoutConstraint.activate([
                        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    ])

                    // add child view controller view to container

                    let controller = storyboard!.instantiateViewController(withIdentifier: "NotConnectedVC")
                    addChild(controller)
                    controller.view.translatesAutoresizingMaskIntoConstraints = false
                    containerView.addSubview(controller.view)

                    NSLayoutConstraint.activate([
                        controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                        controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                    ])

                    controller.didMove(toParent: self)

            return

                 }
        // Do any additional setup after loading the view.
    }
    @objc func profileUpdated(notification: NSNotification){
        getProfile()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func customiseBtn(button: UIButton){
        
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        button.layer.borderWidth = 0.5
        
        button.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        button.setTitleColor(UIColor.primary, for: UIControl.State.selected)
    }
    
    func hideOrShowTick(btn:UIButton, shouldShow:Bool ){ // show/hide selection tick mark
        
        let superview = btn.superview
        let tick = superview?.viewWithTag(100) as! UIImageView
        tick.isHidden = !shouldShow
        
        if shouldShow == true {
            btn.layer.borderColor = UIColor.primary.cgColor
        }else {
            btn.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
    }
    
    @IBAction func yesBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        makeProfessionalAPI(isProfessional: "1")
        yesBtn.isSelected = false
        noBtn.isSelected = false
        
        hideOrShowTick(btn: yesBtn, shouldShow: false)
        hideOrShowTick(btn: noBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }
    
    @IBAction func noBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        
        yesBtn.isSelected = false
        noBtn.isSelected = false
        
        hideOrShowTick(btn: yesBtn, shouldShow: false)
        hideOrShowTick(btn: noBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }
    
    func hideSectionsforMember (){
        self.editProfessionalProfileBtn.isHidden = true
        self.editProfessionalAddressBtn.isHidden = true
        self.changePasswordBtn.isHidden = true
        self.editBasicAddressBtn.isHidden = true
        self.editBasicProfileBtn.isHidden = true
        self.areyouproffesionalLabelHC.constant = 0
        self.areyouproffesionalOptionHC.constant = 0
        self.changePasswordSeparator.constant = 0
        self.yesBtn.isHidden = true
        self.noBtn.isHidden = true
        self.changePasswordLabel.text = ""
        
        self.genderlabel.text = ""
        self.birthdatelabel.text = ""
        self.phonelabel.text = ""
        self.basicaddresslabel.text = ""
        self.emaillabel.text = ""
                
        self.genderHeadlabel.text = ""
        self.birthdateHeadlabel.text = ""
        self.phoneHeadlabel.text = ""
        self.basicaddressHeadlabel.text = ""
        self.emailHeadlabel.text = ""
        self.aboutHeadLbl.text = ""
        self.aboutLbl.text = ""
        self.basicaddresslabel.text = ""

        
        self.genderlabelHC.constant = 0
        self.birthdatelabelHC.constant = 0
        self.phonelabelHC.constant = 0
        self.basicaddresslabelHC.constant = 0
        self.emaillabelHC.constant = 0
                
        self.genderHeadlabelHC.constant = 0
        self.birthdateHeadlabelHC.constant = 0
        self.phoneHeadlabelHC.constant = 0
        self.editbasicaddressHC.constant = 0
        self.emailHeadlabelHC.constant = 0
        self.changePasswordBtnHC.constant = 0
    }
    
    func hideMainButtons (){
        reditProfileBtnHC.constant = 0
        rsendMsgBtnHC.constant = 0
        rsendInvitationBtnHC.constant = 0
    }
    

    func makeProfessionalAPI(isProfessional: String?){
        editRequest.ok = "1"
        if let id = self.userDetail?.id {
            editRequest.id = "\(id)"
        }
        FFLoaderView.showInView(view: self.view)
        editRequest.isprofessional = isProfessional
        FFManagerClass.changeProfile(request: self.editRequest, success: { (response) in
            FFLoaderView.hideInView(view:  self.view)
            self.getProfile()
        }) { (error) in
            FFLoaderView.hideInView(view:  self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customiseNavBar()
        getProfile()
        
    }
    
    func checkFreind(userid:Int?){ // check if user is friend or not
        
        FFLoaderView.showInView(view: self.view)
        
        FFManagerClass.checkFreind(userId: userid, success: { (response:FFBaseResponseModel) in
            FFLoaderView.hideInView(view: self.view)
            
            self.sendMsgBtn.isHidden = true
            self.sendInvitationBtn.isHidden = true
            self.rsendMsgBtn.isHidden = true
            self.rsendInvitationBtn.isHidden = true
            

            if response.message == "1" {
                self.sendMsgBtn.isHidden = false
            }else if response.message == "-1"{
                self.sendInvitationBtn.isHidden = false
                self.sendInvitationBtn.isEnabled = true
                self.sendInvitationBtn.alpha = 1
                self.rsendInvitationBtn.isHidden = false
                self.rsendInvitationBtn.isEnabled = true
                self.rsendInvitationBtn.alpha = 1
                self.rsendInvitationBtnHC.constant = 40.0

                
            }else if response.message == "2" || response.message == "0" {
                self.sendInvitationBtn.isHidden = false
                self.sendInvitationBtn.isEnabled = false
                self.sendInvitationBtn.alpha = 0.5
                self.rsendInvitationBtn.isHidden = false
                self.rsendInvitationBtn.isEnabled = false
                self.rsendInvitationBtn.alpha = 0.5
                self.rsendInvitationBtnHC.constant = 40.0

                
            }
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
        
    }
    
    func getProfile(){ // get profil webservice
        
        if let _ = userId { // recipe detial
            
            notConnectedView.isHidden = true
            
            callMyProfileAPI()
            callMyRecipesAPI()
            
            if let usr = FFBaseClass.sharedInstance.getUser() , self.userId == usr.id {
                reditProfileBtn.isHidden = false
                reditProfileBtnHC.constant = 40.0

                //                checkFreind(userid: userId)
            }else {
                self.hideSectionsforMember()
                reditProfileBtn.isHidden = true
                
                if let _ = FFBaseClass.sharedInstance.getUser(){
                    checkFreind(userid: userId)
                    
                }else {
                    sendMsgBtn.isHidden = true
                    sendInvitationBtn.isHidden = true
                    rsendMsgBtn.isHidden = true
                    rsendInvitationBtn.isHidden = true
                    
                }
            }
            
        }else {
            notConnectedView.isHidden = false
            
        }
        
    }
    
    func customiseNavBar(){
        
        self.title = "Profile"
        
//        let favBtn = UIButton(type: UIButtonType.custom)
//        favBtn.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
//        favBtn.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControlState.selected)
//        //            favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControlEvents.touchUpInside)
//        favBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let favButton = UIBarButtonItem(customView: favBtn)
//
//        //            favBtn?.isSelected = isFav!
//
//        let shareBtn: UIButton = UIButton(type: UIButtonType.custom)
//        shareBtn.setImage(#imageLiteral(resourceName: "share"),for: .normal)
//        //            shareBtn.addTarget(self, action: #selector(shareRecipeBtnTapped), for: UIControlEvents.touchUpInside)
//        shareBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let shareButton = UIBarButtonItem(customView: shareBtn)
//
//
//
//        self.navigationItem.rightBarButtonItems = [ favButton]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc  func filterPressed(){
    }
    
    
    @IBAction func infoButtonSelected(_ sender : Any){ // info button slection action
        infoBtn.isSelected = true
        recipeBtn.isSelected = false
        infoView.isHidden = false
        recipeView.isHidden = true
        
    }
    
    @IBAction func recipeButtonSelected(_ sender : Any){ // recipe button slection action
        infoBtn.isSelected = false
        recipeBtn.isSelected = true
        infoView.isHidden = true
        recipeView.isHidden = false
    }
    
    
    
    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func callMyProfileAPI(){ // profile webservice selction
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getUserDetails(userID: userId, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.userDetail = response
            
            if (self.userDetail?.interests?.count)! > 0 {
            }
            
             if let followers = self.userDetail?.followerscount {
                                 self.followersCountLabel.text = "\(followers)"
                             }
                             if let following = self.userDetail?.followingcount {
                                         self.followingCountLabel.text = "\(following)"
                                     }
                    
            
            if let photo = self.userDetail?.photo , !photo.isEmpty{
                let imageUrl:URL = URL(string: photo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
                self.profileImageView.kf.setImage(with: imageUrl, options: [.forceRefresh])
            }
            
            if let badgephoto = self.userDetail?.gamification?.image , !badgephoto.isEmpty{
                let imageUrlnew:URL = URL(string: badgephoto.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
                self.badgeImageView.kf.setImage(with: imageUrlnew, options: [.forceRefresh])
            }
            
            if let points = self.userDetail?.gamification?.points{
                self.pointslabel.text = "\(points) points"
                
            }
            var name:String = ""
            if let firstname = self.userDetail?.firstName {
                name = firstname + " "
            }
            if let lastname = self.userDetail?.lastName {
                name = name + lastname
            }
            self.namelabel.text = name
            if let gender = self.userDetail?.gender {
                if gender == 1{
                    self.genderlabel.text = "Mr."
                }else{
                    self.genderlabel.text = "Miss"
                    
                }
            }
            if let email = self.userDetail?.email {
                if !email.isEmpty {
                    self.emaillabel.text = email
                    self.emaillabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                    
                }else{
                    self.emaillabel.text = "email id not added yet"
                    self.emaillabel.textColor = UIColor.red
                }
            }else{
                self.emaillabel.text = "email id not added yet"
                self.emaillabel.textColor = UIColor.red
            }
            
//            if let birthdate = self.userDetail?.birthdate?.date {
//                if !birthdate.isEmpty {
//                    self.birthdatelabel.text = birthdate
//                    self.birthdatelabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
//
//                }else{
//                    self.birthdatelabel.text = "birthdate not added yet"
//                    self.birthdatelabel.textColor = UIColor.red
//                }
//
//            }else{
//                self.birthdatelabel.text = "birthdate not added yet"
//                self.birthdatelabel.textColor = UIColor.red
//            }
            self.birthdatelabel.text = ""
            self.birthdateHeadlabel.text = ""

            if let phone = self.userDetail?.phone {
                
                if !phone.isEmpty {
                    self.phonelabel.text = "\(phone)"
                    self.phonelabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                    
                }else{
                    self.phonelabel.text = "phone no. not added yet"
                    self.phonelabel.textColor = UIColor.red
                }
            }else{
                self.phonelabel.text = "phone no. not added yet"
                self.phonelabel.textColor = UIColor.red
            }
            
            
            var adresstring = ""
            
            if let adres = self.userDetail?.useraddress?.address {
                if !adres.isEmpty {
                    adresstring = adres
                }
            }
            
            adresstring = FFBaseClass.sharedInstance.toHtmlEncodedString(encodedString: adresstring)
            
            if let city = self.userDetail?.useraddress?.city {
                if !city.isEmpty {
                    adresstring = "\(adresstring) \n\(city)"
                }
            }
            if let country = self.userDetail?.useraddress?.country {
                if !country.isEmpty {
                    adresstring = "\(adresstring), \(country)"
                }
            }
            if adresstring == ""{
                self.basicaddresslabel.text = "address not addded yet"
                self.basicaddresslabel.textColor = UIColor.red
            }else{
                self.basicaddresslabel.text = adresstring
                self.basicaddresslabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                
            }
            
            
            if let compname = self.userDetail?.companyname {
                if !compname.isEmpty {
                    self.companyNamelabel.text = compname
                    self.companyNamelabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                    
                }else{
                    self.companyNamelabel.text = "company name not added yet"
                    self.companyNamelabel.textColor = UIColor.red
                }
                
            }else{
                self.companyNamelabel.text = "company name not added yet"
                self.companyNamelabel.textColor = UIColor.red
            }
            
            if let compno = self.userDetail?.companyidentificationnumber {
                if !compno.isEmpty {
                    self.companyNumberlabel.text = compno
                    self.companyNumberlabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                    
                }else{
                    self.companyNumberlabel.text = "company number not added yet"
                    self.companyNumberlabel.textColor = UIColor.red
                }
                
            }else{
                self.companyNumberlabel.text = "company number not added yet"
                self.companyNumberlabel.textColor = UIColor.red
            }
            
            
            var copmanyadresstring = ""
            
            if let adres = self.userDetail?.professionaladdress?.address {
                if !adres.isEmpty {
                    copmanyadresstring = adres
                }
            }
            
            copmanyadresstring = FFBaseClass.sharedInstance.toHtmlEncodedString(encodedString: copmanyadresstring)
            
            if let city = self.userDetail?.professionaladdress?.city {
                if !city.isEmpty {
                    copmanyadresstring = "\(copmanyadresstring) \n\(city)"
                }
            }
            if let country = self.userDetail?.professionaladdress?.country {
                if !country.isEmpty {
                    copmanyadresstring = "\(copmanyadresstring), \(country)"
                }
            }
            if copmanyadresstring == ""{
                self.companyAddresslabel.text = "professional address not addded yet"
                self.companyAddresslabel.textColor = UIColor.red
            }else{
                self.companyAddresslabel.text = copmanyadresstring
                self.companyAddresslabel.textColor = #colorLiteral(red: 0.5303090215, green: 0.7857728004, blue: 0, alpha: 1)
                
            }
            
            if let isprofessional = self.userDetail?.isProfessional{
                if isprofessional == 1{
                    self.areyouproffesionalLabelHC.constant = 0
                    self.areyouproffesionalOptionHC.constant = 0
                    self.yesBtn.isHidden = true
                    self.noBtn.isHidden = true
                    let superview = self.yesBtn.superview
                    let tick = superview?.viewWithTag(100) as! UIImageView
                    tick.isHidden = true
                    let superview1 = self.noBtn.superview
                    let tick1 = superview1?.viewWithTag(100) as! UIImageView
                    tick1.isHidden = true
                    
                    self.companyNameHeadlabel.text = "Company Name"
                    self.companyNumberHeadlabel.text = "Company Indentification Number"
                    self.companyAddressHeadlabel.text = "Professional Address"
                    
                }else{
                    self.companyNamelabel.text = ""
                    self.companyNameHeadlabel.text = ""
                    self.companyNumberlabel.text = ""
                    self.companyNumberHeadlabel.text = ""
                    self.companyAddresslabel.text = ""
                    self.companyAddressHeadlabel.text = ""
                    self.editProfessionalAddressBtn.isHidden = true
                    self.editProfessionalProfileBtn.isHidden = true
                    
                    self.yesBtn.isSelected = false
                    self.noBtn.isSelected = false
                    
                    self.hideOrShowTick(btn: self.yesBtn, shouldShow: false)
                    self.hideOrShowTick(btn: self.noBtn, shouldShow: false)
                    
                    self.noBtn.isSelected = true
                    self.hideOrShowTick(btn: self.noBtn, shouldShow: true)

                }
            }
            
            if let usr = FFBaseClass.sharedInstance.getUser() , self.userId == usr.id {
                self.reditProfileBtn.isHidden = false
                self.reditProfileBtnHC.constant = 40.0

                //                checkFreind(userid: userId)
            }else {
                self.hideSectionsforMember()
            }
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callMyRecipesAPI(){ // recipe list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyRecipesList(userID:userId,success: { (response) in
            self.recipeList = response
            FFLoaderView.hideInView(view: self.view)
            if self.recipeList.count > 0 {
                self.recipeTableView.isHidden = false
            }else {
                self.recipeTableView.isHidden = true
            }
            self.recipeTableView.reloadData()
            //            self.recipeTableViewHeightConstraint.constant = self.recipeTableView.contentSize.height
            self.recipeTableViewHeightConstraint.constant = CGFloat(90 * self.recipeList.count)
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    
    
    //MARK:- TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
        cell.responseObject = self.recipeList[indexPath.row]
        cell.refreshCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
        vc.recipeId = recipeList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editProfileBtntapped(_ sender : Any){ // edit profile button action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! FFEditProfileViewController
        vc.userDetail = self.userDetail
        self.navigationController?.pushViewController(vc, animated: true)        
    }
    
    
    @IBAction func sendMsgBtntapped(_ sender : Any){ // message button slection action
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! FFMessagingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func sendInvitationBtntapped(_ sender : Any){ // invittation send buttona ction
        
        if let nname =   self.userDetail?.nickName {
            callSearchFriendByNicknameAPI(nickname: nname)
        }else if let email = self.userDetail?.email {
            callInviteFriendAPI(email: email)
        }
        
        
    }
    
    func callInviteFriendAPI(email:String?){ // invite friend webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByEmail(email: email, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.sendInvitationBtn.isEnabled = false
            self.sendInvitationBtn.alpha = 0.5
            self.rsendInvitationBtn.isEnabled = false
            self.rsendInvitationBtn.alpha = 0.5
            
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callSearchFriendByNicknameAPI(nickname:String){ // search friend wewbservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addFriendByNickname(nickname: nickname, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            self.sendInvitationBtn.isEnabled = false
            self.sendInvitationBtn.alpha = 0.5
            self.rsendInvitationBtn.isEnabled = false
            self.rsendInvitationBtn.alpha = 0.5
            
            FFBaseClass.sharedInstance.showAlert(mesage: response.message ?? "", view: self)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    //MARK:- CollectionView functions
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let interestlist = userDetail?.interests {
//            return interestlist.count
//        }else {
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
//        let label = cell.viewWithTag(100) as! UILabel
//        label.numberOfLines = 0
//        label.text = userDetail?.interests![indexPath.row].name
//        label.sizeToFit()
//        label.layer.cornerRadius = 5
//        label.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
//        label.layer.borderWidth = 1
//
//        return cell
//    }
    
        
    
    @IBAction func editbasicProfileBtntapped(_ sender : Any){ // basic Profile action
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! FFEditProfileViewController
        vc.userDetail = self.userDetail
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func editProfessionalBtntapped(_ sender : Any){ // Professional button slection action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFProfessionalInfoVC") as! FFProfessionalInfoVC
        vc.userId = userDetail?.id
        vc.userDetail = self.userDetail

        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    @IBAction func changePasswordBtntapped(_ sender : Any){ // change Password button slection action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFChangePasswordVC") as! FFChangePasswordVC
        vc.userId = userDetail?.id
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    @IBAction func editpersonaladdressBtntapped(_ sender : Any){ // change Password button slection action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFUpdateAddressVC") as! FFUpdateAddressVC
        vc.userId = userDetail?.id
        vc.isProfessional = false
        vc.addressTypeId = 1
        vc.addressObject = self.userDetail?.useraddress
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func editprofessionaladdressBtntapped(_ sender : Any){ // change Password button slection action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFUpdateAddressVC") as! FFUpdateAddressVC
        vc.userId = userDetail?.id
        vc.addressTypeId = 2
        vc.addressObject = self.userDetail?.professionaladdress
        vc.isProfessional = true
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
   @IBAction func followersBtntapped(_ sender : Any){ // followers button slection action
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC") as! FFFollowViewController
    vc.selectedTab = 0
    vc.fromWhere = "profile"
    vc.userId = userId
    self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func followingBtntapped(_ sender : Any){ // following button slection action
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFollowVC") as! FFFollowViewController
        vc.selectedTab = 1
        vc.fromWhere = "profile"
        vc.userId = userId
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
