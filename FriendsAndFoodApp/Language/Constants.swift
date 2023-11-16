//
//  Constants.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 17/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import UIKit

enum StringConstants {
    enum indicateAddress {
        static var Indicateyouraddress : String { return "Indicate your address !".localized }
        static var Receivecustomlocalrestaurantsandshops : String { return "Receive custom local restaurants and shops recommendations by entering your address.".localized }
        static var Selectacountry : String { return "Select a country".localized }
        static var Selectaregion : String { return "Select a region".localized }
        static var Selectacity : String { return "Select a city".localized }
        static var Enteryourzipcode : String { return "Enter your zip code".localized }
        static var Enteryouraddress : String { return "Enter your address".localized }
        static var Nextstep : String { return "Next step".localized }
    }

    enum selectLanguages {
        static var Selectyourlanguage : String { return "Select your language ?".localized }
        static var Selectyourcountryfromthelist : String { return "Select your country from the list".localized }

    }
    enum userPreference {
        static var Hi : String { return "Hi".localized }
        static var welcometoFriendsFood : String { return "Welcome to Friends & Food, let's talk about you and what you prefer in order to personalize your recipe suggestions".localized }
        static var Whichdietsarerightforyou : String { return "Which diets are right for you ?".localized }
        static var Everythingsuitsme : String { return "Everything suits me !".localized }
        static var Checkyourdesiresamongthesethemes : String { return "Check your desires among these themes".localized }
        static var Beginner : String { return "Beginner".localized }
        static var Intermediate : String { return "Intermediate".localized }
        static var Expert : String { return "Expert".localized }
        static var Indicateyourlevelincooking : String { return "Indicate your level in cooking".localized }
        static var thisisindicativeinorder : String { return "This is indicative in order to offer you cooking challenges that correspond to your level.".localized }
        static var IngredientsthatIdontreallylike : String { return "Ingredients that I don't really like".localized }
        static var Byaddingwhatyoudonlike : String { return "By adding what you don't like, the app spares you the recipes that contain any of these ingredients.".localized }
        static var Welldone : String { return "Well done !".localized }
        static var YourFriendsFoodaccountisperfectlyconfigured : String { return "Your Friends & Food account is perfectly configured.".localized }



    }
    enum messaging {
        static var Messagingwith : String { return "Messaging with".localized }
    }

    enum cgu {
        static var cgu_url : String { return "cgu_url".localized }
    }

    enum faq {
        static var Frequentlyaskedquestions : String { return "Frequently asked questions".localized }
    }
    
    enum thematic {
        static var DishesType : String { return "Dishes Type".localized }
        static var IngredientsFamily : String { return "Ingredients Family".localized }
     
    }
    
    enum MyFriends {
        static var MyFriends : String { return "My Friends".localized }
        static var Youhavenorequestsatthismoment : String { return "You have no requests at this moment".localized }
        static var Youhavenoinvitationsatthismoment : String { return "You have no invitations at this moment".localized }

    }
        
    enum nonProfessionalHome {
        static var Recipes : String { return "Recipes".localized }
        static var Restaurants : String { return "Restaurants".localized }
        static var Commerces : String { return "Commerces".localized }
        static var QA : String { return "Q&A".localized }
        static var Friends : String { return "Friends".localized }

    }

    
    enum iLike {
        static var Ilike : String { return "I like".localized }
        static var Inolongerlike : String { return "I no longer like".localized }
        static var Ingredients : String { return "Ingredients".localized }
        static var Interests : String { return "Interests".localized }
    }

    enum recipes {
        static var Other : String { return "Other".localized }
        static var Enterdishtype : String { return "Enter dish type".localized }
        static var Entertitle : String { return "Enter title".localized }
        static var Enterdifficultylevel : String { return "Enter difficulty level".localized }

        static var Enterpreparationtime : String { return "Enter preparation time".localized }
        static var Entercookingtime : String { return "Enter cooking time".localized }
        static var Selecttheme : String { return "Select theme".localized }
        static var Selectcategory : String { return "Select category".localized }
        static var maximumof12ingredients : String { return "Only a maximum of 12 ingredients can be added".localized }
        static var maximumof12steps : String { return "Only maximum of 12 steps can be added".localized }
        static var Enternumberofpersons : String { return "Enter number of persons".localized }
        static var Enteratleastoneingredient : String { return "Enter atleast one ingredient".localized }
        static var Enterquantity : String { return "Enter quantity".localized }
        static var Selectmeasure : String { return "Select measure".localized }
        static var maximum6images : String { return "A maximum of only 6 images can be added".localized }
        static var Addatleastoneimage : String { return "Add atleast one image".localized }
        static var Enteratleastonestep : String { return "Enter atleast one step".localized }

