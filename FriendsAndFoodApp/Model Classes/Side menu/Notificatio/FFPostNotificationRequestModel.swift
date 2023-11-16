//
//  FFPostNotificationRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 26/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFPostNotificationRequestModel: FFBaseRequestModel {

    var ids:String?
    
    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "user/\(id)/notification"
        }
        return ""
    }
    
    override func mapping(map: Map) {
        ids <- map["ids"]
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
}
