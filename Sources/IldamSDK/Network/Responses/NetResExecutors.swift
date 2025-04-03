//
//  NetResExecutors.swift
//  Ildam
//
//  Created by applebro on 19/01/24.
//

import Foundation

struct NetResExecutors: NetResBody {
    let timeout: Int
    let executors: [NetResExecutor]?
}

struct NetResExecutor: Codable {
    let id: Int
    let heading: Float
    let lat, lng: Float
    let distance: Float
}