        static var zerocal : String { return "0 cal".localized }
        static var For : String { return "For".localized }
        static var persons : String { return "persons".localized }
        static var min : String { return "min".localized }
        static var hr : String { return "hr".localized }
        static var Step : String { return "Step".localized }
    }
    
    enum addStore {
        static var ChooseanImage : String { return "Choose an Image".localized }
        static var Takeanimage : String { return "Take an image".localized }
        static var Searchinthegallery : String { return "Search in the gallery".localized }
        static var Cancel : String { return "Cancel".localized }

        static var Entertheactivityofthestore : String { return "Enter the activity of the store".localized }
        static var max6images : String { return "A maximum of only 6 images can be added".localized }
        static var Youdonthavecamera : String { return "You don't have camera".localized }
        static var Warning : String { return "Warning".localized }
        static var OK : String { return "OK".localized }
        static var EnterOfficialnameoftheestablishment : String { return "Enter Official name of the establishment".localized }
        static var Enterthecountry : String { return "Enter the country".localized }
        static var Enterthecity : String { return "Enter the city".localized }
        static var Enterthepostalcode : String { return "Enter the postal code".localized }
        static var Enterthenumberstreet : String { return "Enter the number and street".localized }
        static var Enterthephone : String { return "Enter the phone".localized }
        static var Entertherestaurantemail : String { return "Enter the restaurant email".localized }
        static var EnterthewebsiteURL : String { return "Enter the website URL".localized }
        static var Enterthefacebookpage : String { return "Enter the facebook page".localized }

    }
    
    enum favourites{
        static var Favoriteslist : String { return "Favorites list".localized }
        static var MYRECIPE : String { return "MY RECIPE".localized }
        static var MyStore : String { return "My Store".localized }
        static var MyFollowers : String { return "My Followers".localized }
    }
    
    enum Profile {
        static var UPDATEPERSONALADDRESS : String { return "UPDATE PERSONAL ADDRESS".localized }
        static var UPDATEPROFESSIONALADDRESS : String { return "UPDATE PROFESSIONAL ADDRESS".localized }

    }
    enum store{
        static var Products : String { return "Products".localized }

    }
    
    enum Menu {
        static var home : String { return "home".localized }
        static var my_recipes : String { return "my_recipes".localized }
        static var my_preferred_restaurants : String { return "my_preferred_restaurants".localized }
        static var my_favorite : String { return "my_favorite".localized }
        static var i_like : String { return "i_like".localized}
        static var my_friends : String { return "my_friends".localized}
        static var stores : String { return "stores".localized}
        static var preferences : String { return "preferences".localized}
        static var languages : String { return "languages".localized}
        static var notifications : String { return "notifications".localized}
        static var contact_us : String { return "contact_us".localized}
        static var logout : String { return "logout".localized}
        static var AllTheRecipes : String { return "All The Recipes".localized}
        static var WhatILike : String { return "What I Like".localized}

    }
    
    enum bottomTab {
        static var home : String { return "home".localized }
        static var EatWell : String { return "Eat Well".localized }
        static var Thematic : String { return "Thematic".localized }
        static var Profile : String { return "Profile".localized }
        static var Followers : String { return "Followers".localized }
        static var Reviews : String { return "Reviews".localized }

    }

    enum restaurantstore {
        static var Sunday : String { return "Sunday".localized }
        static var Monday : String { return "Monday".localized }
        static var Tuesday : String { return "Tuesday".localized }
        static var Wednesday : String { return "Wednesday".localized }
        static var Thursday : String { return "Thursday".localized}
        static var Friday : String { return "Friday".localized}
        static var Saturday : String { return "Saturday".localized}
        static var closed : String { return "closed".localized}
        static var Inthemorning : String { return "In the morning".localized}
        static var Intheevening : String { return "In the evening".localized}
        static var nodataowner : String { return "no data given by the owner".localized}
        static var Callus : String { return "Call us".localized}
        
        static var Sendemail : String { return "Send email".localized}
        static var emailnotgivenbyowner : String { return "email wasn't given by the owner".localized}
        static var Website : String { return "Website".localized}
        static var websitenotgivenbyowner : String { return "website wasn't given by the owner".localized}
        static var Facebook : String { return "Facebook".localized}
        static var facebooknotgivenbyowner : String { return "facebook page wasn't given by the owner".localized}
        static var nomenu : String { return "There are no menu for this restaurant".localized}
        static var UpdateInfo : String { return "Update Info".localized}
        static var Ownerconfirmation : String { return "Owner confirmation".localized}
        static var areyouowner : String { return "Are you the owner of this store?".localized}
        
