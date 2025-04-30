//
//  NetResSendOTP.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//


import Foundation

struct DNetResSendOTP: DNetResBody {
    let time: Int
    let resultMessage: String? // result_message
    
    enum CodingKeys: String, CodingKey {
        case time
        case resultMessage = "result_message"
    }
}
