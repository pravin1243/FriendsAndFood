//
//  FFMyInterestTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/30/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
protocol  InterestCellDelegate {
    func interestLikePressed(id: String?)
    func interestDisLikePressed(id: String?)
}
class FFMyInterestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var recipeImageview:UIImageView!
    @IBOutlet weak var favBtn:UIButton!
    var interestObj:FFRecipeTypeObject?
    var interestDelegate:InterestCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshCell(){
        nameLabel.text = interestObj?.name
        
        let imageUrl:URL = URL(string: (interestObj?.imageSmall)!)!
        recipeImageview.kf.setImage(with: imageUrl)
        
        if let isFav = interestObj?.checked , isFav == 0 {
            favBtn.isSelected = false
        }else {
            favBtn.isSelected = true
        }
        
    }
    
    
    @IBAction func selectBtnTapped(_ sender : Any){
        if let delegate = self.interestDelegate {
            if favBtn.isSelected {
                delegate.interestDisLikePressed(id: "\(interestObj?.id ?? 0)")
            }else {
                delegate.interestLikePressed(id: "\(interestObj?.id ?? 0)")
            }
        }
        
    }
}
