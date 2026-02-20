//
//  NetResDistrictItem.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation
import NetworkLayer

struct NetResDistrictItem: NetResBody {
    let id: Int
    let name: String?
    let level: String?
    let parent: Parent?
    
    struct Parent: Codable {
        let id: Int
        let name: String
    }
}
