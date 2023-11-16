//
//  FFRecipeDetailRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/17/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFRecipeDetailRequestModel: FFBaseRequestModel {

    var recipeId:String?
    
    override func requestURL() -> String {
        if let recipe = recipeId {
            return "recipes/\(UserDefault.standard.getSelectedLanguage())/\(recipe)"
        }else {
            return ""
        }
        
    }
    
}
