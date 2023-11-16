//
//  FFSendMessageRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFSendMessageRequestModel: FFBaseRequestModel {
    
    var userId:String?
    var message:String?
    
    override func requestURL() -> String {
        if let id = userId {
            return "messages/\(UserDefault.standard.getSelectedLanguage())/user/\(id)"
        }
        return ""
        
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
    
}
