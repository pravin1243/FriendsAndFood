//
//  FFGetProfileDetailsRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 27/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetProfileDetailsRequestModel: FFBaseRequestModel {

    var userID:Int?
    
    override func requestURL() -> String {
        if let id =   userID {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)"
        }
        return ""
    }
}
