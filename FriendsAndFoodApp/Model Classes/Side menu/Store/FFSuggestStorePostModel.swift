//
//  FFSuggestStorePostModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 04/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFSuggestStorePostModel: FFBaseRequestModel {
    
    
//    - name,store_type_id,country_id,address,postal_code,city_id,latitude-optional,longitude-optional,
//    - display_hours_monday,display_hours_tuesday,display_hours_wednesday,display_hours_friday,display_hours_saturday,display_hours_sunday(all optional),
//    - email,phone,website,facebook(all optional)
//    - country_name, city_name


    var isEdit:Bool?
    var id:String?
    var name:String?
    var storeTypeId: String?
    var countryId:String?
    var cityId:String?
    var address:String?
    var postalCode:String?
    var cityName:String?
    var countryName:String?
    var phone:String?
    var email:String?
    var website:String?
    var facebook:String?
    var description:String?
//    var priceRange:String?
//    var specialities:String?
//    var interests:String?
    var image:String?
    var displayHoursSunday:String?
    var displayHoursMonday:String?
    var displayHoursTuesday:String?
    var displayHoursWednesday:String?
    var displayHoursThursday:String?
    var displayHoursFriday:String?
    var displayHoursSaturday:String?

    
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

//    var accept2: String?
    override func requestMethod() -> HTTPMethod {
        if isEdit == true {
            return HTTPMethod.post
        }else {
            return HTTPMethod.post
        }
        
    }

    override func requestURL() -> String {
           if isEdit == true {
               if let id = id {
                   return "stores/\(UserDefault.standard.getSelectedLanguage())/\(id)/update-information"
               }
           }else {
           
               return "stores/\(UserDefault.standard.getSelectedLanguage())/add-suggest"
           }
        return ""
       }
//    https://api.friends-and-food.com/restaurants/fr
    override func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        storeTypeId <- map["store_type_id"]
        countryId <- map["country_id"]
        cityId <- map["city_id"]
        address <- map["address"]
        postalCode <- map["postal_code"]
        cityName <- map["city_name"]
        countryName <- map["country_name"]
        phone <- map["phone"]
        email <- map["email"]
        website <- map["website"]
        facebook <- map["facebook"]
        description <- map["description"]
//        priceRange <- map["price_range"]
//        specialities <- map["specialities"]
//        interests <- map["interests"]
//        jobId <- map["job_id"]
        image <- map["image"]
//        accept2 <- map["accept2"]
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

    }
}
