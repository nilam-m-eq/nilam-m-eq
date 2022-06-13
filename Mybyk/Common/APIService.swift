//
//  APIService.swift
//  Mybyk
//
//  Created by Parth Kapadia on 04/08/21.
//

import UIKit
import AFNetworking

class APIService: NSObject
{
    
    typealias BlockResultDictionary = (_ result:[String: Any]) -> Void
//    typealias BlockResultDictionary = (_ result:Data) -> Void
    typealias BlockResultError = (_ error:Error) -> Void
    typealias BlockResultUploadPercentage = (_ percentage:Double) -> Void
    
    static let sharedInstance = APIService()
    
    
    func getCountryCodeAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError)
    {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCountryCodeList, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func getBannerImageMobileOTP(dicBannerBodyParama  dic : [String : Any],resultHandler blockResult : @escaping BlockResultDictionary, blockerror blockError : @escaping BlockResultError)
    {
        //WsMobileBannerImage
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsMobileBannerImage, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsMobileBannerImage)
            
            if let response = response as? [String:Any]
            {
          //      print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
      //      print(error)
            blockError(error)
            
        }
    }
    func getDocType(dicBannerBodyParama  dic : [String : Any],resultHandler blockResult : @escaping BlockResultDictionary, blockerror blockError : @escaping BlockResultError)
    {
        //WsMobileBannerImage
        
      //  let headers = ["bearer":strBearer]
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsDocType, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsDocType)
            
            if let response = response as? [String:Any]
            {
          //      print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
      //      print(error)
            blockError(error)
            
        }
    }
    func checkIsUserExistAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsIsUser, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func signIsWithPasswordAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsLogin, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getForgotPassOTPAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsLogin, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getForgotPassResendOTPAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRequestOTP, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getLoginResendOTPAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRequestOTP, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func forgotPassVerifyOTPAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsLogin, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsLogin)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func getEventDetail(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsEventDetail, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsEventDetail)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func ReferDetail(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsReferDetail, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsReferDetail)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func loginVerifyOTPAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsVerifyOTP, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsVerifyOTP)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func loginRequestAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsLogin, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsLogin)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    
    func resetPasswordAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey": strTempAuthKey]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsResetPassword, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsResetPassword)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func registerUserAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRegister, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRegister)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func referralNewRegisterAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRegister, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRegister)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func homeAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsIndex, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsIndex)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func GetFAQ(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsFAQList, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsFAQList)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func GetFAQDetails(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsFAQDeteail, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsFAQDeteail)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func GetUserGuide(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsUserGuide, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsUserGuide)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    //
    
    func checkHubRestrictedOrNotAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsIndex, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsIndex)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func selectCycleAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCycleList, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCycleList)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func loadRideDetails(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRideDetails, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRideDetails)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func notificationFetchAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsAllPushNotifications, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsAllPushNotifications)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getWalletBalanceAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsAddBalance, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsAddBalance)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func getPaytmCheckSum( dictionary dic: [String: Any] , resultHandler blockResult:  @escaping BlockResultDictionary,blockerror:  @escaping BlockResultError ) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
      //  let AuthKey = UserDefaults.standard.string(forKey: "authkey")
        
   //     manager.requestSerializer.setValue(AuthKey, forHTTPHeaderField: "authkey")
    //    manager.requestSerializer.setValue("PB7B99HBUNR9WQHPZTW02Z9JD92", forHTTPHeaderField: "bearer")
        
        
        
        manager.post("https://ma.greenpedia.in/thirdparty/paytm/generateChecksum.php", parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            if let response = response as? [AnyHashable: Any] {
                print(response)
                blockResult((response as NSDictionary) as! [String : Any])
            }
            
        }) { (requestOperation, error) in
            print(error)
            //  Error(error as NSError)
            blockerror(error as NSError)
        }
        
    }
    func getChecksum(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post("https://ma.greenpedia.in/thirdparty/paytm/generateChecksum.php", parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
        //    print(BASE_URL + WsCheckSum)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getRefundDetailsAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRefundDetails, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRefundDetails)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func refundRequestAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRefund, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRefund)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func UpdateTearms(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsTermsUpdate, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsTermsUpdate)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    func cancelRefundRequestAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRefund, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRefund)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func loadTransactionListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsUserAccountTxnDetails, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsUserAccountTxnDetails)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func addSubscriptionAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsAddSubscription, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsAddSubscription)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func BTCycleValidateAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsBTCycleValidate, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsBTCycleValidate)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func BTCycleValidateGPRSAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCycleOut, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCycleOut)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func BlueToothCycleOutAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsBTCycleOut, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsBTCycleOut)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func GPRSCycleOutAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCycleOut, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCycleOut)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getMyRideListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsRides, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsRides)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getCurrentRideAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsOngoingRide, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsOngoingRide)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func unlockCycleBLE(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsBTLockCommands, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsBTLockCommands)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func endRideCycleBLE(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        
        print(dic)
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsBTEndRide, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsBTEndRide)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getCycleIssueTypeAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCycleIssueTypes, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCycleIssueTypes)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getCycleStatusAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCycleStatus, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCycleStatus)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getSubscriptionPlanAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsSubscriptionPlans_v2, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsSubscriptionPlans_v2)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func addSubscriptionPlanAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsAddSubscription, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsAddSubscription)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getMySubscriptionListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsUserSubscriptionsList, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsUserSubscriptionsList)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
   
    
    func getEventListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError)
    {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsEvents, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsEvents)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getMenuListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsAppMenu, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsAppMenu)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getVideoRequestID(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsBTEndRideRequest, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsBTEndRideRequest)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func cancelVideoRequestAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsCancelEndRideRequest, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsCancelEndRideRequest)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    func getCityStateListAPICall(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsNewHubRequest, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsNewHubRequest)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }
        
    }
    
    
    
    
    
    
    // ************ UPLOAD VIDEO ************ //
    func uploadEndRideIssueVideo(video: NSData, dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
        
        manager.post(BASE_URL + WsEndRideVideoSubmit, parameters: dic, headers: headers) { (formData) in
            print(BASE_URL + WsEndRideVideoSubmit)
            
            if video.isKind(of: NSData.self) {
                if video.length > 0 {
                    let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).MOV"
                    formData.appendPart(withFileData: video as Data, name: "video", fileName: timestamp, mimeType: "video/mp4")
                }
            }
            
        } progress: { (progress) in
            
//            DispatchQueue.main.async(execute: {
//                blockuploadPercentage(progress.fractionCompleted as Double)
//            })
            
        } success: { (requestOperation, response) in
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        } failure: { (requestOperation, error) in
            
            print(error)
            blockError(error)
        }

        
        
    }
    func submitDocData(media: [Data], dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        /*
         func postimage() -> Void
         {
             let urlPath1 = "Path url here"

                 let manager = AFHTTPRequestOperationManager()
                 var Timestamp: String {
                     return "\(NSDate().timeIntervalSince1970 * 1000)"
                 }
                 let operation =  manager.post(urlPath1 as String, parameters: dictData, constructingBodyWith: { (data:AFMultipartFormData!) -> Void in

                     if image != nil {

                         data.appendPart(withFileData: UIImagePNGRepresentation(image!)!, name: imageName as String, fileName: "\(Timestamp).png", mimeType: "image/png")


                     }
                 }, success: { (operation, responseObject) -> Void in

                     success(responseObject as AnyObject)
                 }) { (operation, error) -> Void in

                     print(error, terminator: "")
                 }

                 operation?.start()
             }
         }
         */
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
     //   mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
        
        
        
        print(dic)
        manager.post(BASE_URL + WsDocType, parameters: dic, headers: headers) { (formData) in
            print(BASE_URL + WsDocType)
            
            for data in media
            {
                print(data.count)
                let timestamp: String = "\(Date().timeIntervalSince1970 * 1000)"
                //"morephoto[\(i)]"
               
               // print(<#T##items: Any...##Any#>)
                formData.appendPart(withFileData: data, name: "documentFiles[]", fileName: "\(timestamp).jpeg", mimeType: "image/jpeg")
                
               /* formData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
                formData.append("Content-Disposition: form-data; name=\"\(imageName)\"; filename=\"\(Date().timeIntervalSince1970).jpeg\"\r\n".data(using: String.Encoding.utf8)!)
                formData.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
                formData.append(data)*/
                }
            //report_issue_file
          /*  if media.isKind(of: NSData.self) {
                if media.length > 0 {
                    
                    if "\(dic["cycle_issue_media_type"] as! String)" == "IMAGE"
                    {
                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000)"
                        formData.appendPart(withFileData:  media as Data, name: "report_issue_file", fileName: "\(timestamp).png", mimeType: "image/png")
                    }
                    else if "\(dic["cycle_issue_media_type"] as! String)" == "VIDEO" {
                        
                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).MOV"
                        formData.appendPart(withFileData: media as Data, name: "report_issue_file", fileName: timestamp, mimeType: "video/mp4")
                    }
                    
                }
            }*/
            
        } progress: { (progress) in
            
//            DispatchQueue.main.async(execute: {
//                blockuploadPercentage(progress.fractionCompleted as Double)
//            })
            
        } success: { (requestOperation, response) in
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        } failure: { (requestOperation, error) in
            
            print(error)
            blockError(error)
        }

        
        
    }
    func submitReportIssueAPIWebServiceCall(media: NSData, dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        /*
         func postimage() -> Void
         {
             let urlPath1 = "Path url here"

                 let manager = AFHTTPRequestOperationManager()
                 var Timestamp: String {
                     return "\(NSDate().timeIntervalSince1970 * 1000)"
                 }
                 let operation =  manager.post(urlPath1 as String, parameters: dictData, constructingBodyWith: { (data:AFMultipartFormData!) -> Void in

                     if image != nil {

                         data.appendPart(withFileData: UIImagePNGRepresentation(image!)!, name: imageName as String, fileName: "\(Timestamp).png", mimeType: "image/png")


                     }
                 }, success: { (operation, responseObject) -> Void in

                     success(responseObject as AnyObject)
                 }) { (operation, error) -> Void in

                     print(error, terminator: "")
                 }

                 operation?.start()
             }
         }
         */
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
        
        manager.post(BASE_URL + WsReportCycleIssue, parameters: dic, headers: headers) { (formData) in
            print(BASE_URL + WsReportCycleIssue)
            
            //report_issue_file
            if media.isKind(of: NSData.self) {
                if media.length > 0 {
                    
                    if "\(dic["cycle_issue_media_type"] as! String)" == "IMAGE"
                    {
                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000)"
                        formData.appendPart(withFileData:  media as Data, name: "report_issue_file", fileName: "\(timestamp).png", mimeType: "image/png")
                    }
                    else if "\(dic["cycle_issue_media_type"] as! String)" == "VIDEO" {
                        
                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).MOV"
                        formData.appendPart(withFileData: media as Data, name: "report_issue_file", fileName: timestamp, mimeType: "video/mp4")
                    }
                    
                }
            }
            
        } progress: { (progress) in
            
//            DispatchQueue.main.async(execute: {
//                blockuploadPercentage(progress.fractionCompleted as Double)
//            })
            
        } success: { (requestOperation, response) in
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        } failure: { (requestOperation, error) in
            
            print(error)
            blockError(error)
        }

        
        
    }
    func getProfileData(dicBannerBodyParama  dic : [String : Any],resultHandler blockResult : @escaping BlockResultDictionary, blockerror blockError : @escaping BlockResultError)
    {
        //WsMobileBannerImage
        
      //  let headers = ["bearer":strBearer]
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsMyProfileGraphData, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsMyProfileGraphData)
            
            if let response = response as? [String:Any]
            {
          //      print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
      //      print(error)
            blockError(error)
            
        }
    }
    func getMyProfileEditData(dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
   
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.post(BASE_URL + WsMyProfileGraphData, parameters: dic, headers: headers, progress: nil, success: { (requestOperation, response) in
            print(BASE_URL + WsMyProfileGraphData)
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        }) { (requestOperation, error) in
            print(error)
            blockError(error)
            
        }

    }
    func getMyProfileGraph(media: NSData,dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
   
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
      
     
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
   
        print(dic)
      
        manager.post(BASE_URL + WsMyProfileGraphData, parameters: dic, headers: headers) { (formData) in
            print(BASE_URL + WsMyProfileGraphData)
            
      
            formData.appendPart(
                withFileData: media as Data,
                     name: "photograph",
                     fileName: "imageName.png",
                     mimeType: "image/jpeg")

             
        } progress: { (progress) in
  
        } success: { (requestOperation, response) in
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        } failure: { (requestOperation, error) in
            
            print(error)
            blockError(error)
        }

      
    }
    func submitRequestHubFormAPIWebServiceCall(media: [Data], dictionary dic: [String: Any], resultHandler blockResult: @escaping BlockResultDictionary, blockError: @escaping BlockResultError) {
        
        let headers = ["bearer":strBearer, "authkey":"\(UserDefaults.standard.value(forKey: "authkey") as! String)"]
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
        
        print(dic)
        manager.post(BASE_URL + WsNewHubRequest, parameters: dic, headers: headers) { (formData) in
            print(BASE_URL + WsNewHubRequest)
            
               
            for data in media
            {
                print(data.count)
                let timestamp: String = "\(Date().timeIntervalSince1970 * 1000)"
                //"morephoto[\(i)]"
               
               // print(<#T##items: Any...##Any#>)
                formData.appendPart(withFileData: data, name: "hubImages[]", fileName: "\(timestamp).jpeg", mimeType: "image/jpeg")
                
               /* formData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
                formData.append("Content-Disposition: form-data; name=\"\(imageName)\"; filename=\"\(Date().timeIntervalSince1970).jpeg\"\r\n".data(using: String.Encoding.utf8)!)
                formData.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
                formData.append(data)*/
                }
           /* for data in media {
                if data.isKind(of: NSData.self)
                {
                    if data.length > 0
                    {
                        
                       /*  formData.appendPart(
                             withFileData: data as Data,
                                  name: "hubImages",
                                  fileName: "imageName.png",
                                  mimeType: "image/jpeg")*/
                        
                       /* let timestamp: String = "\(Date().timeIntervalSince1970 * 1000)"
                        formData.appendPart(withFileData:  data as Data, name: "hubImages", fileName: "\(timestamp).png", mimeType: "image/png")*/
                         
                        
                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).png"
                        formData.appendPart(withFileData: data as Data, name: "hubImages", fileName: timestamp, mimeType: "image/jpeg")
                    }
                }
            }*/
            
//            if media.isKind(of: NSData.self) {
//                if media.length > 0 {
//
//                    if "\(dic["cycle_issue_media_type"] as! String)" == "IMAGE" {
//
//                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).JPG"
//                        formData.appendPart(withFileData: media as Data, name: "report_issue_file", fileName: timestamp, mimeType: "image")
//                    }
//                    else if "\(dic["cycle_issue_media_type"] as! String)" == "VIDEO" {
//
//                        let timestamp: String = "\(Date().timeIntervalSince1970 * 1000).MOV"
//                        formData.appendPart(withFileData: media as Data, name: "report_issue_file", fileName: timestamp, mimeType: "video/mp4")
//                    }
//
//                }
//            }
            
        } progress: { (progress) in
            
//            DispatchQueue.main.async(execute: {
//                blockuploadPercentage(progress.fractionCompleted as Double)
//            })
            
        } success: { (requestOperation, response) in
            
            if let response = response as? [String:Any] {
                print(response)
                
                blockResult(response)
            }
            
        } failure: { (requestOperation, error) in
            
            print(error)
            blockError(error)
        }

        
        
    }
    
    
    
    
    
}








