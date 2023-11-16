//
//  SenderCell.swift
//  Bizzalley
//
//  Created by Anuj Jha on 09/03/17.
//  Copyright © 2017 Anuj Jha. All rights reserved.
//

import UIKit

protocol deleteMsgDelegate {
    func deleteMsg()
}

class SenderCell: UITableViewCell {
    @IBOutlet weak var senderMessageLabel: UILabel!
    @IBOutlet weak var tickMsgImageView: UIImageView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tickImgaeWidthConstraint: NSLayoutConstraint!
    
    var delegate: deleteMsgDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        msgView.layer.cornerRadius = 5
//        msgView.layer.masksToBounds = true
        msgView.createShadow()
        senderMessageLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.msgView.roundSenderCorners([.topLeft, .bottomLeft, .topRight], radius: 10)
    }
    
    func deleteMessageActionTapped(sender: Any){
        if delegate != nil{
            delegate?.deleteMsg()
        }
        
    }
}
extension UIView {

//    func createShadow(_ color : UIColor? = nil, opacity : Float? = nil, radius : CGFloat? = nil, width : CGFloat? = nil, height : CGFloat? = nil) {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = color != nil ? color!.cgColor : UIColor.black.cgColor
//        self.layer.shadowOpacity = opacity != nil ? opacity! : 0.3
//        self.layer.shadowRadius = radius != nil ? radius! : 4.0
//        self.layer.shadowOffset = CGSize(width: (width != nil ? width! : 1.0), height: (height != nil ? height! : 3.0))
//    }
    
//    static var nibInstance : UIView? { return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView }
    
    func roundReceiverCorners(_ corners: UIRectCorner, radius: CGFloat) {
         //let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         //let mask = CAShapeLayer()
         //mask.path = path.cgPath
         //self.layer.mask = mask
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func roundSenderCorners(_ corners: UIRectCorner, radius: CGFloat) {
         //let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         //let mask = CAShapeLayer()
         //mask.path = path.cgPath
         //self.layer.mask = mask
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
    }

}
