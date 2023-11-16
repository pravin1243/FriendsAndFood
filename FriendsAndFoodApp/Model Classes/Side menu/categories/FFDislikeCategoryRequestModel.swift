//
//  FFDislikeCategoryRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/29/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire

class FFDislikeCategoryRequestModel: FFBaseRequestModel {
    
    var categoryId:String?
    
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let categoryID = categoryId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/categories/\(categoryID)/likes"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}
