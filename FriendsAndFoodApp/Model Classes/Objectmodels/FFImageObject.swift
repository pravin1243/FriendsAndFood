//
//  FFImageObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 18/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFImageObject: FFBaseResponseModel {
//    "name": "4kkywrlpNC-15293152406704.png",
//    "size": 331682,
//    "type": "image/png",
//    "url": "http://media.ff.mydigitalys.com/redim-4kkywrlpNC-15293152406704.png",
//    "thumbnailUrl": "http://media.ff.mydigitalys.com/redim-thumbnail/4kkywrlpNC-15293152406704.png",
//    "deleteUrl": "http://media.ff.mydigitalys.com/?file=4kkywrlpNC-15293152406704.png",
//    "deleteType": "DELETE"
    
    var name:String?
    var size:Int?
    var url:String?
    var thumbnail:String?
    var deleteUrl:String?
    var large: String?
    var medium: String?
    var small: String?
    override func mapping(map: Map) {
        name <- map["name"]
        size <- map["size"]
        thumbnail <- map["thumbnailUrl"]
        url <- map["url"]
        deleteUrl <- map["deleteUrl"]
        large <- map["large"]
        medium <- map["medium"]
        small <- map["small"]

    }
    
}
