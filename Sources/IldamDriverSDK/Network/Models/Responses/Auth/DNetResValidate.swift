//
//  DNetResOTPResult.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import NetworkLayer

struct DNetResValidate: DNetResBody {
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int?
    let executor: DNetResExecutor?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case executor
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try? container.decodeIfPresent(String.self, forKey: .accessToken)
        self.tokenType = try? container.decodeIfPresent(String.self, forKey: .tokenType)
        self.expiresIn = try? container.decodeIfPresent(Int.self, forKey: .expiresIn)
        self.executor = try? container.decodeIfPresent(DNetResExecutor.self, forKey: .executor)
    }
}
struct DNetResExecutor: Codable {
    let id: Int?
    let givenNames: String?
    let surName: String?
    let fatherName: String?
    let balance: Double?
    let phone: String?
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
    let brand: DNetResExecutorBrand?
    let addressId: Int?
    let createdAt: String?
    let tariffCategoryId: Int?
    let register: String?
    let activeness: Int?
    let rating: String?
    let fcmToken: String?
    let fotocontrol: DNetResExecutorFotocontrol?
    let transport: DNetResExecutorTransport?
    let plan: DNetResExecutorPlan?
    
    enum CodingKeys: String, CodingKey {
        case id, givenNames = "given_names", surName = "sur_name", fatherName = "father_name", balance, phone
        case blockNote = "block_note", level, blockExpiry = "block_expiry", status, condition, online, block, birthday
        case brandId = "brand_id", photo, serviceIds = "service_ids", addressBrand = "address_brand", brand
        case addressId = "address_id", createdAt = "created_at", tariffCategoryId = "tariff_category_id"
        case register, activeness, rating, fcmToken = "fcm_token", fotocontrol, transport, plan
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.givenNames = try? container.decodeIfPresent(String.self, forKey: .givenNames)
        self.surName = try? container.decodeIfPresent(String.self, forKey: .surName)
        self.fatherName = try? container.decodeIfPresent(String.self, forKey: .fatherName)
        self.balance = try? container.decodeIfPresent(Double.self, forKey: .balance)
        self.phone = try? container.decodeIfPresent(String.self, forKey: .phone)
        self.blockNote = try? container.decodeIfPresent(String.self, forKey: .blockNote)
        self.level = try? container.decodeIfPresent(Int.self, forKey: .level)
        self.blockExpiry = try? container.decodeIfPresent(String.self, forKey: .blockExpiry)
        self.status = try? container.decodeIfPresent(String.self, forKey: .status)
        self.condition = try? container.decodeIfPresent(Bool.self, forKey: .condition)
        self.online = try? container.decodeIfPresent(Bool.self, forKey: .online)
        self.block = try? container.decodeIfPresent(Bool.self, forKey: .block)
        self.birthday = try? container.decodeIfPresent(String.self, forKey: .birthday)
        self.brandId = try? container.decodeIfPresent(Int.self, forKey: .brandId)
        self.photo = try? container.decodeIfPresent(String.self, forKey: .photo)
        self.serviceIds = try? container.decodeIfPresent([Int].self, forKey: .serviceIds)
        self.addressBrand = try? container.decodeIfPresent(String.self, forKey: .addressBrand)
        self.brand = try? container.decodeIfPresent(DNetResExecutorBrand.self, forKey: .brand)
        self.addressId = try? container.decodeIfPresent(Int.self, forKey: .addressId)
        self.createdAt = try? container.decodeIfPresent(String.self, forKey: .createdAt)
        self.tariffCategoryId = try? container.decodeIfPresent(Int.self, forKey: .tariffCategoryId)
        self.register = try? container.decodeIfPresent(String.self, forKey: .register)
        self.activeness = try? container.decodeIfPresent(Int.self, forKey: .activeness)
        self.rating = try? container.decodeIfPresent(String.self, forKey: .rating)
        self.fcmToken = try? container.decodeIfPresent(String.self, forKey: .fcmToken)
        self.fotocontrol = try? container.decodeIfPresent(DNetResExecutorFotocontrol.self, forKey: .fotocontrol)
        self.transport = try? container.decodeIfPresent(DNetResExecutorTransport.self, forKey: .transport)
        self.plan = try? container.decodeIfPresent(DNetResExecutorPlan.self, forKey: .plan)
    }
}

struct DNetResExecutorBrand: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.slug = try? container.decodeIfPresent(String.self, forKey: .slug)
    }
}

struct DNetResExecutorFotocontrol: Codable {
    let fotocontrolStatus: Bool?
    let moderatorStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case fotocontrolStatus = "fotocontrol_status"
        case moderatorStatus = "moderator_status"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fotocontrolStatus = try? container.decodeIfPresent(Bool.self, forKey: .fotocontrolStatus)
        self.moderatorStatus = try? container.decodeIfPresent(String.self, forKey: .moderatorStatus)
    }
}

struct DNetResExecutorTransport: Codable {
    let mark: ExecutorTransportMark?
    let model: ExecutorTransportModel?
    let stateNumber: String?
    let color: ExecutorTransportColor?
    let callsign: String?
    
    enum CodingKeys: String, CodingKey {
        case mark, model
        case stateNumber = "state_number"
        case color, callsign
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mark = try? container.decodeIfPresent(ExecutorTransportMark.self, forKey: .mark)
        self.model = try? container.decodeIfPresent(ExecutorTransportModel.self, forKey: .model)
        self.stateNumber = try? container.decodeIfPresent(String.self, forKey: .stateNumber)
        self.color = try? container.decodeIfPresent(ExecutorTransportColor.self, forKey: .color)
        self.callsign = try? container.decodeIfPresent(String.self, forKey: .callsign)
    }
}

struct ExecutorTransportMark: Codable {
    let id: Int?
    let name: String?
}

struct ExecutorTransportModel: Codable {
    let id: Int?
    let name: String?
}

struct ExecutorTransportColor: Codable {
    let id: Int?
    let color: String?
    let name: String?
}

struct DNetResExecutorPlan: Codable {
    let id: Int?
    let name: DNetExecutorPlanName?
    let description: DNetExecutorPlanDescription?
    let cost: Int?
    let limitTime: Int?
    let planExpire: Int?
    let deactivation: Bool?
    let orderPayCost: Int?
    let orderPayPresent: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, cost
        case limitTime = "limit_time"
        case planExpire = "plan_expire"
        case deactivation
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(DNetExecutorPlanName.self, forKey: .name)
        self.description = try? container.decodeIfPresent(DNetExecutorPlanDescription.self, forKey: .description)
        self.cost = try? container.decodeIfPresent(Int.self, forKey: .cost)
        self.limitTime = try? container.decodeIfPresent(Int.self, forKey: .limitTime)
        self.planExpire = try? container.decodeIfPresent(Int.self, forKey: .planExpire)
        self.deactivation = try? container.decodeIfPresent(Bool.self, forKey: .deactivation)
        self.orderPayCost = try? container.decodeIfPresent(Int.self, forKey: .orderPayCost)
        self.orderPayPresent = try? container.decodeIfPresent(Int.self, forKey: .orderPayPresent)
    }
}

struct DNetExecutorPlanName: Codable {
    let uz: String?
    let ru: String?
}

struct DNetExecutorPlanDescription: Codable {
    let uz: String?
    let ru: String?
}

