//
//  FFCategoryDetailTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/15/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Cosmos

class FFCategoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView:UIImageView!
    @IBOutlet weak var namelabel:UILabel!
    @IBOutlet weak var calorielabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var rateView:CosmosView!
    @IBOutlet weak var ratingLabel:UILabel!
    
    var responseObject:FFEntranceObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
        
        calorielabel.layer.cornerRadius = 5
        descriptionLabel.layer.cornerRadius = 5
        
        namelabel.text = responseObject?.name
        if let category = responseObject?.cat_name_normalized {
            descriptionLabel.text  = " " + category.capitalized + " "
            
        }
        
//        if let imageList = responseObject?.imageArray {
//            let imageUrl:URL = URL(string: (imageList.first?.name)!)!
//            recipeImageView.kf.setImage(with: imageUrl)
//        }
        
        if let imageSmall = responseObject?.imageSmall {
            let imageUrl:URL = URL(string: imageSmall)!
            recipeImageView.kf.setImage(with: imageUrl)
        }
        
        
        if let calorie = responseObject?.noofcalories {
            if calorie == ""{
                calorielabel.text = " \(StringConstants.Labels.zerocal) "

            }else{
                calorielabel.text = " \(calorie) "
            }
        }

        
        if let score = responseObject?.score {
            ratingLabel.text = "\(score)/5"
            rateView.rating = Double(score)
        }
        
    }

}
