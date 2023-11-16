//
//  FFAddFriendByNickNameRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 04/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFAddFriendByNickNameRequestModel: FFBaseRequestModel {
    
    var nickname:String?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/invite-by-nickname"
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        nickname <- map["nickname"]
    }
}
