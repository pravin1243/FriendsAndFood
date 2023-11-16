//
//  FFResultModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFResultModel: NSObject {

    var total:Int?
    var currentPage:Int?
    var count:Int?
    var items:[Any]?
    

    func mapping(map:Map) {
        total <- map["total"]
        currentPage <- map["currentPage"]
        count <- map["count"]
        items <- map["items"]
    }
    
}
