//
//  NetResSendOTP.swift
//  Ildam
//
//  Created by applebro on 07/12/23.
//

import Foundation

struct NetResSendOTP: NetResBody {
    let time: Int
    let resultMessage: String? // result_message
    
    enum CodingKeys: String, CodingKey {
        case time
        case resultMessage = "result_message"
    }
}
