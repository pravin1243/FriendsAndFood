//
//  FFRecipeTypeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 09/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFRecipeTypeRequestModel: FFBaseRequestModel {
    

    override func requestURL() -> String {
        
            return "recipes/\(UserDefault.standard.getSelectedLanguage())/types"
  
    }
    

   
}
