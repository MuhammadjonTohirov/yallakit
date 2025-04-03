//
//  NetResRegisterProfile.swift
//  Ildam
//
//  Created by applebro on 09/12/23.
//

import Foundation

struct NetResRegisterProfile: NetResBody {
    var tokenType: String
    var accessToken: String
    var expiresIn: Int
   // var client: NetResClient
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
      //  case client
    }
    
    var expirationDate: Date {
        var date = Date()
        date.addTimeInterval(TimeInterval(expiresIn))
        return date
    }
}
