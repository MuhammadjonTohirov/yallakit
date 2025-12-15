//
//  TaxiExecutors.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation

public struct TaxiExecutor: Sendable {
    public let id: Int
    public let heading: Float
    public let lat, lng: Float
    public let distance: Float
    
    public init(id: Int, heading: Float, lat: Float, lng: Float, distance: Float) {
        self.id = id
        self.heading = heading
        self.lat = lat
        self.lng = lng
        self.distance = distance
    }
}

public struct TaxiExecutors: Sendable {
    public let timeout: Int
    public let executors: [TaxiExecutor]
    
    public init(timeout: Int, executors: [TaxiExecutor]) {
        self.timeout = timeout
        self.executors = executors
    }
}
