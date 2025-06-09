//
//  DNetExecutorMeResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

struct DNetExecutorMeResponse: DNetResBody {
    let id: Int?
    let phone: String?
    let photo: String?
    let givenNames: String?
    let surName: String?
    let fatherName: String?
    let birthday: String?
    let rating: Int?
    let online: Bool?
    let status: String?
    let level: Int?
    let register: String?
    let balance: Double?
    let block: Bool?
    let blockNote: String??
    let blockExpiry: String??
    let condition: Bool?
    let createdAt: String?
    let addressId: Int?
    let activeness: Int?
    let priareted: Int?
    let appVer: String?
    let appVersions: String?
    let brand: DNetExecutorBrand?
    let fotocontrol: DNetExecutorFotoControl?
    let transport: DNetExecutorTransport?
    let executorService: [DNetExecutorService]?
    let plan: DNetExecutorPlan?

    enum CodingKeys: String, CodingKey {
        case id, phone, photo, rating, online, status, level, register, balance, block, condition, plan
        case givenNames = "given_names"
        case surName = "sur_name"
        case fatherName = "father_name"
        case birthday, blockNote = "block_note", blockExpiry = "block_expiry"
        case createdAt = "created_at", addressId = "address_id"
        case activeness, priareted, appVer = "app_ver", appVersions = "app_versions"
        case brand, fotocontrol, transport
        case executorService = "executor_service"
    }
}

struct DNetExecutorBrand: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct DNetExecutorFotoControl: Codable {
    let fotocontrolStatus: Bool?
    let moderatorStatus: String?

    enum CodingKeys: String, CodingKey {
        case fotocontrolStatus = "fotocontrol_status"
        case moderatorStatus = "moderator_status"
    }
}

struct DNetExecutorTransport: Codable {
    let callsign: String?
    let color: DNetExecutorColor?
    let mark: DNetExecutorMark?
    let model: DNetExecutorModel?
    let stateNumber: String?

    enum CodingKeys: String, CodingKey {
        case callsign, color, mark, model
        case stateNumber = "state_number"
    }
}

struct DNetExecutorColor: Codable {
    let color: String?
    let id: Int?
    let name: String?
}

struct DNetExecutorMark: Codable {
    let id: Int?
    let name: String?
}

struct DNetExecutorModel: Codable {
    let id: Int?
    let name: String?
}

struct DNetExecutorService: Codable {
    let id: Int?
    let name: String?
}
struct DNetExecutorPlan: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let cost: Int?
    let limitTime: Int?
    let planExpire: Int?
    let deactivation: Bool?
    let orderPayCost: Int?
    let orderPayPresent: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case cost
        case limitTime = "limit_time"
        case planExpire = "plan_expire"
        case deactivation
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
}
