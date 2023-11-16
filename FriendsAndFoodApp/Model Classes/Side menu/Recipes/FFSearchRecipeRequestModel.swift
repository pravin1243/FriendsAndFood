//
//  FFSearchRecipeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 09/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFSearchRecipeRequestModel: FFBaseRequestModel {
    
    var userID:Int?
    var categoryID:Int?
    var interestID:Int?
    var recipeTypeId: Int?
    override func requestURL() -> String {
        
        if let id =   userID {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes"
            
            
//            return "user/1/recipes"
        }
        return ""
    }
    
    override func mapping(map: Map) {
         categoryID <- map["category_ids"]
         interestID <- map["interrest_ids"]
        recipeTypeId <- map["type_ids"]

     }
   
}
