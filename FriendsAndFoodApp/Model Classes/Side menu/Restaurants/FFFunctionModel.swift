//
//  FFFunctionModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 31/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
class FFFunctionModel: FFBaseRequestModel {
//    https://api.friends-and-food.com/local/fr/countries-list
    
    var fromWhere: String?

    override func requestURL() -> String {
        if fromWhere == "special"
        {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/specialties"
        }else if fromWhere == "function"{
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/jobs"
        }else if fromWhere == "allinterest"{
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/allinterest"
        }
        else{
            return ""
        }
    }

}
