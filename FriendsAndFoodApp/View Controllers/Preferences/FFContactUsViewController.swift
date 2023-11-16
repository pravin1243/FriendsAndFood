//
//  FFContactUsViewController.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 01/08/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SideMenu

class FFContactUsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView:UIWebView!
    
    var isContactUs :Bool?
    
    override func viewDidLoad() { // load contact us and CGU URLs in webview
        super.viewDidLoad()

        if isContactUs == true {
        self.title = "Contact Us"
            
            
            webView.loadRequest(URLRequest(url: URL(string: "http://ff.mydigitalys.com/contact.php")!))
            
            
        }else {
        self.title = "CGU"
            webView.loadRequest(URLRequest(url: URL(string: "\(StringConstants.cgu.cgu_url)")!))
        }
      

        webView.delegate = self
//        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu)), animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func showMenu(){
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        FFLoaderView.hideInView(view: self.view)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        FFLoaderView.showInView(view: self.view)
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
