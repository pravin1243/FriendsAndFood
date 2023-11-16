//
//  FFIngredientsListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFIngredientsListRequestModel: FFBaseRequestModel {

    override func requestURL() -> String {        
        return "ingredients-family/\(UserDefault.standard.getSelectedLanguage())"
        
    }
    
}
