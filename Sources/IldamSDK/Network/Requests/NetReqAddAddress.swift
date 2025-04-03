//
//  NetReqAddAddress.swift
//  Ildam
//
//  Created by applebro on 24/12/23.
//

import Foundation
import Core

struct NetReqAddAddress: Codable {
    let name: String
    let address: String
    let lat: Double
    let lng: Double
    let type: MyAddressType
    let enter: String?
    let apartment: String?
    let floor: String?
    let comment: String?
}
