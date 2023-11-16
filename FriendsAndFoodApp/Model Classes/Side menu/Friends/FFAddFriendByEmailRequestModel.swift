//
//  FFAddFriendByEmailRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 04/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFAddFriendByEmailRequestModel: FFBaseRequestModel {

    var email:String?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/invite-by-mail"
    }
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        email <- map["email"]
    }
}
