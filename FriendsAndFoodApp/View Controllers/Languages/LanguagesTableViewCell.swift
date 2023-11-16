//
//  LanguagesTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class LanguagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var langView:UIView!

    @IBOutlet weak var langLabel:UILabel!
    @IBOutlet weak var langImageview:UIImageView!

    var langObject: FFLanguageObject?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        langView.layer.cornerRadius = 10
        langView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
        langLabel.text = langObject?.name
        
        let imageUrl:URL = URL(string: (langObject?.flag)!)!
        langImageview.kf.setImage(with: imageUrl)
    
        
    }


}
