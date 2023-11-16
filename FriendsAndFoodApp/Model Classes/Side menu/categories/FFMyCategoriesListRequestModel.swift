//
//  FFMyCategoriesListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/29/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFMyCategoriesListRequestModel: FFBaseRequestModel {

    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/categories"
            
//            user/{lang}/{id}/categories
        }
        return ""
    }
}
