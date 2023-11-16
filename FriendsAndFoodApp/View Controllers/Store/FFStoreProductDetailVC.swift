//
//  FFStoreProductDetailVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 10/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFStoreProductDetailVC: UIViewController {

    @IBOutlet weak var productImage:UIImageView!
    @IBOutlet weak var productNameLabel:UILabel!
    @IBOutlet weak var productPriceLabel:UILabel!
    @IBOutlet weak var productWeightLabel:UILabel!
    @IBOutlet weak var productDescriptionLabel:UILabel!
    @IBOutlet weak var productDescriptionLabelHeight:NSLayoutConstraint!
    var storeProductObject: FFStoreProductsObject?
    var isLabelAtMaxHeight = false
    @IBOutlet weak var seeMoreButton:UIButton!
    var storeName: String?
    var descconstant: Int?
    var favBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = storeName
        if let _ = storeProductObject{
            populateData()
        }
//        customiseNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func customiseNavigationBar(){ // add fav button and share button in navigation bar
        
        
        favBtn = UIButton(type: UIButton.ButtonType.custom)
        favBtn?.setImage(#imageLiteral(resourceName: "FavGreyBig") , for: .normal)
        favBtn?.setImage(#imageLiteral(resourceName: "FavRecipeRed"), for: UIControl.State.selected)
        favBtn?.addTarget(self, action: #selector(favBtnTapped), for: UIControl.Event.touchUpInside)
        favBtn?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let favButton = UIBarButtonItem(customView: favBtn!)
        
        
        self.navigationItem.rightBarButtonItems = [ favButton]
    }
    @objc func favBtnTapped(){ // favorite button action
    }
    func populateData(){
        if let photo = storeProductObject?.imagemedium {
                   let imageUrl:URL = URL(string: photo)!
                   productImage.kf.setImage(with: imageUrl)
               }
        if let name = storeProductObject?.name {
            productNameLabel.text = name
        }
        if let price = storeProductObject?.price {
            if price.isEmpty{
                productPriceLabel.text = " - "
            }else{
            productPriceLabel.text = "\(storeProductObject?.currency?.symbol ?? "") \(price)"
            }
        }
        if let weight = storeProductObject?.weight {
            productWeightLabel.text = "\(weight) \(storeProductObject?.measurecode ?? "")"
        }
        if let desc = storeProductObject?.productdescription {
            productDescriptionLabel.text = desc
            descconstant = Int(getLabelHeight(text: productDescriptionLabel.text ?? "", width: view.bounds.width, font: productDescriptionLabel.font))

            if descconstant ?? 0 < 70{
                self.seeMoreButton.isHidden = true
                productDescriptionLabelHeight.constant = getLabelHeight(text: productDescriptionLabel.text ?? "", width: view.bounds.width, font: productDescriptionLabel.font)

            }else{
                productDescriptionLabelHeight.constant = 70
            }
            
        }
    }
    
    @IBAction func seeMoreTapped(_ sender: UIButton){
        

        
        if isLabelAtMaxHeight {
            seeMoreButton.setTitle("Read more", for: .normal)
            isLabelAtMaxHeight = false
                productDescriptionLabelHeight.constant = 70
        }
        else {
            seeMoreButton.setTitle("Read less", for: .normal)
            isLabelAtMaxHeight = true
            productDescriptionLabelHeight.constant = getLabelHeight(text: productDescriptionLabel.text ?? "", width: productDescriptionLabel.bounds.width, font: productDescriptionLabel.font)
        }
        
    }

    func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
           let lbl = UILabel(frame: .zero)
           lbl.frame.size.width = width
           lbl.font = font
           lbl.numberOfLines = 0
           lbl.text = text
           lbl.sizeToFit()

           return lbl.frame.size.height
       }
}
