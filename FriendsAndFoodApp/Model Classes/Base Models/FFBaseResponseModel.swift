//
//  FFBaseResponseModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFBaseResponseModel: NSObject, Mappable {
    
    var status:Int?
    //    var result:FFResultModel?
    var message:String?
    var itemList:[FFEntranceObject]?
    var itemListFavRecipe:[FFEntranceObject]?

    var reviewList:[FFReviewObject]?
    var postedReview:FFReviewObject?

    var user:FFUserObject?
    var interest:[FFRecipeTypeObject]?
    var ingredientList:[FFRecipeTypeObject]?
    var recipeDetail:FFEntranceObject?
    var totalCount:String?
    var totalCountInt:Int?
    
    var jwt:String?
    var resetToken:String?
    var email:String?
    
    var detail:FFRecipeTypeObject?
    
    var measureList:[FFMeasureObject]?
    var files:[FFImageObject]?
    var notificationSetting:[FFNotificationObject]?
    var  notificationList:[FFNotificationObject]?
    
    var friendsList:[FFFriendObject]?
    
    var nicknameList:[FFUserObject]?
    
    var restaurantList:[FFRestaurantObject]?
    var restaurantDetail:FFRestaurantObject?
    var restaurantDetailArray:[FFRestaurantObject]?

    var ingredientListByFamily: [FFRecipeTypeObject]?
    var favrestaurantList:[FFRestaurantObject]?

    var placesList:[FFPlaceObject]?

    var seasonObject:[FFSeasonObject]?

    var faqList:[FFFaqObject]?
    var nutritionList: [FFNutritionObject]?
    
    
    var universe:[FFUniverseObject]?

    var languageList:[FFLanguageObject]?
    
    var storeTypeList:[FFStoreTypeObject]?

    var ingredientVarietyObject:[FFIngrVarietyObject]?
    var menuList:[FFRestaurantMenuObject]?
    
    var storeList:[FFStoreObject]?

    var storeDetail:FFStoreObject?
    var specialdietArray: [FFSpecialDietObject]?
    
    var resspecialities: String?
    
    var allInterest:[FFAllInterestObject]?

    var follow:[FFFollowObject]?

    var favoriterestaurant:[FFRecipeTypeObject]?
    var favoritestore:[FFRecipeTypeObject]?
    var favoriteingredient:[FFEntranceObject]?
    var favoritecategory:[FFRecipeTypeObject]?
    var favoriteinterests:[FFRecipeTypeObject]?
    var favoriterecipe:[FFRecipeTypeObject]?

    
    var messageList:[FFMessageObject]?
    var storeProductCategoriesList: [FFStoreProductCategoriesObject]?
    var storeProductsList: [FFStoreProductsObject]?

    
    var expertiseLevelList: [FFExpertiseLevelObject]?

    public func mapping(map:Map){
        status <- map["success"]
        //        result <- map["result"]
        message <- map["message"]
        itemListFavRecipe <- map["result"]
        itemList <- map["result.items"]

        reviewList <- map["result.items"]
        postedReview <- map["result"]
        user <- map["user"]
        interest <- map["result"]
        ingredientList <- map["result.items"]
        ingredientListByFamily <- map["result.ingredient_by_family"]

        recipeDetail <- map["result"]
        jwt <- map["jwt"]
        totalCount <- map["result.total"]
        resetToken <- map["reset_token"]
        email <- map["email"]
        
        detail <- map["result"]
        measureList <- map["result"]
        
        files <- map["files"]
        notificationSetting <- map["notification"]
        notificationList <- map["result.items"]
//        notificationList <- map["notification"]

        totalCountInt <- map["result.total"]
        friendsList <- map["result.items"]
        
        nicknameList <- map["result.items"]
        
        restaurantList <- map["result.items"]
        restaurantDetail <- map["result"]
        restaurantDetailArray <- map["result"]
        placesList <- map["result"]
        
        favrestaurantList <- map["result"]
        seasonObject <- map["result.items"]
        faqList <- map["result.items"]
        nutritionList <- map["result.items"]
        
        universe <- map["result"]
        languageList <- map["result"]
        storeTypeList <- map["result"]
        ingredientVarietyObject <- map["result.items"]
        menuList <- map["result"]
        storeList <- map["result"]
        
        storeDetail <- map["result"]
        
        specialdietArray <- map["specialdiet"]
        resspecialities <- map["specialities"]
        allInterest <- map["result.interestlist"]
        follow <- map["result"]
        
        favoriterestaurant <- map["result.favorite_restaurant.data"]
        favoritestore <- map["result.favorite_store.data"]
        favoriteingredient <- map["result.favorite_ingredient.data"]
        favoritecategory <- map["result.favorite_category.data"]
        favoriteinterests <- map["result.favorite_interests.data"]
        favoriterecipe <- map["result.favorite_recipe.data"]

        messageList <- map["result.items"]
        storeProductCategoriesList <- map["result"]
        storeProductsList <- map["result"]
        
        expertiseLevelList <- map["data"]
    }
    
    required init?(map: Map) {
        
    }
}
