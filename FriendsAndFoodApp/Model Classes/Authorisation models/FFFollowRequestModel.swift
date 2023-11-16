//
//  FFFollowRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 29/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire

class FFFollowRequestModel: FFBaseRequestModel {

    var memberID:Int?
    var isDelete: Int?
    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let memberID = memberID{
         return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/member/follow/\(memberID)"
        }
        return ""
        }
    
    override func requestMethod() -> HTTPMethod {
        if isDelete == 1{
            return HTTPMethod.delete
        }else{
        return HTTPMethod.put
        }
    }
}
