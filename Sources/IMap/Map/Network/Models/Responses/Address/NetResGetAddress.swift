//
//  NetResGetAddress.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import NetworkLayer

struct NetResGetAddress: NetResBody {
    var lat: String
    var lng: String
    var name: String
}
