//
//  FFAddExpertiseLevelRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/8/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFAddExpertiseLevelRequestModel: FFBaseRequestModel {
    var id:String?
    var expertiselevelid:Int?
    override func requestURL() -> String {

        if let userid = id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(userid)/add_user_expertise"
        }
        return ""
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        expertiselevelid <- map["expertise_level_id"]
    }
}
