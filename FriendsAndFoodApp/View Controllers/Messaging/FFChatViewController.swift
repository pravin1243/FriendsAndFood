//
//  FFChatViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chatTableView:UITableView!
    @IBOutlet weak var chatTextField:UITextField!
    
    var chatTitle:String?
    var userId:Int?

    var chatArray:[String] = ["Hi","Hi","How are you?","I am good","Ready For call?","Yes"]
    
    @IBOutlet weak var bottomLayoutConstraint:NSLayoutConstraint!
    
    var chatList:[FFMessageObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callGetMessagesAPI()
        self.title = "\(StringConstants.messaging.Messagingwith) \(chatTitle ?? "")"
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 50
        chatTableView.tableFooterView = UIView()
        registerNibs()
        
        chatTextField.becomeFirstResponder()
        //        chatTextField.autocorrectionType = .no
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        let BarButtonItemAppearance = UIBarButtonItem.appearance()
//        BarButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
            
            bottomLayoutConstraint.constant = keyboardHeight
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        bottomLayoutConstraint.constant = 0
    }
    func registerNibs() {
                chatTableView.separatorStyle = .none
              chatTableView.register(UINib.init(nibName: "TimeCell", bundle : nil), forCellReuseIdentifier: "TimeCell")
                chatTableView.register(UINib.init(nibName: "SenderCell", bundle : nil), forCellReuseIdentifier: "senderCell")
                chatTableView.register(UINib.init(nibName: "RecieverCell", bundle : nil), forCellReuseIdentifier: "recieverCell")
            }
    
     func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0{
                return 1
            }else{
                return chatList.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.setNeedsLayout()
            tableView.layoutIfNeeded()

            var returnCell: UITableViewCell = UITableViewCell()
            if indexPath.section == 0{
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as? TimeCell
                returnCell = timeCell!
            }
            if indexPath.section == 1{
                if chatList[indexPath.row].fromuserid == userId
                {
                    let recieverCell = tableView.dequeueReusableCell(withIdentifier: "recieverCell") as? RecieverCell
                    recieverCell?.recieverMessageLabel.text = chatList[indexPath.row].content
                    recieverCell?.timeLabel.text = chatList[indexPath.row].creationdate
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = dateFormatter.date(from: "\(chatList[indexPath.row].creationdate ?? "")")
                    {
                        if Calendar.current.isDateInToday(date){
                            let timeFormatter = DateFormatter()
                            timeFormatter.dateFormat = "HH:mm"
                            let timestring = timeFormatter.string(from: date)
                            recieverCell?.timeLabel.text = "\(timestring)"
                            

                        }else{
                            let datepastFormatter = DateFormatter()
                            datepastFormatter.dateFormat = "d MMM, HH:mm"
                            let timestring = datepastFormatter.string(from: date)
                            recieverCell?.timeLabel.text = "\(timestring)"

                            
                        }
                        
                    }

                    returnCell = recieverCell!

                }else{
                        let senderCell = tableView.dequeueReusableCell(withIdentifier: "senderCell") as? SenderCell
                        senderCell?.senderMessageLabel.text = chatList[indexPath.row].content
                    senderCell?.tickMsgImageView.isHidden = true
                    if let readDate = chatList[indexPath.row].readdate{
                        
                        senderCell?.tickMsgImageView.isHidden = false
                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = dateFormatter.date(from: "\(chatList[indexPath.row].creationdate ?? "")")
                    {
                    if Calendar.current.isDateInToday(date){
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "HH:mm"
                        let timestring = timeFormatter.string(from: date)
                        senderCell?.timeLabel.text = "\(timestring)"
                        

                    }else{
                        let datepastFormatter = DateFormatter()
                        datepastFormatter.dateFormat = "d MMM, HH:mm"
                        let timestring = datepastFormatter.string(from: date)
                        senderCell?.timeLabel.text = "\(timestring)"

                        
                    }
                        
                    }
                        returnCell = senderCell!

                }
            }
            return returnCell
        }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row % 2 == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell1")
//            let lbl = cell?.viewWithTag(100)  as! UILabel
//            lbl.text = chatArray[indexPath.row]
//            return cell!
//        }else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell2")
//            let lbl = cell?.viewWithTag(100)  as! UILabel
//            lbl.text = chatArray[indexPath.row]
//            return cell!
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    
    @IBAction func sendBtnPressed(_ sender : Any){
        
        if let txt = chatTextField.text {
            callSendMessageAPI()
//            chatArray.append(txt)
//            chatTableView.reloadData()
            chatTextField.text = ""
        }
    }
 
    func callGetMessagesAPI(){ // message list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getMyMessagesList(userID:userId,success: { (response) in
            self.chatList = response
            self.chatList = self.chatList.reversed()
            FFLoaderView.hideInView(view: self.view)
            if self.chatList.count > 0 {
                self.chatTableView.isHidden = false
            }else {
                self.chatTableView.isHidden = true
            }
            self.chatTableView.reloadData()
            
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    func callSendMessageAPI(){ // addreview webservice
            
                
                if let userId = userId {
                    FFLoaderView.showInView(view: self.view)
                    FFManagerClass.postMessage(userId: "\(userId)", message: chatTextField.text, success: { (response) in
                        print(response)
                        FFLoaderView.hideInView(view: self.view)
                        
                        self.callGetMessagesAPI()

                    }) { (error) in
                        print(error)
                        FFLoaderView.hideInView(view: self.view)
                        FFBaseClass.sharedInstance.showError(error: error, view: self)
                    }
                }
            
            
        }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
