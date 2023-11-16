//
//  FFNotificationObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 26/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFNotificationObject: FFBaseResponseModel {

    var name: String?
    var id:String?
    var title:String?
    var notificationStatus:Int?
    
    var idInt:Int?
    var type:Int?
    var content:String?
    var notificationUser:FFUserObject?
    var createdDate:String?
    var recipeReview:FFReviewObject?
    
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        title <- map["title"]
        notificationStatus <- map["status"]
        
        idInt <- map["id"]
        type <- map["type"]
        content <- map["content"]
        notificationUser <- map["user"]
        createdDate <- map["creation_date"]
        recipeReview <- map["recipe_review"]
    }
}
