//
//  FFMenuTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 04/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel:UILabel!
    @IBOutlet weak var expandButton:UIButton!

    @IBOutlet weak var menuLabel:UILabel!

    
    @IBOutlet weak var currencyLabel:UILabel!
    @IBOutlet weak var editButton:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
