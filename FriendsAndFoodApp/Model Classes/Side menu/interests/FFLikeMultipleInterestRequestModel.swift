//
//  FFLikeMultipleInterestRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/9/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFLikeMultipleInterestRequestModel: FFBaseRequestModel {
    
    var ineterstId:String?
    var interestids: [String]?
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let interestID = ineterstId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/interests/\(interestID)/likes"
            
//            /api/user/{lang}/{userId}/recipes/interests/{interestId}/likes
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        interestids <- map["interest_ids"]

    }
}
