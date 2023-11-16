//
//  FFDislikeIngredientRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire

class FFDislikeIngredientRequestModel: FFBaseRequestModel {
    var recipeId:String?
    
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let recipeID = recipeId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/ingredients/favorites/\(recipeID)"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}
