//
//  FFRegisterRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/31/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFRegisterRequestModel: FFBaseRequestModel {

    var firstname:String?
    var lastName:String?
    var nickName:String?
    var email:String?
    var password:String?
    var gender:String?

    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())"
    }
    
    override func requestMethod() -> HTTPMethod {
       return  HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        firstname <- map["first_name"]
        lastName <- map["last_name"]
        nickName <- map["nickname"]
        email <- map["email"]
        password <- map["password"]
        gender <- map["gender"]

    }
}
