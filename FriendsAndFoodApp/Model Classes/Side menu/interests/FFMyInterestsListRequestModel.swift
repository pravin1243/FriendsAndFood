//
//  FFMyInterestsListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/30/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFMyInterestsListRequestModel: FFBaseRequestModel {
    
    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/interests"

        }
        return ""
    }

}
