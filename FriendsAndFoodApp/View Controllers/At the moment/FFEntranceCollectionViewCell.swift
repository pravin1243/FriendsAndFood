//
//  FFEntranceCollectionViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Kingfisher

protocol EntranceCellDelegate{
    func shareBtnPressed(url:String)
}

class FFEntranceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageCount: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nutritionLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var responseObject:FFEntranceObject?
    var entranceDelegate:EntranceCellDelegate?
    func refreshCell(){
        
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.clipsToBounds = true
        
        nutritionLabel.layer.cornerRadius = 5
        nutritionLabel.clipsToBounds = true
        
        titleLabel.text = responseObject?.name
        if let imgCnt = responseObject?.nbImages {
            imageCount.text = "\(imgCnt)"
        }
        if let theme = responseObject?.types?.first?.name_normalized {
            themeLabel.text = "  " + theme.uppercased() + "  "
            
        }
        
        if let category = responseObject?.interests?.first?.name_normalized {
            categoryLabel.text  = " " + category.capitalized + " "
            
        }
        
//        if let imageList = responseObject?.imageArray {
//            let imageUrl:URL = URL(string: (imageList.first?.name)!)!
//            imageView.kf.setImage(with: imageUrl.standardizedFileURL)
//        }
        
        if let imageMedeium = responseObject?.imageMedium {
            let imageUrl:URL = URL(string: imageMedeium)!
            imageView.kf.setImage(with: imageUrl)
        }

        var calorieCount = 0
        if let ingredienrts = responseObject?.ingredients {
            for ingredient:FFRecipeTypeObject in ingredienrts {
                if let nutritionArray = ingredient.nutritions {
                    for nutrient:FFRecipeTypeObject in nutritionArray {
                        if nutrient.name == "calories" {
                            calorieCount = calorieCount + Int(nutrient.quantity!)!
                    }
                }
            }
        }
        
    }
        if let calorie = responseObject?.noofcalories {
            if calorie == ""{
                nutritionLabel.text = " \(StringConstants.Labels.zerocal) "

            }else{
                nutritionLabel.text = " \(calorie) "
            }
        }
    }
    
    @IBAction func favoriteTapped(_ sender : Any){
    
    }
    
    @IBAction func shareTapped(_ sender : Any){
        if let id = self.responseObject?.id, let name = responseObject?.nameNormalised {
            let shareUrl:String = "http://ff.mydigitalys.com/r-" + "\(id)" + "-" + name
            if let delegate = self.entranceDelegate {
                delegate.shareBtnPressed(url: shareUrl)
            }
        }
        
    }
    
}
