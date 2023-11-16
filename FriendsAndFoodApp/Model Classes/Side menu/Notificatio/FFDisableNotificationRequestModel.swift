//
//  FFDisableNotificationRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/25/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class FFDisableNotificationRequestModel: FFBaseRequestModel {

    var notifId:String?
    
    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "notification/\(UserDefault.standard.getSelectedLanguage())/\(notifId ?? "")/disabled"
        }
        return ""
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
    
}
