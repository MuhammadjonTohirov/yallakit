//
//  DefaultTariffModel.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import SwiftUI

public struct DriverDefaultTariffResponse: DNetResBody {
    public let brandId: Int
    public let brandName: String
    public let tariffId: Int
    public let minCityCost: Int
    public let minOutCityCost: Int
    public let name: String
    
    init(
        brandId: Int,
        brandName: String,
        tariffId: Int,
        minCityCost: Int,
        minOutCityCost: Int,
        name: String
    ) {
        self.brandId = brandId
        self.brandName = brandName
        self.tariffId = tariffId
        self.minCityCost = minCityCost
        self.minOutCityCost = minOutCityCost
        self.name = name
    }
    
    public init(from network: DefaultTariffResult) {
        self.brandId = network.brand.id
        self.brandName = network.brand.name
        self.tariffId = network.id
        self.minCityCost = network.minCityCost
        self.minOutCityCost = network.minOutCityCost
        self.name = network.name
    }
}
