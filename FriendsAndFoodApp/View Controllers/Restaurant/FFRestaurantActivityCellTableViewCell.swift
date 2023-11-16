//
//  FFRestaurantActivityCellTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 25/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Cosmos

class FFRestaurantActivityCellTableViewCell: UITableViewCell {

    var restaurantObj:FFRestaurantObject?
    
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var distanceLabel:UILabel!
    @IBOutlet weak var adrslabel:UILabel!
    @IBOutlet weak var citylabel:UILabel!
    @IBOutlet weak var ratingView:CosmosView!
    @IBOutlet weak var ratinglabel:UILabel!

    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){ // data populate function
        
        if let photo = restaurantObj?.images?.first?.name {
            let imageUrl:URL = URL(string: photo)!
            imgView.kf.setImage(with: imageUrl)
        }
        
        nameLabel.text = self.restaurantObj?.name
        if let adrs = restaurantObj?.address , let postalcode = restaurantObj?.postalcode {
            adrslabel.text =  "\(adrs), \(postalcode)"
        }
        if let city = restaurantObj?.city , let country = restaurantObj?.country {
            citylabel.text = "\(city) - \(country)"
        }
        ratingView.settings.fillMode = .half
        if let rating = restaurantObj?.rating {
            ratingView.rating = Double((rating) ?? 0)
            ratinglabel.text = "\(rating)/5"
        }
        
    }

}
