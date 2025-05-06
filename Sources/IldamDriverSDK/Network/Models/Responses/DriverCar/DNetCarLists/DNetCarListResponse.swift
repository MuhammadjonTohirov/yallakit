//
//  DNetDriverCarResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

struct DNetCarListResponse: Codable {
    let id: Int
    let stateNumber: String
    let callsign: String
    let licensy: String?
    let yearIssue: String
    let fotocontrol: Bool
    let active: Bool
    let color: String
    let mark: String
    let model: String

    enum CodingKeys: String, CodingKey {
        case id
        case stateNumber = "state_number"
        case callsign
        case licensy
        case yearIssue = "year_issue"
        case fotocontrol
        case active
        case color
        case mark
        case model
    }
}

struct DNetCarInfo: Codable {
    let id: Int
    let name: String
}

struct DNetCarColor: Codable {
    let id: Int
    let color: String
    let name: String
}
