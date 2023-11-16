//
//  FFManagerClass.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class FFManagerClass: BaseAPI {
    
    class func loadEntranceList(withTypeId:String?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFEntranceListRequestModel()
        requestModel.typeId = withTypeId
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
    }
    
    class func loadAllRecipeList(page:String?, maxResult:String?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFAllRecipesListRequestModel()
        requestModel.maxResults = maxResult
        requestModel.page = page

        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
    }
    
    class func login(email:String?, password: String?, success:((_ response:FFBaseResponseModel?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLoginRequestModel()
        requestModel.login = email
        requestModel.password = password
        
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func getInterestList(success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFEatWellListRequestModel()
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.interest ?? [])
            
        }, failure: failure)
    }
    
    class func getExpertiseLevelList(success:((_ response:[FFExpertiseLevelObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetExpertiseLevelRequestModel()
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.expertiseLevelList ?? [])
            
        }, failure: failure)
    }
    
    class func addExpertiseLevel(expertiseLevelRequest:FFAddExpertiseLevelRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        shared.addJwtToHeader()
        shared.performRequest(expertiseLevelRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func loadEatWellEntranceList(withTypeId:String?, interestId:String?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFEatWellDetailRequestModel()
        requestModel.typeId = withTypeId
        if let interestid = interestId {
        requestModel.interestId = interestid
        }
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
    }
    
    class func getDishesList(id:String?, success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDishesListRequestModel()
        if id == ""{
            
        }else{
        requestModel.universeId = id
        }
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.interest ?? [])
            
        }, failure: failure)
    }
    
    class func getRecipeTypeList(success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRecipeTypeRequestModel()
     
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.interest ?? [])
            
        }, failure: failure)
    }
    
    class func getUniverseList(success:((_ response:[FFUniverseObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFUniverseRequestModel()
        requestModel.type = "universe_with_category"
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.universe ?? [])
            
        }, failure: failure)
    }
    
    class func getDisheDetail(id:String?, success:((_ response:FFRecipeTypeObject?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDishDetailRequestModel()
        requestModel.id = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.detail)
            
        }, failure: failure)
    }
    
    
    
    class func getIngredientsList(success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFIngredientsListRequestModel()
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.ingredientList ?? [])
            
        }, failure: failure)
    }
    
    class func getIngredientsInnerList(userID:Int?, familyId:String?,success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFIngredientsInnerListRequestModel()
        requestModel.userID = userID
        requestModel.familyId = familyId
//        shared.addJwtToHeader()

        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.ingredientListByFamily ?? [])
            
        }, failure: failure)
    }
    
    class func getIngredientDetail(id:String?, success:((_ response:FFRecipeTypeObject?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFIngredientDetailRequestModel()
        requestModel.id = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.detail)
            
        }, failure: failure)
    }
    
    class func getRecipeList(isFromIngredient:Bool?,categoryId:String?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRecipeListRequestModel()
        if isFromIngredient == true {
            requestModel.ingredientId = categoryId
        }else {
           requestModel.categoryId  = categoryId
        }
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
        
    }
    
    class func getSeasonalData(isFromIngredient:Bool?,categoryId:String?, success:((_ response:[FFSeasonObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFSeasonModel()
        if isFromIngredient == true {
            requestModel.ingredientId = categoryId
        }else {
           requestModel.categoryId  = categoryId
        }
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.seasonObject ?? [])
            
        }, failure: failure)
        
    }
    
    class func getIngVarietyData(isFromIngredient:Bool?,categoryId:String?, success:((_ response:[FFIngrVarietyObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFIngreVarietyRequestModel()
        if isFromIngredient == true {
            requestModel.ingredientId = categoryId
        }else {
        }
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.ingredientVarietyObject ?? [])
            
        }, failure: failure)
        
    }
    
    class func getFAQData(isFromIngredient:Bool?,categoryId:String?, success:((_ response:[FFFaqObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFFaqModel()
        if isFromIngredient == true {
            requestModel.ingredientId = categoryId
//            requestModel.ingredientId = "488"
        }else {
           requestModel.categoryId  = categoryId
        }
        requestModel.page = "1"
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.faqList ?? [])
            
        }, failure: failure)
        
    }
    
    class func getHomeFAQData(page:String?,maxresults:String?, success:((_ response:[FFFaqObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFHomeFaqModel()
            requestModel.page = page
        requestModel.maxresults = maxresults

            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
                success?(response.faqList ?? [])
                
            }, failure: failure)
            
        }
    
    class func getNutritionData(isFromIngredient:Bool?,categoryId:String?, success:((_ response:[FFNutritionObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFNutritionModel()
            if isFromIngredient == true {
    //            requestModel.ingredientId = categoryId
                requestModel.ingredientId = "488"
            }else {
               requestModel.categoryId  = categoryId
            }
            requestModel.page = "1"
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
                success?(response.nutritionList ?? [])
                
            }, failure: failure)
            
        }
    
    class func getRecipeDetail(recipeId:String?, success:((_ response:FFEntranceObject?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRecipeDetailRequestModel()
        requestModel.recipeId  = recipeId
        //shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.recipeDetail)
            
        }, failure: failure)
        
    }
    
    class func getRecipeReviewList(recipeId:String?, maxResults:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFReviewListRequestModel()
        requestModel.recipeID = recipeId
        requestModel.maxResults = maxResults
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
        
    }
    
    class func getStoreReviewList(storeId:String?, maxResults:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
          
          let requestModel = FFStoreReviewListModel()
          requestModel.storeID = storeId
          requestModel.maxResults = maxResults
          shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
              
              success?(response)
              
          }, failure: failure)
          
      }
    
    class func getRestaurantReviewList(restaurantId:String?, maxResults:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRestaurantReviewListModel()
        requestModel.restaurantID = restaurantId
        requestModel.maxResults = maxResults
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
        
    }
    
    class func postRecipeReview(recipeId:String?, review:String?,rate:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFPostReviewRequestModel()
        requestModel.recipeID = recipeId
        requestModel.review = review
        requestModel.rating = rate
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
//            success?(response.postedReview!)
            success?(response)

        }, failure: failure)
        
    }
    
        class func postStoreReview(storeID:String?, review:String?,rate:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFStorePostReviewRequestModel()
            requestModel.storeID = storeID
            requestModel.review = review
            requestModel.rating = rate
            shared.addJwtToHeader()
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
    //            success?(response.postedReview!)
                success?(response)

            }, failure: failure)
            
        }
    
        class func postRestaurantReview(restaurantId:String?, review:String?,rate:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFRestaurantPostReviewRequestModel()
            requestModel.restaurantID = restaurantId
            requestModel.review = review
            requestModel.rating = rate
            shared.addJwtToHeader()
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
    //            success?(response.postedReview!)
                success?(response)

            }, failure: failure)
            
        }
    class func addOwnerDetails(isProfessional:String?,restaurantId:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFAddOwnerDetailsRequestModel()
            requestModel.restaurantID = restaurantId
        requestModel.isProfessional = isProfessional

            shared.addJwtToHeader()
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
    //            success?(response.postedReview!)
                success?(response)

            }, failure: failure)
            
        }
    class func addStoreOwnerDetails(isProfessional:String?,storeId:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
              
              let requestModel = FFAddStoreOwnerRequestModel()
              requestModel.storeID = storeId
          requestModel.isProfessional = isProfessional

              shared.addJwtToHeader()
              shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                  
      //            success?(response.postedReview!)
                  success?(response)

              }, failure: failure)
              
          }
    class func getMyRecipesList(userID:Int?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyRecipesListRequestModel()
        requestModel.userID = userID
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
    }
    
    class func getMyMessagesList(userID:Int?, success:((_ response:[FFMessageObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetMessagesRequestModel()
        requestModel.userID = userID
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.messageList ?? [])
            
        }, failure: failure)
    }
    
    class func postMessage(userId:String?, message:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
              
              let requestModel = FFSendMessageRequestModel()
              requestModel.userId = userId
              requestModel.message = message
              shared.addJwtToHeader()
              shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                  
      //            success?(response.postedReview!)
                  success?(response)

              }, failure: failure)
              
          }
    
