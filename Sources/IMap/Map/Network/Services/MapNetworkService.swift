//
//  MapNetworkService.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation
import NetworkLayer

public struct MapNetworkService: @unchecked Sendable {
    public static let shared = MapNetworkService()
    
    //MARK: - get address
    public func getAddress(from lat: Double, lng: Double) async throws -> CoordinateAddress? {
        let info: NetResGetAddress? = (try await Network.sendThrow(request: MainNetworkRoute.getAddress(lat: lat, lng: lng)))?.result
        
        return .init(with: info)
    }
}
