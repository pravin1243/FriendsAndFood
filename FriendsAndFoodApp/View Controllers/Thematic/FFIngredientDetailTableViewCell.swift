//
//  FFIngredientDetailTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 21/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFIngredientDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var infoBtn:UIButton!
    @IBOutlet weak var recipeBtn:UIButton!
    @IBOutlet weak var nutritionBtn:UIButton!

    @IBOutlet weak var infoSelectedView:UIImageView!
    @IBOutlet weak var recpSelectedView:UIImageView!
    @IBOutlet weak var nutritionSelectedView:UIImageView!

    @IBOutlet weak var janView:UIView!
    @IBOutlet weak var janLbl:UILabel!
    @IBOutlet weak var febView:UIView!
    @IBOutlet weak var febLbl:UILabel!
    @IBOutlet weak var marchView:UIView!
    @IBOutlet weak var marchLbl:UILabel!
    @IBOutlet weak var aprilView:UIView!
    @IBOutlet weak var aprilLbl:UILabel!
    @IBOutlet weak var mayView:UIView!
    @IBOutlet weak var mayLbl:UILabel!
    @IBOutlet weak var junView:UIView!
    @IBOutlet weak var junLbl:UILabel!
    @IBOutlet weak var julyView:UIView!
    @IBOutlet weak var julyLbl:UILabel!
    @IBOutlet weak var augustView:UIView!
    @IBOutlet weak var augustLbl:UILabel!
    @IBOutlet weak var sepView:UIView!
    @IBOutlet weak var sepLbl:UILabel!
    @IBOutlet weak var octView:UIView!
    @IBOutlet weak var octLbl:UILabel!
    @IBOutlet weak var novView:UIView!
    @IBOutlet weak var novLbl:UILabel!
    @IBOutlet weak var decView:UIView!
    @IBOutlet weak var decLbl:UILabel!

    
    @IBOutlet weak var faqQuestionLbl:UILabel!
    @IBOutlet weak var faqAnswerLbl:UILabel!
    @IBOutlet weak var showHideFaqBtn:UIButton!
    
    @IBOutlet weak var nutritionNameLbl:UILabel!
    @IBOutlet weak var nutritionUnitLbl:UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
     //   self.faqAnswerLbl.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
       // self.faqAnswerLbl.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
