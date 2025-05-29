//
//  DefaultTariffModel.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import SwiftUI

public struct DriverDefaultTariffResponse: DNetResBody {
    public let brand: DefaultTariffBrand
    public let id: Int
    public let minCityCost: Int
    public let minOutCityCost: Int
    public let name: String
    
    public init(brand: DefaultTariffBrand, id: Int, minCityCost: Int, minOutCityCost: Int, name: String) {
        self.brand = brand
        self.id = id
        self.minCityCost = minCityCost
        self.minOutCityCost = minOutCityCost
        self.name = name
    }
    
    init(from network: DNetDefaultTariffResult)  {
        self.brand = DefaultTariffBrand(from: network.brand)
        self.id = network.id
        self.minCityCost = network.minCityCost
        self.minOutCityCost = network.minOutCityCost
        self.name = network.name
        
        
    }
    
    public struct DefaultTariffBrand: Codable {
        public let id: Int
        public let name: String
        
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
        init(from network: DNetDefaultTariffBrand)  {
            self.id = network.id
            self.name = network.name
        }
    }

 
}
