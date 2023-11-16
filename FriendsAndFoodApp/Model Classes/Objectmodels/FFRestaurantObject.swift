//
//  FFRestaurantObject.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 19/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFRestaurantObject: FFBaseResponseModel {
    
    var id:Int?
    var name:String?
    var address:String?
    var phone:String?
    var specialities:[FFRecipeTypeObject]?
    var city:String?
    var latitude:Int?
    var longtude:Int?
    var country:String?
    //var region:Any?
    var images:[FFImageObject]?
    var reviews:[FFReviewObject]?
    var restaurantUser:[FFUserObject]?
    var postalcode:Int?
    var rating:Float?
    var isLiking:String?
    var isVerified:Int?
    var image: String?
    var streetAddress: String?
    var postalCode: String?
    var addressLocality: String?
    var cityId: Int?
    
    var facebook:String?

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

    var website: String?
    var priceRange: String?
    var restemail: String?

    var restaurantuserid: Int?
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?
    var currency: [FFCurrencyObject]?
    
    var countlikes: Int?
    var countreviews: Int?
    var averagenotereviews: Int?
    var countrecipesin_menu: Int?

    override func mapping(map: Map) {
        countlikes <- map["count_likes"]
        countreviews <- map["count_reviews"]
        averagenotereviews <- map["average_note_reviews"]
        countrecipesin_menu <- map["count_recipes_in_menu"]

        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        phone <- map["phone"]
        specialities <- map["specialities"]
        city  <- map["city.name"]
        latitude  <- map["city.latitude"]

        longtude  <- map["city.longitude"]

        country <- map["country"]

       // region <- map["region"]
        images <- map["images"]
        reviews <- map["reviews"]
        restaurantUser <- map["restaurantUser"]
        postalcode <- map["postal_code"]
        rating <- map["rating_value"]
        isLiking <- map["is_liking"]
        isVerified <- map["is_verified"]
        image <- map["image"]
        streetAddress <- map["streetAddress"]
        postalCode <- map["postalCode"]
        addressLocality <- map["addressLocality"]
        cityId <- map["city_id"]
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

        website <- map["website"]
        priceRange <- map["priceRange"]
        restaurantuserid <- map["restaurant_user_id"]
        imageSmall <- map["image_small"]
        imageMedium <- map["image_medium"]
        imageLarge <- map["image_large"]
        currency <- map["currency"]
        
        restemail <- map["email"]

    }
}
