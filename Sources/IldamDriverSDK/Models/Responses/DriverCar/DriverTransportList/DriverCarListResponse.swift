//
//  DriverCar.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

public struct DriverCarListResponse {
    public let id: Int
    public let stateNumber: String
    public let callsign: String
    public let licensy: String?
    public let yearIssue: String
    public let fotocontrol: Bool
    public let active: Bool
    public let color: CarColor
    public let mark: CarInfo
    public let model: CarInfo

    public init(
        id: Int,
        stateNumber: String,
        callsign: String,
        licensy: String?,
        yearIssue: String,
        fotocontrol: Bool,
        active: Bool,
        color: CarColor,
        mark: CarInfo,
        model: CarInfo
    ) {
        self.id = id
        self.stateNumber = stateNumber
        self.callsign = callsign
        self.licensy = licensy
        self.yearIssue = yearIssue
        self.fotocontrol = fotocontrol
        self.active = active
        self.color = color
        self.mark = mark
        self.model = model
    }

    init(from network: DNetCarListResponse) throws {
        self.id = network.id
        self.stateNumber = network.stateNumber
        self.callsign = network.callsign
        self.licensy = network.licensy
        self.yearIssue = network.yearIssue
        self.fotocontrol = network.fotocontrol
        self.active = network.active

        let decoder = JSONDecoder()

        guard let colorData = network.color.data(using: .utf8),
              let decodedColor = try? decoder.decode(CarColor.self, from: colorData) else {
            throw NSError(domain: "Failed to decode CarColor", code: -1)
        }
        self.color = decodedColor

        guard let markData = network.mark.data(using: .utf8),
              let decodedMark = try? decoder.decode(CarInfo.self, from: markData) else {
            throw NSError(domain: "Failed to decode CarInfo (mark)", code: -1)
        }
        self.mark = decodedMark

        guard let modelData = network.model.data(using: .utf8),
              let decodedModel = try? decoder.decode(CarInfo.self, from: modelData) else {
            throw NSError(domain: "Failed to decode CarInfo (model)", code: -1)
        }
        self.model = decodedModel
    }

}


public struct CarInfo: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(from network: DNetCarInfo) {
        self.id = network.id
        self.name = network.name
    }
}

public struct CarColor: Codable {
    public let id: Int
    public let color: String
    public let name: String
    
    public init(id: Int, color: String, name: String) {
        self.id = id
        self.color = color
        self.name = name
    }

    init(from network: DNetCarColor) {
        self.id = network.id
        self.color = network.color
        self.name = network.name
    }
}
