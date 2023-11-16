//
//  FFNotificationSettingRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 26/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFNotificationSettingRequestModel: FFBaseRequestModel {
    
    
    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/notification"
//            /user/{lang}/{id}/notification

        }
        return ""
    }
    
    
}
