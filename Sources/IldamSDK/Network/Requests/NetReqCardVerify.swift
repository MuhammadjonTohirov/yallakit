//
//  NetReqVerifyCard.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 23/11/24.
//

import Foundation

struct NetReqCardVerify: Codable {
    let key: String
    let confirmCode: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case confirmCode = "confirm_code"
    }
}
