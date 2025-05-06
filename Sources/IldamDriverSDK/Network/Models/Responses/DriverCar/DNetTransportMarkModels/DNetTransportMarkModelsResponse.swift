//
//  DriverTransportListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

struct DNetTransportMarkModelsResponse: DNetResBody {
    let id: Int
    let name: String
    let models: [DNetCarNameResponse]

}

struct DNetCarNameResponse: Codable {
    let id: Int
    let name: String
}
