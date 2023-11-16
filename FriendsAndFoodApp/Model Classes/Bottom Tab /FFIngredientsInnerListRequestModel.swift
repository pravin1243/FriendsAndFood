//
//  FFIngredientsInnerListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/11/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFIngredientsInnerListRequestModel: FFBaseRequestModel {
    var familyId:String?
    var userID:Int?

    override func requestURL() -> String {
        
        
                if let id =   userID {
                    return "ingredients-family/\(UserDefault.standard.getSelectedLanguage())/list/\(familyId ?? "")"

                }
                return ""
    }
    
}
