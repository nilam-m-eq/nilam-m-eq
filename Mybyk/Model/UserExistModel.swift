//
//  UserExistModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 20/09/21.
//

import Foundation

struct UserExist: Decodable {
    
    let isError: String
    let data: UserExistData
    let message, errorCode: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case isError = "is_error"
        case errorCode = "error_code"
        case message
    }
    
}

// MARK:- Data
struct UserExistData: Codable {
    let redirect, androidForceUpdate, androidUpdateMessage, iosForceUpdate: String
    let iosUpdateMessage, params, headers: String
    let isregistered: String
    
    enum CodingKeys: String, CodingKey {
        case redirect
        case androidForceUpdate = "ANDROID_FORCE_UPDATE"
        case androidUpdateMessage = "ANDROID_UPDATE_MESSAGE"
        case iosForceUpdate = "IOS_FORCE_UPDATE"
        case iosUpdateMessage = "IOS_UPDATE_MESSAGE"
        case params, headers, isregistered
    }
    
}



