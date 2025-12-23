//
//  RoutingRequest.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 23/12/25.
//

import Foundation
import NetworkLayer

public struct RoutingRequest: Codable, Sendable {
    public let points: [RoutingPoint]
    
    public init(points: [RoutingPoint]) {
        self.points = points
    }
    
    enum CodingKeys: String, CodingKey {
        case points
    }
    
    public struct RoutingPoint: Codable, Sendable {
        public let type: PointType
        public let lng: Double
        public let lat: Double
        
        enum CodingKeys: String, CodingKey {
            case type
            case lng
            case lat
        }
    }

    public enum PointType: String, Codable, Sendable {
        case start
        case point
        case stop
    }
}
// MARK: - Convenience Initializers

extension RoutingRequest {
    init(from jsonArray: [[String: Any]]) throws {
        var points: [RoutingPoint] = []
        
        for dict in jsonArray {
            guard let typeString = dict["type"] as? String,
                  let type = PointType(rawValue: typeString),
                  let lng = dict["lng"] as? Double,
                  let lat = dict["lat"] as? Double else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(codingPath: [], debugDescription: "Invalid point data")
                )
            }
            
            points.append(RoutingPoint(type: type, lng: lng, lat: lat))
        }
        
        self.init(points: points)
    }
}

// MARK: - JSON Encoding/Decoding

extension RoutingRequest {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var points: [RoutingPoint] = []
        
        while !container.isAtEnd {
            let point = try container.decode(RoutingPoint.self)
            points.append(point)
        }
        
        self.points = points
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        
        for point in points {
            try container.encode(point)
        }
    }
}

extension RoutingRequest: URLRequestProtocol {
    public var url: URL {
        return URL.baseAPICli.appendingPath("routing")
    }
    
    public var body: Data? {
        self.points.asData
    }
    
    public var method: NetworkLayer.HTTPMethod {
        .post
    }
    
    public func request() -> URLRequest {
        var req = URLRequest(url: url)
        req.httpMethod = method.rawValue
        req.httpBody = body
        return req
    }
}
