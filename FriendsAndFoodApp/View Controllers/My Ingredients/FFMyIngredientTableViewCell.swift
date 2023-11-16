//
//  FFMyIngredientTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
protocol  IngredientCellDelegate {
//    func ingredientLikePressed(id: String?)
    func ingredientDisLikePressed(id: Int?)
}

class FFMyIngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var recipeImageview:UIImageView!
    var ingredientObj:FFEntranceObject?
    var ingredienDelegate:IngredientCellDelegate?
    @IBOutlet weak var unitLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func refreshCell(){
        
        nameLabel.text = ingredientObj?.name
        if let imageList = ingredientObj?.imageTypeArray {
            if let imageUrl:URL = URL(string: (imageList.first?.small ?? "")){
            recipeImageview.kf.setImage(with: imageUrl.standardizedFileURL)
            }
        }
    }
     @IBAction func favBtnTapped(_ sender : Any){
        
        if let delegate = ingredienDelegate {
            delegate.ingredientDisLikePressed(id: ingredientObj?.id)
        }
        
    }
    
}
