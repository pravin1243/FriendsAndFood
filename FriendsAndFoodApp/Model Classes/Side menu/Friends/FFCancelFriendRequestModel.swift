//
//  FFCancelFriendRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 05/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFCancelFriendRequestModel: FFBaseRequestModel {

    var userID:String?
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/cancel-my-demands"
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }

    override func mapping(map: Map) {
        userID <- map["user_invited_id"]
    }
    
}
