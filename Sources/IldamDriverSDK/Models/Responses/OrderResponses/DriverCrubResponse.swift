//
//  DriverCrubResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

public struct DriverCrubResponse: DNetResBody {
    public let orderId: Int
    
    public init(orderId: Int) {
        self.orderId = orderId
    }
    
    init(from network: LocationResult) {
        self.orderId = network.orderId
    }
}

 
