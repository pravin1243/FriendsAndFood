//
//  FFAcceptFriendRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 05/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFAcceptFriendRequestModel: FFBaseRequestModel {

    var userID:String?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/accept-demands"
    }
    
    override func mapping(map: Map) {
        userID <- map["user_id"]
    }
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
}
