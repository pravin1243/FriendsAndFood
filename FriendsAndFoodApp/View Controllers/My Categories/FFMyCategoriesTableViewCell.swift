//
//  FFMyCategoriesTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
protocol  CategoryCellDelegate {
    func categoryLikePressed(id: String?)
    func categoryDisLikePressed(id: String?)
}

class FFMyCategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var recipeImageview:UIImageView!
    @IBOutlet weak var favBtn:UIButton!
    @IBOutlet weak var favLabel:UILabel!
    var categoryObj:FFRecipeTypeObject?
    var categoryDelegate:CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func refreshCell(){
        nameLabel.text = categoryObj?.name
        let imageUrl:URL = URL(string: (categoryObj?.imageSmall)!)!
        recipeImageview.kf.setImage(with: imageUrl)
        if let isFav = categoryObj?.checkedInt , isFav == 0 {
            favBtn.isSelected = false
            favLabel.text = "I no longer like"
        }else {
            favBtn.isSelected = true
            favLabel.text = "I like"
        }
    }
    
    @IBAction func favBtnTapped(_ sender : Any){
        if let delegate = self.categoryDelegate {
            if favBtn.isSelected {
                delegate.categoryDisLikePressed(id: "\(categoryObj?.id ?? 0)")
            }else {
                delegate.categoryLikePressed(id: "\(categoryObj?.id ?? 0)")
            }
        }
    }
    

}