//    FFSendMessageRequestModel
    class func getMemberfavourites(memberID:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMemberFavouritesRequestModel()
        requestModel.memberID = memberID
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response )

        }, failure: failure)
    }
    
    class func searchMyRecipesList(recipeTypeId:Int?,userID:Int?,categoryID:Int?,interestID:Int?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFSearchRecipeRequestModel()
        requestModel.userID = userID
        requestModel.categoryID = categoryID
        requestModel.interestID = interestID
        requestModel.recipeTypeId = recipeTypeId
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [])
            
        }, failure: failure)
    }
    
    class func getMyFavRecipesList(success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyFavRecipeListRequestModel()
        //shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.itemListFavRecipe ?? [])
            
        }, failure: failure)
    }
    
    class func likeRecipe(recipeID:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeRecipeRequestModel()
        requestModel.recipeId = recipeID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func dislikeRecipe(recipeID:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDislikeRecipeRequestModel()
        requestModel.recipeId = recipeID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func deleteRecipe(recipeID:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDeleteRecipeRequestModel()
        requestModel.recipeid = recipeID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func deleteMenu(menuID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
           
           let requestModel = FFDeleteMenuRequestModel()
           requestModel.menuid = menuID
           shared.addJwtToHeader()
           shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
               
               success?(response)
               
           }, failure: failure)
       }
    
    
    class func getMyIngredientList(userId:String?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyIngredientRequestModel()
        requestModel.userID  = userId
//        requestModel.userID = "1"
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            
            success?(response.itemList ?? [] )
            
        }, failure: failure)
        
    }
    
        class func getLanguages(success:((_ response:[FFLanguageObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
            let requestModel = FFLanguageRequestModel()
            shared.addJwtToHeader()
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                success?(response.languageList ?? [] )
            }, failure: failure)
        }
    
    class func getCountryByLanguages(languageId: String?,success:((_ response:[FFPlaceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        let requestModel = FFCountriesByLanguageRequestModel()
        requestModel.languageId = languageId
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.placesList ?? [] )
        }, failure: failure)
    }
    
    class func addCountryLanguages(userId: String?,countryId: String?,languageId: String?,success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        let requestModel = FFAddCountriesLanguageRequestModel()
        requestModel.userid = userId
        requestModel.countryid = countryId
        requestModel.languageid = languageId
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
    }
    
     class func getStoreTypes(success:((_ response:[FFStoreTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            let requestModel = FFStoreTypeRequestModel()
            shared.addJwtToHeader()
            shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
                
                success?(response.storeTypeList ?? [] )
                
            }, failure: failure)
            
        }
    
    
    class func getMyCategoriesList(success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyCategoriesListRequestModel()
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.interest ?? [])
            
        }, failure: failure)
    }
    
    class func getFollowList(userId:Int?, whichType: String?,success:((_ response:[FFFollowObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyFollowListRequestModel()
        requestModel.whichType = whichType
        requestModel.userId = userId

       // shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.follow ?? [])
            
        }, failure: failure)
    }
    
    class func followMember(memberID:Int?,isDelete: Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFFollowRequestModel()
        requestModel.memberID = memberID
        requestModel.isDelete = isDelete

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    class func likeCategory(isMultiple: Bool?, categoryIDs:[String]?,recipeID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeCategoryRequestModel()
        requestModel.categoryId = recipeID
        requestModel.isMultiple = isMultiple
        requestModel.categoryids = categoryIDs

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func dislikeCategory( recipeID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDislikeCategoryRequestModel()
        requestModel.categoryId = recipeID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    
    class func likeIngredient(isMultiple: Bool?, ingredientIDs:[String]?, recipeID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeIngredientRequestModel()
        requestModel.recipeId = recipeID
        requestModel.isMultiple = isMultiple
        requestModel.ingredientids = ingredientIDs
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func dislikeIngredient(recipeID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDislikeIngredientRequestModel()
        requestModel.recipeId = recipeID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    
    class func getMyInterestsList(success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFMyInterestsListRequestModel()
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response.interest ?? [])
            
        }, failure: failure)
    }
    
    class func registerUser(requestModel:FFRegisterRequestModel, success:((_ response:FFBaseResponseModel?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    
    class func inviteUser(requestModel:FFInviteUserRequestModel, success:((_ response:FFBaseResponseModel?) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    
    class func likeInterest(isMultiple: Bool?, interstIDs:[String]?, interstID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeInterestRequestModel()
        requestModel.ineterstId = interstID
        requestModel.interestids = interstIDs
        requestModel.isMultiple = isMultiple

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    

    class func dislikeInterest(interstID:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDislikeInterestRequestModel()
        requestModel.ineterstId = interstID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func retrievePassword(email:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRetrievePasswordRequestModel()
        requestModel.email = email
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func validateCode(email:String?,code:String?, token:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFValidateCodeRequestModel()
        requestModel.email = email
        requestModel.code = code
        requestModel.resetToken = token
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func resetPassword(email:String?,code:String?, token:String?,password:String?, confirmPwd:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFConfirmPasswordRequestModel()
        requestModel.email = email
        requestModel.code = code
        requestModel.resetToken = token
        requestModel.password = password
        requestModel.confirmPassword = confirmPwd
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: {(response:FFBaseResponseModel) in
            
            success?(response)
            
        }, failure: failure)
    }
    
    class func searchIngredientList(searchText:String?, success:((_ response:[FFRecipeTypeObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFSearchIngredientRequestModel()
        requestModel.searchText  = searchText
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.ingredientList ?? [] )
        }, failure: failure)
        
    }
    
    class func getMeasureList(ingredeintID:String?, success:((_ response:[FFMeasureObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetMeasureRequestModel()
        requestModel.ingredientId  = ingredeintID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.measureList ?? [] )
        }, failure: failure)
        
    }
    
    class func postRecipe(recipeRequest:FFAddRecipeRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
//        recipeRequest?.ingredients = [["id":"589","quantity":"18","measure_id":"1"],["id":"465","quantity":"1","measure_id":"2"]]
        
        
        shared.addJwtToHeader()
        shared.performRequest(recipeRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func postContact(contactRequest:FFPostContactRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            shared.addJwtToHeader()
            shared.performRequest(contactRequest!, success: { (response:FFBaseResponseModel) in
                success?(response )
            }, failure: failure)
            
        }
    
       class func postRestaurant(restaurantRequest:FFAddRestaurantRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
            
            shared.addJwtToHeader()
            shared.performRequest(restaurantRequest!, success: { (response:FFBaseResponseModel) in
                success?(response )
            }, failure: failure)
            
        }
    
    class func changePassword(changePasswordRequest:FFChangePasswordRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        shared.addJwtToHeader()
        shared.performRequest(changePasswordRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func updateAddress(updateAddressRequest:FFUpdateAddressRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        shared.addJwtToHeader()
        shared.performRequest(updateAddressRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func updateProfessionalInfo(professionalRequest:FFUpdateProfessionalInfoRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
         
         shared.addJwtToHeader()
         shared.performRequest(professionalRequest!, success: { (response:FFBaseResponseModel) in
             success?(response )
         }, failure: failure)
         
     }
    
    class func addMenu(menuRequest:FFAddMenuRequestModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        shared.addJwtToHeader()
        shared.performRequest(menuRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    
    class func suggestStore(storeRequest:FFSuggestStorePostModel?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        shared.addJwtToHeader()
        shared.performRequest(storeRequest!, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func getNotifcationList(page:String?, success:((_ response:[FFNotificationObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFNotificationListRequestModel()
        requestModel.page = page
        requestModel.max_results = "30"
        requestModel.id = FFBaseClass.sharedInstance.getUser()?.id ?? 0
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.notificationList ?? [])
        }, failure: failure)
        
    }
    
    
    class func getNotifcationSettingsList( success:((_ response:[FFNotificationObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFNotificationSettingRequestModel()
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.notificationSetting ?? [] )
        }, failure: failure)
        
    }
    
    class func postNotifcationSettings(selectedIds:String, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFPostNotificationRequestModel()
        requestModel.ids = selectedIds
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func enableNotifcationSettings(notifId:String, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFEnableNotificationRequestModel()
        requestModel.notifId = notifId
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func disableNotifcationSettings(notifId:String, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDisableNotificationRequestModel()
        requestModel.notifId = notifId
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func getUserDetails(userID:Int?, success:((_ response:FFUserObject) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetProfileDetailsRequestModel()
        requestModel.userID = userID
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.user!)
        }, failure: failure)
        
    }
    
    class func addFriendByEmail(email:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFAddFriendByEmailRequestModel()
        requestModel.email = email
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func addFriendByNickname(nickname:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFAddFriendByNickNameRequestModel()
        requestModel.nickname = nickname
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func getFriendsList(requestModel:FFriendListRequestModel, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
       // shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func changeProfile(request:FFEditProfileRequestModel, success:((_ response:FFUserObject) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        
        shared.addJwtToHeader()
        shared.performRequest(request, success: { (response:FFBaseResponseModel) in
            success?(response.user!)
        }, failure: failure)
        
    }
    
    class func cancelFriendRequest(id:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFCancelFriendRequestModel()
        requestModel.userID = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func acceptFriendRequest(id:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFAcceptFriendRequestModel()
        requestModel.userID = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func rejectFriendRequest(id:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRejectFriendRequest()
        requestModel.userID = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func blockFriendRequest(id:String?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFBlockFriendRequestModel()
        requestModel.id = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }
    
    class func getNicknameList(searchString:String?, success:((_ response:[FFUserObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFNicknameSearchRequestModel()
        requestModel.searchText = searchString
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.nicknameList ?? [])
        }, failure: failure)
        
    }
    
    class func checkFreind(userId:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFCheckFreindRequestModel()
        requestModel.userId = userId
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response)
        }, failure: failure)
        
    }

    class func getFavRestaurantsList(id:String?, success:((_ response:[FFRestaurantObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetFavRestaurantListRequestModel()
        requestModel.userID = id
        requestModel.page = "1"

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.favrestaurantList ?? [] )
        }, failure: failure)
        
    }
    
    class func getRestaurantsList(page:String?, maxResult:String?, success:((_ response:[FFRestaurantObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRestaursntListRequestModel()
        requestModel.country_id = "1"
        requestModel.page = page
        requestModel.maxResults = maxResult
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.restaurantList ?? [] )
        }, failure: failure)
        
    }
    
    
    class func getRestaurantsListCityWise(id:String?, success:((_ response:[FFRestaurantObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRestaurantListCityWiseRequestModel()
        requestModel.city_id = id
        requestModel.page = "1"
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.restaurantList ?? [] )
        }, failure: failure)
        
    }
    class func getStoresList(id:String?, success:((_ response:[FFStoreObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFStoreListModel()
        requestModel.typeId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeList ?? [] )
        }, failure: failure)
        
    }
    
    class func getStoresListCityWise(id:String?, success:((_ response:[FFStoreObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFStoreListCityWiseModel()
        requestModel.city_id = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeList ?? [] )
        }, failure: failure)
        
    }
    
    class func getRestaurantDetail(id:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRestaurantDetailRequestModel()
        requestModel.restaurantID = id
        if let usr = FFBaseClass.sharedInstance.getUser(){
            requestModel.userID = "\(usr.id ?? 0)"

        }
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func getStoreDetail(id:Int?, success:((_ response:FFStoreObject) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFStoreDetailModel()
        requestModel.storeId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeDetail! )
        }, failure: failure)
        
    }
    
    class func getStoreProductCategories(id:Int?, success:((_ response:[FFStoreProductCategoriesObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFStoreProductCategoriesRequestModel()
        requestModel.fromWhere = "categories"
        requestModel.storeId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeProductCategoriesList ?? [] )
        }, failure: failure)
        
    }
    class func getStoreProducts(id:Int?, success:((_ response:[FFStoreProductsObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFStoreProductCategoriesRequestModel()
        requestModel.storeId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeProductsList ?? [] )
        }, failure: failure)
        
    }
    class func getFunctionList(type:String?, success:((_ response:[FFPlaceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFFunctionModel()
        requestModel.fromWhere = type
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.placesList ?? [] )
        }, failure: failure)
        
    }
    
    class func getAllInterestList( success:((_ response:[FFAllInterestObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
           let requestModel = FFFunctionModel()
        requestModel.fromWhere = "allinterest"
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.allInterest ?? [] )
        }, failure: failure)

        
    }
    
    class func getCountriesList(searchText:String?, success:((_ response:[FFPlaceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetCountriesRequestModel()
        requestModel.searchText = searchText
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.placesList ?? [] )
        }, failure: failure)
        
    }
    
    class func getRegionsList(searchText:String?,countryid:String?, success:((_ response:[FFPlaceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetRegionsRequestModel()
        requestModel.countryid  = countryid
        requestModel.searchText = searchText

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.placesList ?? [] )
        }, failure: failure)
        
    }
    
    class func getCitiesList(searchText:String?,countryid:String?,regionid:String?, success:((_ response:[FFPlaceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetCitiesRequestModel()
        requestModel.countryid  = countryid
        requestModel.regionid = regionid
        requestModel.searchText = searchText

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.placesList ?? [] )
        }, failure: failure)
        
    }
    
    class func searchRestaurants(serchText:String?,countryid:String?,regionid:String?,cityid:String?, success:((_ response:[FFRestaurantObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFSearchRestaurantsRequestModel()
        requestModel.countryid  = countryid
        requestModel.regionid = regionid
        requestModel.cityid = cityid
        requestModel.searchText = serchText
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.restaurantList ?? [] )
        }, failure: failure)
        
    }
    
    
    class func searchStores(page:String?, maxResult:String?, typeid:String?,serchText:String?,countryid:String?,regionid:String?,cityid:String?, success:((_ response:[FFStoreObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFSearchStoreRequestModel()
        requestModel.countryid  = countryid
        requestModel.regionid = regionid
        requestModel.cityid = cityid
        requestModel.searchText = serchText
        requestModel.typeid = typeid
        requestModel.page = page
        requestModel.itemsperpage = maxResult

        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.storeList ?? [] )
        }, failure: failure)
        
    }
    
    class func likeRestaurant(id:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeRestaurantRequestModel()
        requestModel.restaurantid = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func dislikeRestaurant(id:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDislikeRestaurantRequestModel()
        requestModel.restaurantid = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func likeStore(id:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFLikeStoreRequestModel()
        requestModel.storeid = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func dislikeStore(id:Int?, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFDisLikeStoreRequestModel()
        requestModel.storeid = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func getRestaurantRecipes(id:Int?, success:((_ response:[FFEntranceObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetRestaurantRecipeRequestModel()
        requestModel.restaurantId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.itemList ?? [] )
        }, failure: failure)
        
    }
    
    class func getRestaurantMenus(id:Int?, success:((_ response:[FFRestaurantMenuObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFRestaurantMenuModel()
        requestModel.restId = id
        shared.addJwtToHeader()
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.menuList ?? [] )
        }, failure: failure)
        
    }
    
    class func getRestaurantActivities(id:Int?, success:((_ response:[FFRestaurantObject]) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let requestModel = FFGetRestaurantActivityRequestModel()
        requestModel.restaurantId = id
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response.restaurantList ?? [] )
        }, failure: failure)
        
    }
    
    class func subscribeRestaurant(requestModel:FFRestaurantSubscribeRequestModel, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
       
        shared.addJwtToHeader()
        
        shared.performRequest(requestModel, success: { (response:FFBaseResponseModel) in
            success?(response )
        }, failure: failure)
        
    }
    
    class func uploadImage(imageUrl:URL, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let request = shared.sessionManager.upload(multipartFormData: { formdata in
            formdata.append(imageUrl, withName: "files[0]")
            formdata.append("Rachit".data(using: String.Encoding.utf8)!, withName: "name")
            formdata.append("recipes".data(using: String.Encoding.utf8)!, withName: "type")
            formdata.append("fr".data(using: String.Encoding.utf8)!, withName: "lang")
            
            print("...")
        }, to: "https://media.friends-and-food.com/uploader.php", usingThreshold: UInt64.init(), method: HTTPMethod.post, headers: ["APIKEY":"ffrbger3425tRqvs23@HR"])
        
        request.responseObject { (response:DataResponse<FFBaseResponseModel, AFError>) in
            
            switch response.result {
                
            case .success(let responseModel):
                
                if let _ = responseModel.files {
                    
                    success?(responseModel)
                } else {
                    failure?(NSError.error(with: responseModel.message))
                }
                
                break
                
            case .failure(let error):
                print(error)
                if (error as NSError).domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }
                
                break
            }
        }
        
   
        //Old Code
        /*shared.sessionManager.upload(multipartFormData: { (formdata) in
            
            formdata.append(imageUrl, withName: "files[0]")
          formdata.append("Rachit".data(using: String.Encoding.utf8)!, withName: "name")
            formdata.append("recipes".data(using: String.Encoding.utf8)!, withName: "type")
            formdata.append("fr".data(using: String.Encoding.utf8)!, withName: "lang")
            
            
            print("...")
        }, usingThreshold: UInt64.init(), to: "https://media.friends-and-food.com/uploader.php", method: HTTPMethod.post, headers: ["APIKEY":"ffrbger3425tRqvs23@HR"]) { (encodeResult) in
            switch encodeResult {
            case .success(request: let request, streamingFromDisk: let stream, streamFileURL: let fileUrl):

//                request.responseJSON(completionHandler: { (response) in
//                    print(response)
//                })
                request.uploadProgress { progress in
                    print(progress.fractionCompleted)
                }
//                request.log()
                
                request.responseObject { (response:DataResponse<FFBaseResponseModel>) in
                    
                    
                    switch response.result {
                        
                    case .success(let responseModel):
                        
                        if let _ = responseModel.files {
                            
                            success?(responseModel)
                        } else {
                            failure?(NSError.error(with: responseModel.message))
                        }
                        
                        break
                        
                    case .failure(let error):
                        print(error)
                        if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                            failure?(NSError.error(with: "Unknown server error"))
                        }else{
                            failure?(error as NSError)
                        }
                        
                        break
                    }
                    
                }
             
                
            case .failure(let error):
                print(error)
            }
        }*/
    }

    
    class func uploadImageNew(imageUrl:URL, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let parameters = [
            "name":"Rachit",
            "type" : "recipes",
            "lang": "fr",
        ] as [String : String]
        
        let header : HTTPHeaders = [
            "APIKEY":"ffrbger3425tRqvs23@HR",
        ]
        let imageData = NSData(contentsOf: imageUrl)
        
        let request = shared.sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData! as Data, withName: "file",fileName: "image.jpg", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        }, to: "http://media.friends-and-food.com/uploader.php", method: HTTPMethod.post, headers: header)
        
        request.responseObject { (response:DataResponse<FFBaseResponseModel, AFError>) in
            switch response.result {

            case .success(let responseModel):

                if let _ = responseModel.files {

                    success?(responseModel)
                } else {
                    failure?(NSError.error(with: responseModel.message))
                }

                break

            case .failure(let error):
                print(error)
                if (error as NSError).domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }

                break
            }
        }
        
        
        //Old Code
        /*let parameters = ["name":"Rachit",
                          "type" : "recipes",
                          "lang": "fr",
        ] as [String : String]
        let header = ["APIKEY":"ffrbger3425tRqvs23@HR"]
        let imageData = NSData(contentsOf: imageUrl)

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData! as Data, withName: "file",fileName: "image.jpg", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to:"http://media.friends-and-food.com/uploader.php",
                         headers: header
        ){ (encodeResult) in
            switch encodeResult {
            case .success(request: let request, streamingFromDisk: let stream, streamFileURL: let fileUrl):

                //                request.responseJSON(completionHandler: { (response) in
                //                    print(response)
                //                })
                request.uploadProgress { progress in
                    print(progress.fractionCompleted)
                }
                //                    request.log()

                request.responseObject { (response:DataResponse<FFBaseResponseModel>) in


                    switch response.result {

                    case .success(let responseModel):

                        if let _ = responseModel.files {

                            success?(responseModel)
                        } else {
                            failure?(NSError.error(with: responseModel.message))
                        }

                        break

                    case .failure(let error):
                        print(error)
                        if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                            failure?(NSError.error(with: "Unknown server error"))
                        }else{
                            failure?(error as NSError)
                        }

                        break
                    }

                }


            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    class func uploadImageData(imageData:Data, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let parameters = [
            "name":"Rachit",
            "type" : "recipes",
            "lang": "fr",
        ] as [String : String]
        
        let header : HTTPHeaders = [
            "APIKEY":"ffrbger3425tRqvs23@HR",
        ]
        
        let request = shared.sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData as Data, withName: "files",fileName: "image.jpg", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        }, to: "http://media.friends-and-food.com/uploader.php", method: HTTPMethod.post, headers: header)
        
        request.responseObject { (response:DataResponse<FFBaseResponseModel, AFError>) in
            switch response.result {

            case .success(let responseModel):

                if let _ = responseModel.files {

                    success?(responseModel)
                } else {
                    failure?(NSError.error(with: responseModel.message))
                }

                break

            case .failure(let error):
                print(error)
                if (error as NSError).domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }

                break
            }
        }
        
        
        //Old Code
        /*let parameters = ["name":"Rachit",
                          "type" : "recipes",
                          "lang": "fr",
        ] as [String : String]
        let header = ["APIKEY":"ffrbger3425tRqvs23@HR"]

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData as Data, withName: "files",fileName: "image.jpg", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to:"http://media.friends-and-food.com/uploader.php",
                         headers: header
        ){ (encodeResult) in
            switch encodeResult {
            case .success(request: let request, streamingFromDisk: let stream, streamFileURL: let fileUrl):

                //                request.responseJSON(completionHandler: { (response) in
                //                    print(response)
                //                })
                request.uploadProgress { progress in
                    print(progress.fractionCompleted)
                }
                //                    request.log()

                request.responseObject { (response:DataResponse<FFBaseResponseModel>) in


                    switch response.result {

                    case .success(let responseModel):

                        if let _ = responseModel.files {

                            success?(responseModel)
                        } else {
                            failure?(NSError.error(with: responseModel.message))
                        }

                        break

                    case .failure(let error):
                        print(error)
                        if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                            failure?(NSError.error(with: "Unknown server error"))
                        }else{
                            failure?(error as NSError)
                        }

                        break
                    }

                }


            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    class func uploadRestImageData(imageName: String, imageData:Data, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let parameters = [
            "":""
        ] as [String : String]
        
        let header : HTTPHeaders = [
            "APIKEY":"ffrbger3425tRqvs23@HR",
            "Authorization": "\(FFBaseClass.sharedInstance.currentJwt ?? "")"
        ]
        
        let request = shared.sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData as Data, withName: "files",fileName: "\(imageName)", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        }, to: "https://api.friends-and-food.com/uploadImage", method: HTTPMethod.post, headers: header)
        
        request.responseObject { (response:DataResponse<FFBaseResponseModel, AFError>) in
            switch response.result {

            case .success(let responseModel):

                if let _ = responseModel.files {

                    success?(responseModel)
                } else {
                    failure?(NSError.error(with: responseModel.message))
                }

                break

            case .failure(let error):
                print(error)
                if (error as NSError).domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }

                break
            }
        }
        
        
        //Old Code
        /*let parameters = ["":"",
        ] as [String : String]
        let header = ["APIKEY":"ffrbger3425tRqvs23@HR",
                      "Authorization": "\(FFBaseClass.sharedInstance.currentJwt ?? "")"
        ]

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData as Data, withName: "files",fileName: "\(imageName)", mimeType: "image/jpg")

            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to:"https://api.friends-and-food.com/uploadImage",
                         headers: header
        ){ (encodeResult) in
            switch encodeResult {
            case .success(request: let request, streamingFromDisk: let stream, streamFileURL: let fileUrl):

                //                request.responseJSON(completionHandler: { (response) in
                //                    print(response)
                //                })
                request.uploadProgress { progress in
                    print(progress.fractionCompleted)
                }
                //                    request.log()

                request.responseObject { (response:DataResponse<FFBaseResponseModel>) in


                    switch response.result {

                    case .success(let responseModel):

                        if let _ = responseModel.files {

                            success?(responseModel)
                        } else {
                            failure?(NSError.error(with: responseModel.message))
                        }

                        break

                    case .failure(let error):
                        print(error)
                        if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                            failure?(NSError.error(with: "Unknown server error"))
                        }else{
                            failure?(error as NSError)
                        }

                        break
                    }

                }


            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    class func uploadProfileImageData(request: FFEditProfileRequestModel, imageData:Data,imageName: String, success:((_ response:FFBaseResponseModel) -> Void)?, failure:((_ error:NSError) -> Void)?){
        
        let parameters = [
            "first_name":request.firstname,
            "last_name":request.lastName,
            "email":request.email,
            "ok":request.ok,
            "gender":request.gender,
            "birthdate":request.birthdate,
            "phone":request.phone,
        ] as! [String : String]
        
        let header : HTTPHeaders = [
            "APIKEY":"ffrbger3425tRqvs23@HR",
            "Authorization": "\(FFBaseClass.sharedInstance.currentJwt ?? "")"
        ]
        
        let request = shared.sessionManager.upload(multipartFormData: { multipartFormData in
            if !imageName.isEmpty{
                multipartFormData.append(imageData as Data, withName: "img",fileName: "\(imageName)", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        }, to: "\(BaseAPI.shared.BASE_URL)user/\(UserDefault.standard.getSelectedLanguage())/\(request.id ?? "")", method: HTTPMethod.post, headers: header)
        
        request.responseObject { (response:DataResponse<FFBaseResponseModel, AFError>) in
            
            switch response.result {

            case .success(let responseModel):
                success?(responseModel)


                break

            case .failure(let error):
                print(error)
                if (error as NSError).domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }

                break
            }
        }
        
        
        //Old Code
        /*let parameters = [
            "first_name":request.firstname,
            "last_name":request.lastName,
            "email":request.email,
            "ok":request.ok,
            "gender":request.gender,
            "birthdate":request.birthdate,
            "phone":request.phone,
        ] as! [String : String]
        let header = ["APIKEY":"ffrbger3425tRqvs23@HR",
                      "Authorization": "\(FFBaseClass.sharedInstance.currentJwt ?? "")"
        ]

        Alamofire.upload(multipartFormData: { multipartFormData in
            if !imageName.isEmpty{
                multipartFormData.append(imageData as Data, withName: "img",fileName: "\(imageName)", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to:"\(BaseAPI.shared.BASE_URL)user/\(UserDefault.standard.getSelectedLanguage())/\(request.id ?? "")",
                         headers: header
        ){ (encodeResult) in
            switch encodeResult {
            case .success(request: let request, streamingFromDisk: let stream, streamFileURL: let fileUrl):

                //                request.responseJSON(completionHandler: { (response) in
                //                    print(response)
                //                })
                request.uploadProgress { progress in
                    print(progress.fractionCompleted)
                }
                //                    request.log()

                request.responseObject { (response:DataResponse<FFBaseResponseModel>) in


                    switch response.result {

                    case .success(let responseModel):
                        success?(responseModel)


                        break

                    case .failure(let error):
                        print(error)
                        if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                            failure?(NSError.error(with: "Unknown server error"))
                        }else{
                            failure?(error as NSError)
                        }

                        break
                    }

                }


            case .failure(let error):
                print(error)
            }
        }*/
    }
    
}
