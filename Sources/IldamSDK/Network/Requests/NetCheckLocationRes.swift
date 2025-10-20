//
//  NetCheckLocationRes.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 20/10/25.
//

import SwiftUI
import NetworkLayer

struct NetCheckLocationRes: NetResBody {
    let addressID, brandID: Int?
    let isWorking: Bool?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case addressID = "address_id"
        case brandID = "brand_id"
        case isWorking = "is_working"
        case text
    }
}
