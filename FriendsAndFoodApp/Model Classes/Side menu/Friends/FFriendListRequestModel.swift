//
//  FFriendListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 03/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFriendListRequestModel: FFBaseRequestModel {

    var mode:String?
    var status:String?
    var statusInvited:String?
    var page: String?
    var userId: String?
    var whichTab:Int?
    override func requestURL() -> String {
        
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            if whichTab == 0{
            return "user/\(UserDefault.standard.getSelectedLanguage())/friends"
            }else if whichTab == 1{
                return "user/\(UserDefault.standard.getSelectedLanguage())/my-demands"
            }else{
                return "user/\(UserDefault.standard.getSelectedLanguage())/friends/invited_friends/\(id)"
            }
        }
//        BASE_NEW_URL + "user/"+mLanguage+"/friends?

//        https://api.friends-and-food.com/user/fr/my-demands?page=1
        
//        https://api.friends-and-food.com/user/fr/friends/invited_friends?id=6952&page=1
        return ""
        
//        my friends : /user/{lang}/friends/{id}



    }
    
    override func mapping(map: Map) {
//        mode <- map["mode"]
//        status <- map["status"]
//        statusInvited <- map["status_invited"]
        userId <- map["id"]
        page <- map["page"]

    }
    
}
