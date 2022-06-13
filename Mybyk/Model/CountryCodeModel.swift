//
//  CountryCodeModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 04/08/21.
//

import Foundation

struct CountryCode: Decodable
{

    let data: CountryCodeData
    let isError, errorCode, message: String
    
    enum CodingKeys: String, CodingKey
    {
        case data
        case isError = "is_error"
        case errorCode = "error_code"
        case message
    }
    
}

// MARK:- Data
struct CountryCodeData: Codable
{
    let redirect, androidForceUpdate, androidUpdateMessage, iosForceUpdate: String
    let iosUpdateMessage, params, headers: String
    let countrycodelist: [String]
    
    enum CodingKeys: String, CodingKey
    {
        case redirect
        case androidForceUpdate = "ANDROID_FORCE_UPDATE"
        case androidUpdateMessage = "ANDROID_UPDATE_MESSAGE"
        case iosForceUpdate = "IOS_FORCE_UPDATE"
        case iosUpdateMessage = "IOS_UPDATE_MESSAGE"
        case params, headers, countrycodelist
    }

}


