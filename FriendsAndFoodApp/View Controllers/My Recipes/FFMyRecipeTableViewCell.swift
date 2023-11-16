//
//  FFMyRecipeTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/22/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

protocol RecipeCellDelegate {
    func recipeLikePressed(id: Int?)
    func recipeDisLikePressed(id: Int?)
    func editRecipeTapped(obj: FFEntranceObject?)
    func deleteRecipeTapped(obj: FFEntranceObject?)
}

class FFMyRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var themeLabel:UILabel!
    @IBOutlet weak var calorieLabel:UILabel!
    @IBOutlet weak var favoriteLabel:UILabel!
    @IBOutlet weak var recipeImageview:UIImageView!
    @IBOutlet weak var favBtn:UIButton!
    
    var cellDelegate:RecipeCellDelegate?

    
    var recipeObj:FFEntranceObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
        
        nameLabel.text = recipeObj?.name
        if let category = recipeObj?.interests?.first?.name_normalized {
            themeLabel.text  = category.capitalized
            
        }else {
            themeLabel.text = "Other"
        }
        
        if let imageList = recipeObj?.imageSmall {
            let imageUrl:URL = URL(string: imageList)!
            recipeImageview.kf.setImage(with: imageUrl)
        }
        
        if let calorie = recipeObj?.noofcalories {
            if calorie == ""{
                calorieLabel.text = " \(StringConstants.Labels.zerocal) "

            }else{
                calorieLabel.text = " \(calorie) "
            }

        }
        
        calorieLabel.layer.cornerRadius = 2
        calorieLabel.clipsToBounds = true
        
    }
    
    func likeRecipe(){
        favBtn.isSelected = true
        favoriteLabel.text = "I no longer like"
    }
    
    func dislikeRecipe(){
        favBtn.isSelected = false
        favoriteLabel.text = "I like"
    }
    
    @IBAction func favoriteBtnTapped(_ sender :Any){

        if let delegate = self.cellDelegate {
          delegate.recipeDisLikePressed(id: recipeObj?.id)
        }
        
    }
    
    @IBAction func editBtnTapped(_ sender :Any){
         if let delegate = self.cellDelegate {
            delegate.editRecipeTapped(obj: self.recipeObj)
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender :Any){
        if let delegate = self.cellDelegate {
            delegate.deleteRecipeTapped(obj: self.recipeObj)
        }
    }

}
