//
//  DNetRegionItem.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

struct DNetRegionListItem: Codable {
    let id: Int
    let name: DNetLocalizedName?
    let services: [DNetServiceItem]?
}

struct DNetLocalizedName: Codable {
    let uz: String?
    let ru: String?
}

struct DNetServiceItem: Codable {
    let id: Int
    let name: DNetLocalizedName?
}

