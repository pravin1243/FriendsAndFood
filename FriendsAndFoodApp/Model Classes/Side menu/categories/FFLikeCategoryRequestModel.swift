//
//  FFLikeCategoryRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/29/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFLikeCategoryRequestModel: FFBaseRequestModel {

    var categoryId:String?
    var categoryids: [String]?
    var isMultiple: Bool?

    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let categoryID = categoryId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/categories/\(categoryID)/likes"
        }
        return ""
    }
    

    
    override func requestMethod() -> HTTPMethod {
        if isMultiple == true {
            return HTTPMethod.post
        }else {
            return HTTPMethod.put
        }

    }
    
    override func mapping(map: Map) {
        categoryids <- map["category_ids"]

    }
    
}
