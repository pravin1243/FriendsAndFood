//
//  FFNotificationListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 26/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFNotificationListRequestModel: FFBaseRequestModel {

    var page:String?
    var max_results: String?
    var id: Int?
    override func requestMethod() -> HTTPMethod {
        return .post
    }
    
    override func requestURL() -> String {
        
                if let id =   FFBaseClass.sharedInstance.getUser()?.id {
                    return "notification/\(UserDefault.standard.getSelectedLanguage())"
        //            /user/{lang}/{id}/notification

                }
        return ""
    }
    override func mapping(map: Map) {
        id <- map["id"]
    }
}