        static var Yes : String { return "Yes".localized}
        static var No : String { return "No".localized}
        static var Confirmation : String { return "Confirmation".localized}
        static var Pleaseconfirmthatprofessional : String { return "Please confirm that you are a professional ?".localized}
        static var Iconfirm : String { return "I confirm".localized}
        static var Later : String { return "Later".localized}
        static var reviewsonthisstore : String { return "reviews on this store".localized}
        static var expensive : String { return "expensive".localized}
        static var cheap : String { return "cheap".localized}
        static var Affordable : String { return "Affordable".localized}

        static var reviewsonthisrestaurant : String { return "reviews on this restaurant".localized}
        static var noproducts : String { return "There are no products for this store".localized}
        static var areyouownerrest : String { return "Are you the owner of this restaurant?".localized}
        
        static var Emailisnotvalid : String { return "Email is not valid".localized}
        static var EnterEmail : String { return "Enter Email".localized}
        static var Enterrestaurantemail : String { return "Enter restaurant email".localized}
        static var Selectatleastoneinterest : String { return "Select at least one interest".localized}
        static var EnterCulinarySpecialties : String { return "Enter Culinary Specialties".localized}
        static var Enterpricerange : String { return "Enter price range".localized}
        static var acceptterms : String { return "Kindly accept terms and conditions".localized}
        static var Pleaseselectacountryfirst : String { return "Please select a country first".localized}
        static var Sorrywedidnotfindanyresults : String { return "Sorry, we did not find any results".localized}
    }

    enum Response {
        static var Status : String { return "status".localized }
        static var Message : String { return "message".localized }
        static var Result : String { return "result".localized }
        static var Success : String { return "success".localized }
        static var Error : String { return "error".localized}
    }
    
    enum Buttons {
        static var submit : String { return "submit".localized }


    }
    
    enum Labels {
        static var forgotPassword : String { return "forgotPassword".localized }
        static var agreeterms : String { return "By using friends & food, you agree on our Terms of Service and Privacy Policy".localized }
        static var zerocal : String { return "0 cal".localized }
        static var forlabel : String { return "For".localized }
        static var persons : String { return "persons".localized }
        static var min : String { return "min".localized }
        static var hr : String { return "hr".localized }
        static var step : String { return "Step".localized }
        static var reviewsonthisrecipe : String { return "reviews on this recipe".localized }
        static var reviewonthisrecipe : String { return "review on this recipe".localized }
        static var MYSELF : String { return "Myself".localized }

        static var AdvancedRecipeSearch : String { return "Advanced Recipe Search".localized }
        static var AdvancedRestaurantsearch : String { return "Advanced Restaurant search".localized }
        static var Menu : String { return "Menu".localized }
        static var Info : String { return "Info".localized }
        static var fooders : String { return "fooders".localized }
        static var AddaFriend : String { return "Add a Friend".localized }
        static var Entrances : String { return "Entrances".localized }
        static var Dishes : String { return "Dishes".localized }
        static var Desserts : String { return "Desserts".localized }
        static var Nutrition : String { return "Nutrition".localized }
        static var Ingredientdetails : String { return "Ingredient details".localized }
        static var Variance : String { return "Variance".localized }
        static var Norecipesfound : String { return "No recipes found".localized }
        static var Title : String { return "Title".localized }
        static var Description : String { return "Description".localized }
        static var Message : String { return "Message".localized }

    }
    
    enum Alert {
        
        enum Titles {
            static var Error : String { return "Error".localized }
            static var Success : String { return "Success".localized }
            static var AppName : String { return "Friends And Food" }
            static var oops: String { return "oops".localized }
            static var areYouSure: String { return "areYouSure".localized }

            
        }
        
        enum Messages {
            static var NoInternet : String { return "NoInternet".localized }
            static var fieldRequired : String { return "This field is required".localized }
            static var Incorrectemail : String { return "Incorrect e-mail".localized }
            static var Incorrectpassword : String { return "Incorrect password".localized }
            static var Invalidfield : String { return "Invalid field".localized }
            static var Passwordsdonotmatch : String { return "Passwords do not match".localized }
            static var agreeterms : String { return "By using friends & food, you agree on our Terms of Service and Privacy Policy".localized }

        }
        
        enum Actions {
            static var Okay : String { return "Okay".localized }
            static var exit : String { return "exit".localized }

        }
    }
}
