//
//  FFEntranceObject.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/7/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFEntranceObject: FFBaseResponseModel {

//    var id:String?

    var id:Int?
    var name:String?
    var recipeDescription: String?
    var imageArray:[FFRecipeTypeObject]?
    var imageObject:FFRecipeTypeObject?
    var types:[FFRecipeTypeObject]?
    var interests:[FFRecipeTypeObject]?
    var ingredients:[FFRecipeTypeObject]?
    var categories:[FFRecipeTypeObject]?
    var nameNormalised:String?
    var nbImages:Int?
    var calories:String?
    var calorieInt:Int?
    var score:Int?
    var toughness:FFRecipeTypeObject?
    var preparationTime:Int?
    var bakingTime:Int?
    var steps:[FFStepObject]?
    var userDetail:FFUserObject?
    var scoreString:String?
    var noOfPersons:Int?
    var nutrition:[FFNutritionObject]?
    var cat_name_normalized: String?
    var noofcalories: String?
    var isFavorite:Int?
    var imageTypeArray:[FFImageObject]?
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?

    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        name <- map["name"]
        recipeDescription <- map["description"]
        imageArray <- map["images"]

        imageObject <- map["images"]
        types <- map["types"]
        interests <- map["interests"]
        ingredients <- map["ingredients"]
        categories <- map["categories"]
        nameNormalised <- map["name_normalized"]
        nbImages <- map["nb_images"]
        calories <- map["calories"]
        calorieInt <- map["calories"]
        score <- map["score"]
        scoreString <- map["score"]
        toughness <- map["toughness"]
        preparationTime <- map["preparation_time"]
        bakingTime <- map["baking_time"]
        steps <- map["steps"]
        userDetail <- map["user"]
        scoreString <- map["score"]
        noOfPersons <- map["nb_persons"]
//        nutrition <- map["nutrition"]
        nutrition <- map["nutrition_by_person"]

        isFavorite <- map["is_liking"]
        cat_name_normalized <- map["catname_normalized"]
        noofcalories <- map["no_of_calories"]
        imageTypeArray <- map["images"]
        imageSmall <- map["image_small"]
        imageMedium <- map["image_medium"]
        imageLarge <- map["image_large"]

    }
    
    
}
