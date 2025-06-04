//
//  DNetExecutorLoginResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//
import Foundation

struct DNetExecutorLoginResponse: DNetResBody {  
    let expiresIn: Int?
    let executor: DNetAuthMeResponse?

    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case executor
    }
}

struct DNetAuthMeResponse: Codable {
    let id: Int?
    let givenNames: String?
    let surName: String?
    let fatherName: String?
    let phone: String?
    let balance: Double?
    let blockNote: String?
    let level: Int?
    let blockExpiry: String?
    let status: String?
    let condition: Bool?
    let online: Bool?
    let block: Bool?
    let birthday: String?
    let brandId: Int?
    let photo: String?
    let serviceIds: [Int]?
    let addressBrand: String?
    let brand: DNetAuthMeBrand?
    let addressId: Int?
    let createdAt: String?
    let tariffCategoryId: Int?
    let register: String?
    let activeness: Int?
    let rating: String?
    let fcmToken: String?
    let fotocontrol: DNetAuthMeFotocontrol?
    let transport: DNetAuthMeTransport?
    let plan: DNetAuthMePlan?

    enum CodingKeys: String, CodingKey {
        case id
        case givenNames = "given_names"
        case surName = "sur_name"
        case fatherName = "father_name"
        case phone
        case balance
        case blockNote = "block_note"
        case level
        case blockExpiry = "block_expiry"
        case status
        case condition
        case online
        case block
        case birthday
        case brandId = "brand_id"
        case photo
        case serviceIds = "service_ids"
        case addressBrand = "address_brand"
        case brand
        case addressId = "address_id"
        case createdAt = "created_at"
        case tariffCategoryId = "tariff_category_id"
        case register
        case activeness
        case rating
        case fcmToken = "fcm_token"
        case fotocontrol
        case transport
        case plan
    }
}

struct DNetAuthMeBrand: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct DNetAuthMeFotocontrol: Codable {
    let fotocontrolStatus: Bool?
    let moderatorStatus: String?

    enum CodingKeys: String, CodingKey {
        case fotocontrolStatus = "fotocontrol_status"
        case moderatorStatus = "moderator_status"
    }
}

struct DNetAuthMeTransport: Codable {
    let mark: DNetAuthMeTransportInfo?
    let model: DNetAuthMeTransportInfo?
    let stateNumber: String?
    let color: DNetAuthMeTransportColor?
    let callsign: String?

    enum CodingKeys: String, CodingKey {
        case mark
        case model
        case stateNumber = "state_number"
        case color
        case callsign
    }
}

struct DNetAuthMeTransportInfo: Codable {
    let id: Int?
    let name: String?
}

struct DNetAuthMeTransportColor: Codable {
    let id: Int?
    let color: String?
    let name: String?
}

struct DNetAuthMePlan: Codable {
    let id: Int?
    let name: DNetAuthMeLocalizedText?
    let description: DNetAuthMeLocalizedText?
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

struct DNetAuthMeLocalizedText: Codable {
    let uz: String?
    let ru: String?
}
