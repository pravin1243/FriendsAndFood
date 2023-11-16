//
//  FFLikeRecipeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/23/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire

class FFLikeRecipeRequestModel: FFBaseRequestModel {

    var recipeId:Int?
    
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let recipeID = recipeId{
         return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/favorites/\(recipeID)"
        }
        return ""
        }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.put
    }
}
