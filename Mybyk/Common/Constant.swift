//
//  Constant.swift
//  Mybyk
//
//  Created by Parth Kapadia on 05/07/21.
//

import Foundation


// MARK: - App Theme Colors
let Color_Primary = "Color_Primary"
let Color_Active = "Color_Active"
let Color_Error = "Color_Error"
let Color_Warning = "Color_Warning"
let Color_N_Dark200 = "Color_N_Dark200"
let Color_N_Dark500 = "Color_N_Dark500"
let Color_N_Dark900 = "Color_N_Dark900"
let Color_N_Light00 = "Color_N_Light00"
let Color_N_Light100 = "Color_N_Light100"
let Color_N_Light500 = "Color_N_Light500"

// MARK: - Temporory store variable
var strTempAuthKey = String()

// MARK:- All Global Messages
let strLocationPrivacy = "Please enable location service for this app in ALLOW LOCATION ACCESS: Always, Go to Setting"
let strLocationEnable = "Please turn on location service for  cycle out from your device settings."


// MARK: - All Third Parth API Keys
let mapDirectionAPIKey = "AIzaSyC3RwBupXyFdul5XtIAWjDsF9f8ogyLam4"

// MARK: - All Other URL's
let urlTermsAndCondition = "https://mybyk.in/MYBYK_Terms_Conditions.pdf"
let urlMapDirection = "https://maps.googleapis.com/maps/api/"



// MARK: - App All Common Variables
let strBearer = "PB7B99HBUNR9WQHPZTW02Z9JD92"
var strBLEKey = String()


//MARK: - LiveURL And API EndPoints
//
//let BASE_URL = "https://mybyk.greenpedia.in/webservices21/v1/"
//let strVersion = "&ios=true&version=\(AppDelegate().versionNumber)"


 //MARK: - BaseURL And API EndPoints

let BASE_URL = "https://staging.mybyk.greenpedia.in/webservices21/v1/"
let strVersion = "&ios=true&version=\(AppDelegate().versionNumber)&debug=true"


// MARK: - End Points of API
// Sign up, Sign In & Forgot Password
let WsCountryCodeList = "WsCountryCodeList.php?\(strVersion)"
let WsIsUser = "WsIsUser.php?\(strVersion)"
let WsLogin = "WsLogin.php?\(strVersion)"
let WsRequestOTP = "WsRequestOTP.php?\(strVersion)"
let WsResetPassword = "WsResetPassword.php?\(strVersion)"
let WsVerifyOTP = "WsVerifyOTP.php?\(strVersion)"
let WsRegister = "WsRegister.php?\(strVersion)"
let WsIndex = "WsIndex.php?\(strVersion)"
let WsCycleList = "WsCycleList.php?\(strVersion)"
let WsMobileBannerImage = "WsLoginAndSignupBanners.php?\(strVersion)"

// Notification
let WsAllPushNotifications = "WsAllPushNotifications.php?\(strVersion)"

// Wallet
let WsAddBalance = "WsAddBalance.php?\(strVersion)"
let WsRefundDetails = "WsRefundDetails.php?\(strVersion)"
let WsRefund = "WsRefund.php?\(strVersion)"
let WsUserAccountTxnDetails = "WsUserAccountTxnDetails.php?\(strVersion)"
let WsCheckSum = "generateChecksum.php?\(strVersion)"

// Cycle In/Out
let WsAddSubscription = "WsAddSubscription.php?\(strVersion)"
let WsBTCycleValidate = "WsBTCycleValidate.php?\(strVersion)"
let WsBTCycleOut = "WsBTCycleOut.php?\(strVersion)"
let WsCycleOut = "WsCycleOut.php?\(strVersion)"

// Help and FAQ

let WsFAQList = "WsFAQsCategories.php?\(strVersion)"
let WsFAQDeteail = "WsFAQs.php?\(strVersion)"
let WsUserGuide = "WsUserGuide.php?\(strVersion)"


// My Ride
//let WsRides = "WsRides.php?\(strVersion)"
let WsRides = "WsRides_v1.php?\(strVersion)"
let WsOngoingRide = "WsOngoingRide.php?\(strVersion)"
let WsRideDetails = "WsRideDetails.php?\(strVersion)"

let WsBTLockCommands = "WsBTLockCommands.php?\(strVersion)"
let WsBTEndRide = "WsBTEndRide.php?\(strVersion)"

let WsCycleIssueTypes = "WsCycleIssueTypes.php?\(strVersion)"
let WsCycleStatus = "WsCycleStatus.php?\(strVersion)"

let WsSubscriptionPlans_v1 = "WsSubscriptionPlans_v1.php?\(strVersion)"
let WsSubscriptionPlans_v2 = "WsSubscriptionPlans.php?\(strVersion)"
//let WsSubscriptionPlans_v2 = "WsSubscriptionPlans_v2.php?\(strVersion)"



// My Subscriptions List
let WsUserSubscriptionsList = "WsUserSubscriptionsList.php?\(strVersion)"

// Event List
let WsEvents = "WsEvents.php?\(strVersion)"
//

// MENU
let WsAppMenu = "WsAppMenu.php?\(strVersion)"
let WsNewHubRequest = "WsNewHubRequest.php?\(strVersion)"


let WsBTEndRideRequest = "WsBTEndRideRequest.php?\(strVersion)"
let WsCancelEndRideRequest = "WsCancelEndRideRequest.php?\(strVersion)"


// **** UPLOAD VIDEO **** //
let WsEndRideVideoSubmit = "WsEndRideVideoSubmit.php?\(strVersion)"
let WsReportCycleIssue = "WsReportCycleIssue.php?\(strVersion)"


//MARK: - Document Type
let WsDocType = "WsGetDocumentTypes.php?\(strVersion)"

//MARK: - ReferDetail
let WsReferDetail = "WsReferralDetails.php?\(strVersion)"

//MARK: - Get Myprofile Graph
let WsMyProfileGraphData = "WsEditUserProfile.php?\(strVersion)"

//MARK: - Get Event Detail

let WsEventDetail = "WsEventInfo.php?\(strVersion)"


//MARK: - Terms And Conditions Update
let WsTermsUpdate = "WsUpdateTermsAndConditions.php?\(strVersion)"


