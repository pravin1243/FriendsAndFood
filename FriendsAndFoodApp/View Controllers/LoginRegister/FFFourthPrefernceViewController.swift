//
//  FFFourthPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/2/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFFourthPrefernceViewController: UIViewController {
    @IBOutlet weak var headLabel:UILabel!
    @IBOutlet weak var subheadLabel:UILabel!
    @IBOutlet weak var skipButton:UIButton!

    @IBOutlet weak var levelLabel:UILabel!

    
    @IBOutlet weak var levelSlider:UISlider!
    var expertList:[FFExpertiseLevelObject] = []
    var expertiseLevelRequest = FFAddExpertiseLevelRequestModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        headLabel.text = "\(StringConstants.userPreference.Indicateyourlevelincooking)"
        subheadLabel.text = "\(StringConstants.userPreference.thisisindicativeinorder)"
        skipButton.setTitle("\(StringConstants.userPreference.Everythingsuitsme)", for: .normal)
        levelSlider.setThumbImage(UIImage(named: "slider-noshadow"), for: .normal)
        levelSlider.maximumTrackTintColor = UIColor.gray
        levelSlider.minimumTrackTintColor = UIColor.primary
        loadExpertLevel()
        // Do any additional setup after loading the view.
    }
    
    func loadExpertLevel(){ // language list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getExpertiseLevelList(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.expertList = responce
            self.levelLabel.text = "\(self.expertList[0].name ?? "")"
            self.expertiseLevelRequest.expertiselevelid = self.expertList[0].globalexpertiselevelid
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func addExpertLevel(){
  
        if let user = FFBaseClass.sharedInstance.getUser() {
            if let userid = user.id {
                expertiseLevelRequest.id = "\(userid)"
            }
        }
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.addExpertiseLevel(expertiseLevelRequest: self.expertiseLevelRequest, success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFifthPrefernceVC") as! FFFifthPrefernceViewController
           self.navigationController?.pushViewController(vc, animated: true)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    @IBAction func skipAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFifthPrefernceVC") as! FFFifthPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextButton(_ sender: UIButton){
        self.addExpertLevel()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        let slideValue = self.levelSlider.value
        
        if (1...1.5).contains(slideValue) {
            self.levelLabel.text = "\(expertList[0].name ?? "")"
            self.expertiseLevelRequest.expertiselevelid = self.expertList[0].globalexpertiselevelid

            print("Number is inside the Beginner range")
        }

        if (1.5...2.5).contains(slideValue) {
            self.levelLabel.text = "\(expertList[1].name ?? "")"
            self.expertiseLevelRequest.expertiselevelid = self.expertList[1].globalexpertiselevelid

            print("Number is inside the Intermediate range")
        }
        
        if (2.5...3).contains(slideValue) {
            self.levelLabel.text = "\(expertList[2].name ?? "")"
            self.expertiseLevelRequest.expertiselevelid = self.expertList[2].globalexpertiselevelid

            print("Number is inside the Expert range")
        }
//         self.showSliderValue.text = “\(self.appSlider.value)”
    }


}
class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
    }

    
}
