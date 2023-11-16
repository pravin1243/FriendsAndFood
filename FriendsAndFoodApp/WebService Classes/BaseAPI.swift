//
//  BaseAPI.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
//import AlamofireActivityLogger

class BaseAPI: NSObject {

//    let BASE_URL = "http://api.ff.mydigitalys.com/fr/"
//    http://3.93.8.125:8090/api/user/en/login

    //let BASE_URL = "https://api.friends-and-food.com/"
    
    //New Test Base URL
    let BASE_URL = "https://api.friends-and-food.fr/"
    
//    let BASE_URL = "http://3.93.8.125:8090/api/user/en/"
    static let shared = BaseAPI()
//    var headerDict:[String:String] = ["APIKEY":"ffrbger3425tRqvs23@HR"]
    var headerDict: HTTPHeaders = [
        "APIKEY" : "ffrbger3425tRqvs23@HR"
    ]
    
    let sessionManager = Session.default
    
//    func addJwtToHeader(){
//        if let _ = FFBaseClass.sharedInstance.getUser() {
//         headerDict["Authorization"] = FFBaseClass.sharedInstance.currentJwt
//        }
//    }
    
    
    func addJwtToHeader(){
        if let jwt = FFBaseClass.sharedInstance.getJWT() {
            //headerDict["Authorization"] = jwt
        }
    }

    func performRequest<T:FFBaseResponseModel>(_ requestModel:FFBaseRequestModel, success:((_ response:T) -> Void)?, failure:((_ error:NSError) -> Void)?) {
//        if Connectivity.isConnectedToInternet {
//             print("Connected")
//         } else {
//             print("No Internet")
//            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//
//        }

        let requestURL = URL(string: BASE_URL)!.appendingPathComponent(requestModel.requestURL())
        
        let params = requestModel.toJSON()

        var request : DataRequest?
//        if requestModel is FFAddRecipeRequestModel {
//
////         request = sessionManager.request(requestURL, method: .post, parameters: params, encoding: URLEncoding.ArrayEncoding.noBrackets, headers:headerDict)
//            let encoding = URLEncoding(arrayEncoding: .noBrackets)
//          request =   sessionManager.request(requestURL, method: HTTPMethod.post, parameters: params, encoding: encoding, headers: headerDict)
//        }else {
        print("URL is: \(requestURL) and header is: \(headerDict) and parameter is: \(params)")
          request = sessionManager.request(requestURL, method: requestModel.requestMethod(), parameters: params, encoding: URLEncoding.default, headers:headerDict)
//        }
    
       
        
        #if DEBUG
//        request?.log()
        
        #endif
        

        request?.responseObject { (response:AFDataResponse<T>) in
            
            print("response is: \(response.result)")
            switch response.result {
              
            case .success(let responseModel):
                
                if let status = responseModel.status, status == 1 {
                    let str = String(decoding: response.data ?? Data(), as: UTF8.self)
                    print(str)
                    success?(responseModel)
//                    if let jsonData = str.data(using: .utf8) {
//                        do {
//                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                            
//                            if let jsonDictionary = jsonObject as? [String: Any] {
//                                // Now you can work with the JSON dictionary
//                                print(jsonDictionary)
//                                if let dic = jsonDictionary["result"] as? [String: AnyObject] {
//                                    success?(responseModel)
//                                }
//                                else if let arr = jsonDictionary["result"] as? [[String: AnyObject]], arr.count > 0{
//                                    success?(responseModel)
//                                }
//                                else {
//                                    failure?(NSError.error(with: responseModel.message))
//                                }
//                                    
//                            }  else {
//                                print("Invalid JSON format")
//                            }
//                        } catch {
//                            print("Error parsing JSON: \(error)")
//                        }
//                    } else {
//                        print("Invalid UTF-8 data")
//                    }
                } else {
                    failure?(NSError.error(with: responseModel.message))
                }
                
                break
                
            case .failure(let error):
                print(error)
                if response.response?.statusCode == 500{
                    failure?(NSError.error(with: "Sorry, we have some troubles on app, please reload in few minutes"))
                    return
                }
                
                if (error as? NSError)?.domain == "com.alamofireobjectmapper.error"{
                    failure?(NSError.error(with: "Unknown server error"))
                }else{
                    failure?(error as NSError)
                }
                
                break
            }
            
        }
    
    }
}
    
    extension NSError {
        
        class func error(with decription:String?) -> NSError {
            
            let error = NSError(domain: "Food and Friends", code: -562, userInfo: [NSLocalizedDescriptionKey: decription ?? ""])
            return error
        }
    }

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
