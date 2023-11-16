//
//  FFRetrievePasswordRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/1/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFRetrievePasswordRequestModel: FFBaseRequestModel {
    var email :String?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/retrieve-password"
    }
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    override func mapping(map: Map) {
        email <- map["email"]
    }
    
}
