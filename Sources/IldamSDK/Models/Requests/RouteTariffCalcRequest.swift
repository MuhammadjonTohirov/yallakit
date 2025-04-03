//
//  RouteAndTariffCalculationRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/RouteAndTariffCalculationRequest.swift
import Foundation
import Core

public struct RouteTariffCalcRequest {
    public var points: [Coord]?
    public var optionIds: [Int]?
    public var addressId: Int?
    public var tariffId: Int?
    
    public init(points: [Coord]?, optionIds: [Int]?, addressId: Int? = nil, tariffId: Int? = nil) {
        self.points = points
        self.optionIds = optionIds
        self.addressId = addressId
        self.tariffId = tariffId
    }
}
