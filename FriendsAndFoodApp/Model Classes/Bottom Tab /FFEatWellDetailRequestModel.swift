//
//  FFEatWellRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFEatWellDetailRequestModel: FFBaseRequestModel {

    
    var typeId:String?
    var interestId:String?
    
    override func requestURL() -> String {
        return "recipes/\(UserDefault.standard.getSelectedLanguage())"
    }
    
    override func mapping(map: Map) {
        typeId <- map["type_ids"]
//        typeId <- map["types"]

        interestId <- map["interest_ids"]
    }
    
    
}
