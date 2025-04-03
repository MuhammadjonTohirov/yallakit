//
//  NetResOrderSettings.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 19/12/24.
//

import Foundation

struct NetResOrderSettings: NetResBody {
    let orderCancelTime: Int
    
    enum CodingKeys: String, CodingKey {
        case orderCancelTime = "order_cancel_time"
    }
}
