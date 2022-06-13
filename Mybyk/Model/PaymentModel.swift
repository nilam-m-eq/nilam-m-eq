//
//  PaymentModel.swift
//  Mybyk
//
//  Created by Gaurav Patel on 05/01/22.
//

import Foundation

struct PaymentData: Codable {

    var redirect: String
    var ANDROIDFORCEUPDATE: String
    var ANDROIDUPDATEMESSAGE: String
    var IOSFORCEUPDATE: String
    var IOSUPDATEMESSAGE: String
    var currencySymbol: String
    var params: String
    var headers: String
    var idUsers: Int
    var authkey: String
    var keymessage: String
    var isPaytmShow: String
    var isPayuShow: String
    var userAmount: Int
    var userBalance: Int
    var totalAmount: Int
    var payudetails: Payudetails
    var paytmdetails: Paytmdetails
    var idOnlinePaymentTxnDetails: Int

    private enum CodingKeys: String, CodingKey {
        case redirect = "redirect"
        case ANDROIDFORCEUPDATE = "ANDROID_FORCE_UPDATE"
        case ANDROIDUPDATEMESSAGE = "ANDROID_UPDATE_MESSAGE"
        case IOSFORCEUPDATE = "IOS_FORCE_UPDATE"
        case IOSUPDATEMESSAGE = "IOS_UPDATE_MESSAGE"
        case currencySymbol = "currency_symbol"
        case params = "params"
        case headers = "headers"
        case idUsers = "idUsers"
        case authkey = "authkey"
        case keymessage = "keymessage"
        case isPaytmShow = "is_paytm_show"
        case isPayuShow = "is_payu_show"
        case userAmount = "user_amount"
        case userBalance = "user_balance"
        case totalAmount = "total_amount"
        case payudetails = "payudetails"
        case paytmdetails = "paytmdetails"
        case idOnlinePaymentTxnDetails = "idOnlinePaymentTxnDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        redirect = try values.decode(String.self, forKey: .redirect)
        ANDROIDFORCEUPDATE = try values.decode(String.self, forKey: .ANDROIDFORCEUPDATE)
        ANDROIDUPDATEMESSAGE = try values.decode(String.self, forKey: .ANDROIDUPDATEMESSAGE)
        IOSFORCEUPDATE = try values.decode(String.self, forKey: .IOSFORCEUPDATE)
        IOSUPDATEMESSAGE = try values.decode(String.self, forKey: .IOSUPDATEMESSAGE)
        currencySymbol = try values.decode(String.self, forKey: .currencySymbol)
        params = try values.decode(String.self, forKey: .params)
        headers = try values.decode(String.self, forKey: .headers)
        idUsers = try values.decode(Int.self, forKey: .idUsers)
        authkey = try values.decode(String.self, forKey: .authkey)
        keymessage = try values.decode(String.self, forKey: .keymessage)
        isPaytmShow = try values.decode(String.self, forKey: .isPaytmShow)
        isPayuShow = try values.decode(String.self, forKey: .isPayuShow)
        userAmount = try values.decode(Int.self, forKey: .userAmount)
        userBalance = try values.decode(Int.self, forKey: .userBalance)
        totalAmount = try values.decode(Int.self, forKey: .totalAmount)
        payudetails = try values.decode(Payudetails.self, forKey: .payudetails)
        paytmdetails = try values.decode(Paytmdetails.self, forKey: .paytmdetails)
        idOnlinePaymentTxnDetails = try values.decode(Int.self, forKey: .idOnlinePaymentTxnDetails)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(redirect, forKey: .redirect)
        try container.encode(ANDROIDFORCEUPDATE, forKey: .ANDROIDFORCEUPDATE)
        try container.encode(ANDROIDUPDATEMESSAGE, forKey: .ANDROIDUPDATEMESSAGE)
        try container.encode(IOSFORCEUPDATE, forKey: .IOSFORCEUPDATE)
        try container.encode(IOSUPDATEMESSAGE, forKey: .IOSUPDATEMESSAGE)
        try container.encode(currencySymbol, forKey: .currencySymbol)
        try container.encode(params, forKey: .params)
        try container.encode(headers, forKey: .headers)
        try container.encode(idUsers, forKey: .idUsers)
        try container.encode(authkey, forKey: .authkey)
        try container.encode(keymessage, forKey: .keymessage)
        try container.encode(isPaytmShow, forKey: .isPaytmShow)
        try container.encode(isPayuShow, forKey: .isPayuShow)
        try container.encode(userAmount, forKey: .userAmount)
        try container.encode(userBalance, forKey: .userBalance)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(payudetails, forKey: .payudetails)
        try container.encode(paytmdetails, forKey: .paytmdetails)
        try container.encode(idOnlinePaymentTxnDetails, forKey: .idOnlinePaymentTxnDetails)
    }

}


