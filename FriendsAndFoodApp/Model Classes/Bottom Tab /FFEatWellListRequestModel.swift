//
//  FFEatWellListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFEatWellListRequestModel: FFBaseRequestModel {

    override func requestURL() -> String {
        //By Rachit
//        return "recipes/interests"
        return "recipes/\(UserDefault.standard.getSelectedLanguage())/interests"
    }
    
    
}
