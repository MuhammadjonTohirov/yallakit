//
//  OrderShowResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import SwiftUI
import NetworkLayer

struct DNetResDriverOrderShowResponse: DNetResBody {
    public let addressId: Int
    public let brand: DNetResOrderBrand
    public let clientPhone: String
    public let coefficient: Double
    public let createdAt: Int
    public let detail: OrderDetail
    public let directionToClient: DirectionToClient
    public let dontCallMe: Bool
    public let energy: OrderEnergy
    public let executorBonus: ExecutorBonus
    public let executorCompensation: ExecutorCompensation?
    public let executorCoverBonus: ExecutorCoverBonus
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let reason: OrderCancelReason?
    public let roadDirection: OrderRoadDirection
    public let routes: [OrderRoute]
    public let sendingTime: Int
    public let service: String
    public let sourceType: String
    public let status: String
    public let statusTime: [OrderStatusTime]?
    public let toPhone: String
    public let useTheBonus: Bool
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case brand
        case clientPhone = "client_phone"
        case coefficient
        case createdAt = "created_at"
        case detail
        case directionToClient = "direction_to_client"
        case dontCallMe = "dont_call_me"
        case energy
        case executorBonus = "executor_bonus"
        case executorCompensation = "executor_compensation"
        case executorCoverBonus = "executor_cover_bonus"
        case fixedPrice = "fixed_price"
        case id
        case paymentType = "payment_type"
        case reason
        case roadDirection = "road_direction"
        case routes
        case sendingTime = "sending_time"
        case service
        case sourceType = "source_type"
        case status
        case statusTime = "status_time"
        case toPhone = "to_phone"
        case useTheBonus = "use_the_bonus"
    }
    
    public struct DNetResOrderBrand: Codable {
        public let addressName: String
        public let name: String
        public let serviceName: String
        
        enum CodingKeys: String, CodingKey {
            case addressName = "address_name"
            case name
            case serviceName = "service_name"
        }
    }
    
    public struct OrderDetail: Codable {
        public let approxDistance: Double
        public let approxDuration: Double
        public let approxTotalPrice: Int
        public let bonusAmount: Int
        public let comment: String
        public let cost: Int
        public let distance: Int
        public let duration: String
        public let modifPrice: Int
        public let modifPriceEvent: String
        public let services: [DNetResOrderService]?
        public let tariffName: String
        
        enum CodingKeys: String, CodingKey {
            case approxDistance = "approx_distance"
            case approxDuration = "approx_duration"
            case approxTotalPrice = "approx_total_price"
            case bonusAmount = "bonus_amount"
            case comment
            case cost
            case distance
            case duration
            case modifPrice = "modif_price"
            case modifPriceEvent = "modif_price_event"
            case services
            case tariffName = "tariff_name"
        }
    }
    
    public struct DirectionToClient: Codable {
        public let distance: Double
        public let duration: Double
        public let mapType: String
        
        enum CodingKeys: String, CodingKey {
            case distance
            case duration
            case mapType = "map_type"
        }
    }
    
    public struct OrderEnergy: Codable {
        public let cancel: Int
        public let km: Int
        public let minus: Int
        public let plus: Int
    }
    
    public struct ExecutorBonus: Codable {
        public let cost: Int
        public let minCost: Int
        public let minKm: Int
        public let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case cost
            case minCost = "min_cost"
            case minKm = "min_km"
            case status
        }
    }
    
    public struct ExecutorCoverBonus: Codable {
        public let approxPrice: Int
        public let calculationType: String
        public let cost: Int
        public let distance: Int
        public let duration: Int
        public let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case approxPrice = "approx_price"
            case calculationType = "calculation_type"
            case cost
            case distance
            case duration
            case status
        }
    }
    
    public struct ExecutorCompensation: Codable {
        let minCost: Double
        let minKm: Double
        let cost: Double
        
        enum CodingKeys: String, CodingKey {
            case minCost = "min_cost"
            case minKm  = "min_km"
            case cost
        }
    }
    
    public struct OrderRoadDirection: Codable {
        public let distance: Int
        public let duration: Int
    }
    
    public struct OrderRoute: Codable {
        public let coords: Coords
        public let lavel1: String
        public let level2: String
        
        enum CodingKeys: String, CodingKey {
            case coords
            case lavel1 = "lavel_1"
            case level2 = "level_2"
        }
        
        public struct Coords: Codable {
            public let lat: Double
            public let lng: Double
        }
    }
    
    
}
