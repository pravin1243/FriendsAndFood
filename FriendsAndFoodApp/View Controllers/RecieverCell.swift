//
//  RecieverCell.swift
//  Bizzalley
//
//  Created by Anuj Jha on 09/03/17.
//  Copyright © 2017 Anuj Jha. All rights reserved.
//

import UIKit

class RecieverCell: UITableViewCell {

    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var recieverMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var delegate: deleteMsgDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recieverMessageLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           
           self.bgView.roundReceiverCorners([.topLeft, .bottomRight, .topRight], radius: 10)
       }
    
    func deleteMessageActionTapped(sender:Any){
        if delegate != nil{
            delegate?.deleteMsg()
        }
        
    }
}
