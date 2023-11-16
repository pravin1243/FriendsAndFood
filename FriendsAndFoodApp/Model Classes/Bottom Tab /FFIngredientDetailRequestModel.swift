//
//  FFIngredientDetailRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/5/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFIngredientDetailRequestModel: FFBaseRequestModel {
    
    var id:String?
    
    override func requestURL() -> String {
        if let ingreId = id {
            return "ingredients/\(UserDefault.standard.getSelectedLanguage())/\(ingreId)"
        }
        return ""
    }
}
