//
//  FFMessagingViewController.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 11/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFMessagingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var msgTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTableView.dataSource = self
        msgTableView.delegate = self
        
        self.title  = "Messaging"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell")
        let label = cell?.viewWithTag(100) as! UILabel
        label.text = "Friend \(indexPath.row + 1)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! FFChatViewController
        vc.chatTitle = "Friend \(indexPath.row + 1)"
        self.navigationController?.pushViewController(vc, animated: true)
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
