//
//  FFLikeInterestRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/1/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFLikeInterestRequestModel: FFBaseRequestModel {
    
    var ineterstId:String?
    var interestids: [String]?
    var isMultiple: Bool?
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let interestID = ineterstId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/interests/\(interestID)/likes"
            
//            /api/user/{lang}/{userId}/recipes/interests/{interestId}/likes
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        if isMultiple == true {
            return HTTPMethod.post
        }else {
            return HTTPMethod.put
        }

    }
    
    override func mapping(map: Map) {
        interestids <- map["interest_ids"]

    }
    
}
