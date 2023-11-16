//
//  FFDishTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFDishTableViewCell: UITableViewCell {

    var interest:FFRecipeTypeObject?
    @IBOutlet weak var dishImageview:UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
        if let interst = interest {
            nameLabel.text = interst.name
            let imageUrl:URL = URL(string: interst.imageSmall!)!
            dishImageview.kf.setImage(with:imageUrl )
        }
      
    }

}
