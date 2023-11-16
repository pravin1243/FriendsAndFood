//
//  FFDishesListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFDishesListRequestModel: FFBaseRequestModel {

    var universeId: String?
    override func requestURL() -> String {
        return "categories/\(UserDefault.standard.getSelectedLanguage())"
    }
    
    override func mapping(map: Map) {
          universeId <- map["universe_id"]
      }
    }
