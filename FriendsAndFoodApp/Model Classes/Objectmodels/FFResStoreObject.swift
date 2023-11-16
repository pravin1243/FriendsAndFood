//
//  FFResStoreObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 17/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

struct FFResStoreObject: Codable {
    var storeType:String?
    var sid:Int?
    var sglobalStoreId:Int?
    var sname: String?
    var snameNormalized: String?
    var sstoreTypeId: Int?
    var sratingValue: String?
    var sreviewCount: Int?
    var sphone: String?
    var semailStore: String?
    var swebsite: String?
    var slatitude: String?
    var slongitude: String?
    var saddress: String?
    var spostalCode: String?
    var sregionId: Int?
    var sdepartmentId: Int?
    var sdistrictId: Int?
    var scityId: Int?
    var scountryId: Int?
    var scountryName: String?
    var scityName: String?
    var storeTypeName:String?

    var rid:Int?
    var rname:String?
    var raddress:String?
    var rphone:String?
//    var rspecialities:[FFRecipeTypeObject]?
    var rcity:String?
    var rlatitude:Int?
    var rlongtude:Int?
    var rcountry:String?
//    var rregion:Any?
//    var rimages:[FFImageObject]?
//    var rreviews:[FFReviewObject]?
//    var rrestaurantUser:[FFUserObject]?
    var rpostalcode:Int?
    var rating:Float?
    var isLiking:String?
    var isVerified:Int?
    var image: String?
    var streetAddress: String?
    var postalCode: String?
    var addressLocality: String?
    var cityId: Int?
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?


//    override func mapping(map: Map) {
//        sid <- map["id"]
//        sglobalStoreId <- map["globa_store_id"]
//        sname <- map["name"]
//        snameNormalized <- map["name_normalized"]
//        sstoreTypeId <- map["store_type_id"]
//        sratingValue <- map["rating_value"]
//        sreviewCount <- map["review_count"]
//        sphone <- map["phone"]
//        semailStore <- map["email"]
//        swebsite <- map["website"]
//        slatitude <- map["latitude"]
//        slongitude <- map["longitude"]
//        saddress <- map["address"]
//        spostalCode <- map["postal_code"]
//        sregionId <- map["region_id"]
//        sdepartmentId <- map["department_id"]
//        sdistrictId <- map["district_id"]
//        scityId <- map["city_id"]
//        scountryId <- map["country_id"]
//        scountryName <- map["country_name"]
//        scityName <- map["city_name"]
//
//    }
}
