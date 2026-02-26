//
//  PolygoneNetworkService.swift
//  IMap
//
//  Created by applebro on 11/09/24.
//

import Foundation
import NetworkLayer

public protocol PolygonNetworkServiceProtocol: Sendable {
    var polygonList: [PolygonItem] { get }
    
    @discardableResult
    func getPolygonList() async throws -> [PolygonItem]
    
    func polygon(at lat: Double, lng: Double) -> PolygonItem?
    
    func isInPolygon(lat: Double, lng: Double) -> Bool
}

public final class PolygonService: @unchecked Sendable, PolygonNetworkServiceProtocol {
    public var polygonList: [PolygonItem] = []

    typealias Coor = (lat: Double, lng: Double)

    private let client: NetworkClientProtocol

    public static let shared: PolygonNetworkServiceProtocol = PolygonService()

    public init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    @discardableResult
    public func getPolygonList() async throws -> [PolygonItem] {
        guard polygonList.isEmpty else {
            return polygonList
        }

        let response: NetRes<[NetResPolygonItem]>? = try await client.sendThrow(
            request: PolygonNetworkRoute()
        )
        
        var result: [PolygonItem] = []
        
        response?.result?.forEach { item in
            result.append(.init(
                addressID: item.addressID,
                polygon: item.polygon.map({($0.lat, $0.lng)}),
                config: .init(res: item.config)
            ))
        }
        
        self.polygonList = result
        
        return result
    }
    
    public func polygon(at lat: Double, lng: Double) -> PolygonItem? {
        return polygonList.first(where: { isPointInPolygon(point: (lat, lng), polygon: $0.polygon) })
    }
    
    func isPointInPolygon(point: Coor, polygon: [Coor]) -> Bool {
        let (lat, lng) = point
        var isInside = false
        
        var j = polygon.count - 1
        for i in 0..<polygon.count {
            let xi = polygon[i].lat, yi = polygon[i].lng
            let xj = polygon[j].lat, yj = polygon[j].lng
            
            let intersect = ((yi > lng) != (yj > lng)) &&
                (lat < (xj - xi) * (lng - yi) / (yj - yi) + xi)
            
            if intersect {
                isInside = !isInside
            }
            
            j = i
        }
        
        return isInside
    }
}

public extension PolygonService {
    func isInPolygon(lat: Double, lng: Double) -> Bool {
        self.polygon(at: lat, lng: lng) != nil
    }
}
