//
//  FFMyFavRecipeListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/23/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit


class FFMyFavRecipeListRequestModel: FFBaseRequestModel {

    override func requestURL() -> String {
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/favorites"
            //            return "user/1/recipes"
            
        }
        return ""
    }
}
