//
//  DNetRegionItem.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

struct DNetRegionItem: DNetResBody {
    let id: Int
    let name: DNetRegionName?
    let services: [Int]? // or another type if services have details

    struct DNetRegionName: Codable {
        let uz: String?
        let ru: String?
    }
}
