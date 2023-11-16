//
//  FFValidateCodeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/1/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFValidateCodeRequestModel: FFBaseRequestModel {

    var email:String?
    var code:String?
    var resetToken:String?
    
    override func requestURL() -> String {
        return "validate-reset-password-code"
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    override func mapping(map: Map) {
        email <- map["email"]
        code <- map["code"]
        resetToken <- map["reset_token"]
    }
}
