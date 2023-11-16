//
//  FFCheckFreindRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 12/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFCheckFreindRequestModel: FFBaseRequestModel {

    var userId:Int?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/friend-check"
    }
    
    override func mapping(map: Map) {
        userId <- map["user_id"]
    }
    
}
