//
//  LoginWithPassModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 20/09/21.
//

import Foundation

struct LoginWithPass: Decodable {
    
    let isError, errorCode, message: String
    let data: LoginWithPassData
    
    enum CodingKeys: String, CodingKey {
        case isError = "is_error"
        case errorCode = "error_code"
        case message, data
    }
    
}

// MARK:- Data
struct LoginWithPassData: Codable {
    let loggedIn, currentRide: String
    let idUsers: Int
    let changePassword, name, email, photograph: String
    let token, authkey: String
    
    enum CodingKeys: String, CodingKey {
        case loggedIn, currentRide, idUsers
        case changePassword = "change_password"
        case name, email, photograph, token, authkey
    }
    
}
