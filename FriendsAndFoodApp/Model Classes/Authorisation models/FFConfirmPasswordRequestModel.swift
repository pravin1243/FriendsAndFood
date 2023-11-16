//
//  FFConfirmPasswordRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 06/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFConfirmPasswordRequestModel: FFBaseRequestModel {

    var email:String?
    var code:String?
    var resetToken:String?
    var password:String?
    var confirmPassword:String?
    
    override func requestURL() -> String {
        return "reset-password"
    }
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    override func mapping(map: Map) {
        email <- map["email"]
        code <- map["code"]
        resetToken <- map["reset_token"]
        password <- map["password"]
        confirmPassword <- map["confirm_password"]
    }
}
