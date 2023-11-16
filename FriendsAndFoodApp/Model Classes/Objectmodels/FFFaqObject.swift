//
//  FFFaqObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 22/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFFaqObject: FFBaseResponseModel {

    var id:String?
    var idInt:Int?
    var question:String?
    var answer:String?
    var creation_date:String?
    var last_modified_date:String?
    var faqstatus:Int?
    var score: Int?

    override func mapping(map: Map) {
        id <- map["id"]
        idInt <- map["id"]
        question <- map["question"]
        answer <- map["answer"]
        creation_date <- map["creation_date"]
        last_modified_date <- map["last_modified_date"]
        faqstatus <- map["status"]
        score <- map["score"]

    }
}
