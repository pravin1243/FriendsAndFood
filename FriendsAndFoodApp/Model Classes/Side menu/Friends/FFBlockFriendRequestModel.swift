//
//  FFBlockFriendRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 05/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFBlockFriendRequestModel: FFBaseRequestModel {
    
    var id:String?
    
    override func requestURL() -> String {
        if let userid = id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/friends/\(userid)/block"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
}
