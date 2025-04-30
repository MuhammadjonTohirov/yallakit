//
//  DNetResOTPResult.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import NetworkLayer

struct DNetResValidate: DNetResBody {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let executor: DNetResExecutor
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case executor
    }
    
}
struct DNetResExecutor: Codable {
    let id: Int
    let givenNames: String
    let surName: String
    let fatherName: String
    let balance: Double
    let phone: String
    let blockNote: String?
    let level: Int
    let blockExpiry: String?
    let status: String
    let condition: Bool
    let online: Bool
    let block: Bool
    let birthday: String
    let brandId: Int
    let photo: String
    let serviceIds: [Int]
    let addressBrand: String?
    let brand: DNetResExecutorBrand
    let addressId: Int
    let createdAt: String
    let tariffCategoryId: Int
    let register: String
    let activeness: Int
    let rating: String
    let fcmToken: String
    let fotocontrol: DNetResExecutorFotocontrol
    let transport: DNetResExecutorTransport
    let plan: DNetResExecutorPlan
    
    enum CodingKeys: String, CodingKey {
        case id, givenNames = "given_names", surName = "sur_name", fatherName = "father_name", balance, phone
        case blockNote = "block_note", level, blockExpiry = "block_expiry", status, condition, online, block, birthday
        case brandId = "brand_id", photo, serviceIds = "service_ids", addressBrand = "address_brand", brand
        case addressId = "address_id", createdAt = "created_at", tariffCategoryId = "tariff_category_id"
        case register, activeness, rating, fcmToken = "fcm_token", fotocontrol, transport, plan
    }
}

struct DNetResExecutorBrand: Codable {
    let id: Int
    let name: String
    let slug: String
}

struct DNetResExecutorFotocontrol: Codable {
    let fotocontrolStatus: Bool
    let moderatorStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case fotocontrolStatus = "fotocontrol_status"
        case moderatorStatus = "moderator_status"
    }
}

struct DNetResExecutorTransport: Codable {
    let mark: ExecutorTransportMark
    let model: ExecutorTransportModel
    let stateNumber: String
    let color: ExecutorTransportColor
    let callsign: String
    
    enum CodingKeys: String, CodingKey {
        case mark, model
        case stateNumber = "state_number"
        case color, callsign
    }
}

struct ExecutorTransportMark: Codable {
    let id: Int
    let name: String
}

struct ExecutorTransportModel: Codable {
    let id: Int
    let name: String
}

struct ExecutorTransportColor: Codable {
    let id: Int
    let color: String
    let name: String
}

struct DNetResExecutorPlan: Codable {
    let id: Int
    let name: DNetExecutorPlanName
    let description: DNetExecutorPlanDescription
    let cost: Int
    let limitTime: Int
    let planExpire: Int
    let deactivation: Bool
    let orderPayCost: Int
    let orderPayPresent: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, cost
        case limitTime = "limit_time"
        case planExpire = "plan_expire"
        case deactivation
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
}

struct DNetExecutorPlanName: Codable {
    let uz: String
    let ru: String
}

struct DNetExecutorPlanDescription: Codable {
    let uz: String
    let ru: String
}

