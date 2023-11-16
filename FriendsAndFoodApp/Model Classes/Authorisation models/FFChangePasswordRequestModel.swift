//
//  FFChangePasswordRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFChangePasswordRequestModel: FFBaseRequestModel {
    var id:String?
    var newpassword:String?
    var confirmnewpassword:String?
    var oldpassword:String?
    override func requestURL() -> String {
        if let userid = id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(userid)/reset-password-connected"
        }
        return ""
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        newpassword <- map["new_password"]
        confirmnewpassword <- map["confirm_new_password"]
        oldpassword <- map["old_password"]

    }
}
