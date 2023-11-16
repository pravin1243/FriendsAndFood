//
//  FFLoginRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFLoginRequestModel: FFBaseRequestModel {

    var login: String?
    var password:String?
    
    override func requestURL() -> String {
//        return "login"
        return "user/\(UserDefault.standard.getSelectedLanguage())/login"
    }
    
    override func requestMethod() -> HTTPMethod {
        return .post
    }
    
    override func mapping(map: Map) {
        login <- map["login"]
        password <- map["password"]
    }
}
