//
//  FFLaunchViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFLaunchViewController: UIViewController {
    
    @IBOutlet weak var gifImageView:UIImageView!
    var timerTest : Timer?
    var langCodes = [String]()
    override func viewDidLoad() { // show launch animation
        super.viewDidLoad()
        
        let isJustInstalled = FFBaseClass.sharedInstance.getStringValue(key: "isJustInstalled")
        if isJustInstalled == "no"{
            
        }else{
            self.loadLanguages()
            
        }

        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            let isJustInstalled = FFBaseClass.sharedInstance.getStringValue(key: "isJustInstalled")
            if isJustInstalled == "no"{
                
                if let _ = FFBaseClass.sharedInstance.getUser() {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
                    self.navigationController?.pushViewController(vc, animated: true)

                }else {
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
                    loginVC.isFirstLaunch = true
                    self.navigationController?.pushViewController(loginVC, animated: true)

                }
            }else{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! FFLoginViewController
                loginVC.isFirstLaunch = true
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
        gifImageView.loadGif(name: "loader-ff")
    }
    
    
    func loadLanguages(){ // language list webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getLanguages(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            for i in 0...responce.count - 1{
                self.langCodes.append(responce[i].code ?? "")
            }
            let deviceLangauge = Locale.current.languageCode
            if self.langCodes.contains(deviceLangauge ?? ""){
                if deviceLangauge == "fr"{
                    self.callChangeLanguageService(.french)
                }else if deviceLangauge == "en"{
                    self.callChangeLanguageService(.english)
                }else if deviceLangauge == "it"{
                    self.callChangeLanguageService(.italian)
                }else if deviceLangauge == "de"{
                    self.callChangeLanguageService(.german)
                }else if deviceLangauge == "es"{
                    self.callChangeLanguageService(.spanish)
                }
            }else{
                self.callChangeLanguageService(.english)
            }
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    
    func callChangeLanguageService(_ lang: Localization){

          Localization.language = lang
          }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
