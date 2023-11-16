//
//  FFStoreTypeTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFStoreTypeTableViewCell: UITableViewCell {

//    @IBOutlet weak var storeTypeView:UIView!
    @IBOutlet weak var firstLetterView:UIView!

    @IBOutlet weak var firstLetterLabel:UILabel!
    @IBOutlet weak var storeTypeName:UILabel!
    var fromMenu:Bool?

    var storeTypeObject: FFStoreTypeObject?
//    @IBOutlet
//    weak var storeTypeView: UIView! {
//        didSet {
//            // Make it card-like
////            storeTypeView.layer.cornerRadius = 10
////            storeTypeView.layer.shadowOpacity = 1
////            storeTypeView.layer.shadowRadius = 2
////            storeTypeView.layer.shadowColor = UIColor.gray.cgColor
////            storeTypeView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        storeTypeView.layer.cornerRadius = 10
//        storeTypeView.clipsToBounds = true
        firstLetterView.layer.cornerRadius = self.firstLetterView.frame.width/2
        firstLetterView.clipsToBounds = true
        firstLetterView.layer.borderColor = UIColor.black.cgColor
        firstLetterView.layer.borderWidth = 1.5
        firstLetterView.backgroundColor = .random()
//        storeTypeView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
//        storeTypeView.addShadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshCell(){
        if let name = storeTypeObject?.name{
        let firstLetter = name[name.index(name.startIndex, offsetBy: 0)]

            let first = String(firstLetter)
            firstLetterLabel.text = first.capitalizingFirstLetter()
            
            if fromMenu == true{
                storeTypeName.text = "\(storeTypeObject?.name?.capitalizingFirstLetter() ?? "")"
            }else{
                storeTypeName.text = "\(storeTypeObject?.name?.capitalizingFirstLetter() ?? "")"

            }
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
