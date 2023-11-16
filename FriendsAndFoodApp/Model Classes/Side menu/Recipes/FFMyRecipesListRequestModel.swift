//
//  FFMyRecipesListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/22/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFMyRecipesListRequestModel: FFBaseRequestModel {
    
    var userID:Int?
    override func requestURL() -> String {
        
        if let id =   userID {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes"
            
            
//            return "user/1/recipes"
        }
        return ""
    }
   
}
