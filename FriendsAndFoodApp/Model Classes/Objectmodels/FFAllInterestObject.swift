//
//  FFAllInterestObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFAllInterestObject: FFBaseResponseModel {

    var id: Int?
    var globalRecipeInterestId: String?
    var name: String?
    var nameNormalized: String?
    var descriptionInterest: String?
    var statusInterest: Int?
    var isQuestion: Int?
    var question: String?

    var isChecked: Int?

    override func mapping(map: Map) {
        id <- map["id"]
        globalRecipeInterestId <- map["global_recipe_interest_id"]
        name <- map["name"]
        nameNormalized <- map["name_normalized"]
        descriptionInterest <- map["description"]
        statusInterest <- map["status"]
        isQuestion <- map["is_question"]
        question <- map["question"]
        isChecked <- map["isChecked"]
    }
}
