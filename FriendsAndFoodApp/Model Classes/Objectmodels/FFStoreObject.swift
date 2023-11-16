//
//  FFStoreObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 06/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFStoreObject: FFBaseResponseModel {

    var id:Int?
    var globalStoreId:Int?
    var name: String?
    var nameNormalized: String?
    var storeTypeId: Int?
    var ratingValue: String?
    var reviewCount: Int?
    var phone: String?
    var emailStore: String?
    var website: String?
    var latitude: String?
    var longitude: String?
    var address: String?
    var postalCode: String?
    var regionId: Int?
    var departmentId: Int?
    var districtId: Int?
    var cityId: Int?
    var countryId: Int?
    var countryName: String?
    var cityName: String?
    var image:String?
    var facebook:String?

    var displayHoursSunday:String?
    var displayHoursMonday:String?
    var displayHoursTuesday:String?
    var displayHoursWednesday:String?
    var displayHoursThursday:String?
    var displayHoursFriday:String?
    var displayHoursSaturday:String?
    var storeTypeName: String?
    
    var morningdisplayHoursSunday:String?
    var morningdisplayHoursMonday:String?
    var morningdisplayHoursTuesday:String?
    var morningdisplayHoursWednesday:String?
    var morningdisplayHoursThursday:String?
    var morningdisplayHoursFriday:String?
    var morningdisplayHoursSaturday:String?

    var eveningdisplayHoursSunday:String?
    var eveningdisplayHoursMonday:String?
    var eveningdisplayHoursTuesday:String?
    var eveningdisplayHoursWednesday:String?
    var eveningdisplayHoursThursday:String?
    var eveningdisplayHoursFriday:String?
    var eveningdisplayHoursSaturday:String?

    
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?
    var storeuserid: Int?

    var countlikes: Int?
    var countreviews: Int?
    var averagenotereviews: Int?
    var countproducts: Int?


    override func mapping(map: Map) {
        countlikes <- map["count_likes"]
        countreviews <- map["count_reviews"]
        averagenotereviews <- map["average_note_reviews"]
        countproducts <- map["count_products"]

        id <- map["id"]
        globalStoreId <- map["globa_store_id"]
        name <- map["name"]
        nameNormalized <- map["name_normalized"]
        storeTypeId <- map["store_type_id"]
        ratingValue <- map["rating_value"]
        reviewCount <- map["review_count"]
        phone <- map["phone"]
        emailStore <- map["email"]
        website <- map["website"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        address <- map["address"]
        postalCode <- map["postal_code"]
        regionId <- map["region_id"]
        departmentId <- map["department_id"]
        districtId <- map["district_id"]
        cityId <- map["city_id"]
        countryId <- map["country_id"]
        countryName <- map["country_name"]
        cityName <- map["city_name"]
        image <- map["image"]
        facebook <- map["facebook"]
        
        displayHoursSunday <- map["display_hours_sunday"]
        displayHoursMonday <- map["display_hours_monday"]
        displayHoursTuesday <- map["display_hours_tuesday"]
        displayHoursWednesday <- map["display_hours_wednesday"]
        displayHoursThursday <- map["display_hours_thursday"]
        displayHoursFriday <- map["display_hours_friday"]
        displayHoursSaturday <- map["display_hours_saturday"]
        
        morningdisplayHoursSunday <- map["morning_display_hours_sunday"]
        morningdisplayHoursMonday <- map["morning_display_hours_monday"]
        morningdisplayHoursTuesday <- map["morning_display_hours_tuesday"]
        morningdisplayHoursWednesday <- map["morning_display_hours_wednesday"]
        morningdisplayHoursThursday <- map["morning_display_hours_thursday"]
        morningdisplayHoursFriday <- map["morning_display_hours_friday"]
        morningdisplayHoursSaturday <- map["morning_display_hours_saturday"]

        
        eveningdisplayHoursSunday <- map["evening_display_hours_sunday"]
        eveningdisplayHoursMonday <- map["evening_display_hours_monday"]
        eveningdisplayHoursTuesday <- map["evening_display_hours_tuesday"]
        eveningdisplayHoursWednesday <- map["evening_display_hours_wednesday"]
        eveningdisplayHoursThursday <- map["evening_display_hours_thursday"]
        eveningdisplayHoursFriday <- map["evening_display_hours_friday"]
        eveningdisplayHoursSaturday <- map["evening_display_hours_saturday"]

        
        storeTypeName <- map["store_type_name"]
        imageSmall <- map["image_small"]
        imageMedium <- map["image_medium"]
        imageLarge <- map["image_large"]
        storeuserid <- map["store_user_id"]

    }
}
