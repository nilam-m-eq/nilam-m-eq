//
//  WalletBalanceModel.swift
//  Mybyk
//
//  Created by Gaurav Patel on 04/01/22.
//

import Foundation

struct WalletBalanceData: Codable {
    
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
    var balance: Int
    var referralPoints: Int
    var maintainBalanceMsg: String
    var referAndEarn: String
    var referFriend: String
    var transactionsTitle: String
    var transactionsMsg: String
    
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
        case balance = "balance"
        case referralPoints = "referralPoints"
        case maintainBalanceMsg = "maintain_balance_msg"
        case referAndEarn = "refer_and_earn"
        case referFriend = "refer_friend"
        case transactionsTitle = "transactions_title"
        case transactionsMsg = "transactions_msg"
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
        balance = try values.decode(Int.self, forKey: .balance)
        referralPoints = try values.decode(Int.self, forKey: .referralPoints)
        maintainBalanceMsg = try values.decode(String.self, forKey: .maintainBalanceMsg)
        referAndEarn = try values.decode(String.self, forKey: .referAndEarn)
        referFriend = try values.decode(String.self, forKey: .referFriend)
        transactionsTitle = try values.decode(String.self, forKey: .transactionsTitle)
        transactionsMsg = try values.decode(String.self, forKey: .transactionsMsg)
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
        try container.encode(balance, forKey: .balance)
        try container.encode(referralPoints, forKey: .referralPoints)
        try container.encode(maintainBalanceMsg, forKey: .maintainBalanceMsg)
        try container.encode(referAndEarn, forKey: .referAndEarn)
        try container.encode(referFriend, forKey: .referFriend)
        try container.encode(transactionsTitle, forKey: .transactionsTitle)
        try container.encode(transactionsMsg, forKey: .transactionsMsg)
    }

}




