//
//  FFDislikeInterestRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 6/1/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire

class FFDislikeInterestRequestModel: FFBaseRequestModel {

    var ineterstId:String?
    
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let interestID = ineterstId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/recipes/interests/\(interestID)/likes"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}
