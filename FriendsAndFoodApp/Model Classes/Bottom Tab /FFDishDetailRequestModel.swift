//
//  FFDishDetailRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/5/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFDishDetailRequestModel: FFBaseRequestModel {

    var id:String?
    
    override func requestURL() -> String {
        if let dishId = id {
            return "categories/\(UserDefault.standard.getSelectedLanguage())/\(dishId)"
        }
        return ""
    }
    
}