struct Payudetails: Codable {

    var email: String
    var mobile: String
    var username: String
    var merchantID: String
    var PAYUBASEURL: String
    var key: String
    var salt: String
    var productinfo: String
    var sandbox: Bool

    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case mobile = "mobile"
        case username = "username"
        case merchantID = "merchantID"
        case PAYUBASEURL = "PAYU_BASE_URL"
        case key = "key"
        case salt = "salt"
        case productinfo = "productinfo"
        case sandbox = "sandbox"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decode(String.self, forKey: .email)
        mobile = try values.decode(String.self, forKey: .mobile)
        username = try values.decode(String.self, forKey: .username)
        merchantID = try values.decode(String.self, forKey: .merchantID)
        PAYUBASEURL = try values.decode(String.self, forKey: .PAYUBASEURL)
        key = try values.decode(String.self, forKey: .key)
        salt = try values.decode(String.self, forKey: .salt)
        productinfo = try values.decode(String.self, forKey: .productinfo)
        sandbox = try values.decode(Bool.self, forKey: .sandbox)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(mobile, forKey: .mobile)
        try container.encode(username, forKey: .username)
        try container.encode(merchantID, forKey: .merchantID)
        try container.encode(PAYUBASEURL, forKey: .PAYUBASEURL)
        try container.encode(key, forKey: .key)
        try container.encode(salt, forKey: .salt)
        try container.encode(productinfo, forKey: .productinfo)
        try container.encode(sandbox, forKey: .sandbox)
    }

}


struct Paytmdetails: Codable {

    var email: String
    var mobile: String
    var username: String
    var merchantID: String
    var PAYTMBASEURL: String
    var key: String
    var website: String
    var productinfo: String
    var sandbox: Bool
    var CALLBACKURL: String

    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case mobile = "mobile"
        case username = "username"
        case merchantID = "merchantID"
        case PAYTMBASEURL = "PAYTM_BASE_URL"
        case key = "key"
        case website = "website"
        case productinfo = "productinfo"
        case sandbox = "sandbox"
        case CALLBACKURL = "CALLBACK_URL"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decode(String.self, forKey: .email)
        mobile = try values.decode(String.self, forKey: .mobile)
        username = try values.decode(String.self, forKey: .username)
        merchantID = try values.decode(String.self, forKey: .merchantID)
        PAYTMBASEURL = try values.decode(String.self, forKey: .PAYTMBASEURL)
        key = try values.decode(String.self, forKey: .key)
        website = try values.decode(String.self, forKey: .website)
        productinfo = try values.decode(String.self, forKey: .productinfo)
        sandbox = try values.decode(Bool.self, forKey: .sandbox)
        CALLBACKURL = try values.decode(String.self, forKey: .CALLBACKURL)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(mobile, forKey: .mobile)
        try container.encode(username, forKey: .username)
        try container.encode(merchantID, forKey: .merchantID)
        try container.encode(PAYTMBASEURL, forKey: .PAYTMBASEURL)
        try container.encode(key, forKey: .key)
        try container.encode(website, forKey: .website)
        try container.encode(productinfo, forKey: .productinfo)
        try container.encode(sandbox, forKey: .sandbox)
        try container.encode(CALLBACKURL, forKey: .CALLBACKURL)
    }

}
