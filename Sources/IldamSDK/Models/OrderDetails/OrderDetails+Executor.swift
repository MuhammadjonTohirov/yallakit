//
//  OrderDetails+Executor.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public struct TaxiOrderExecutor: Codable, Sendable {
    public var id: Int
    public var phone: String
    public var givenNames: String
    public var surName: String
    public var fatherName: String?
    public var photo: String
    public var coords: TaxiOrderExecutorCoords?
    public var rating: Int?
    public var driver: TaxiOrderExecutorDriver?
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.phone = res.phone
        self.givenNames = res.givenNames ?? ""
        self.surName = res.surName ?? ""
        self.fatherName = res.fatherName
        self.photo = res.photo ?? ""
        self.coords = TaxiOrderExecutorCoords(res: res)
        self.driver = TaxiOrderExecutorDriver(res: res)
        self.rating = res.rating
    }
    
    public init(id: Int, phone: String, givenNames: String, surName: String, fatherName: String?, rating: Int? = 2, photo: String, coords: TaxiOrderExecutorCoords?, driver: TaxiOrderExecutorDriver?) {
        self.id = id
        self.phone = phone
        self.givenNames = givenNames
        self.surName = surName
        self.fatherName = fatherName
        self.photo = photo
        self.coords = coords
        self.driver = driver
        self.rating = rating
    }
}

public struct TaxiOrderExecutorCoords: Codable, Sendable {
    public let lat: Double
    public let lng: Double
    public let heading: Double?
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.lat = res.coords?.lat ?? 0
        self.lng = res.coords?.lng ?? 0
        self.heading = res.coords?.heading
    }
    
    public init(lat: Double, lng: Double, heading: Double = 0) {
        self.lat = lat
        self.lng = lng
        self.heading = heading
    }
}

public struct TaxiOrderExecutorDriver: Codable, Sendable {
    public let id: Int
    public let color: TaxiOrderExecutorDriver.Color?
    public let stateNumber: String?
    public let mark: String?
    public let model: String?
    
    public init(id: Int, color: Color? = nil, stateNumber: String? = nil, mark: String? = nil, model: String? = nil) {
        self.id = id
        self.color = color
        self.stateNumber = stateNumber
        self.mark = mark
        self.model = model
    }
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.color = .init(res: res.driver?.color)
        self.stateNumber = res.driver?.stateNumber
        self.mark = res.driver?.mark
        self.model = res.driver?.model
    }
    
    public struct Color: Codable, Sendable {
        public let color: String?
        public let colorName: String?
        
        public init(color: String?, colorName: String?) {
            self.color = color
            self.colorName = colorName
        }
        
        init?(res: NetResTaxiOrderExecutorDriver.Color?) {
            guard let res = res else { return nil }
            self.color = res.color
            self.colorName = res.colorName
        }
    }
}

public extension TaxiOrderExecutor {
    var fullName: String {
        return [givenNames.nilIfEmpty, surName.nilIfEmpty, fatherName?.nilIfEmpty].compactMap({ $0 }).joined(separator: " ")
    }
}
