//
//  NetResMeInfo.swift
//  Ildam
//
//  Created by applebro on 09/12/23.
//

import Foundation

struct NetResMeInfo: NetResBody {
    var expiresIn: Int
    var client: NetResClient
    
    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case client
    }
    
    var expirationDate: Date {
        var date = Date()
        date.addTimeInterval(TimeInterval(expiresIn))
        return date
    }
}
