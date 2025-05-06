//
//  AuthMe.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

public struct ExecutorLoginResponse {
    public let expiresIn: Int
    public let executor: AuthMeExecutor

    public init(expiresIn: Int, executor: AuthMeExecutor) {
        self.expiresIn = expiresIn
        self.executor = executor
    }
    init(from network: DNetExecutorLoginResponse) {
        self.expiresIn = network.expiresIn
        self.executor = AuthMeExecutor(from: network.executor)
    }
}

public struct AuthMeExecutor {
    public let id: Int
    public let givenNames, surName, fatherName, phone: String
    public let balance: Double
    public let blockNote: String?
    public let level: Int
    public let blockExpiry: String?
    public let status: String
    public let condition, online, block: Bool
    public let birthday: String
    public let brandId: Int
    public let photo: String
    public let serviceIds: [Int]
    public let addressBrand: String?
    public let brand: AuthMeExecutorBrand
    public let addressId: Int
    public let createdAt: String
    public let tariffCategoryId: Int
    public let register: String
    public let activeness: Int
    public let rating: String
    public let fcmToken: String
    public let fotocontrol: AuthMeExecutorFotocontrol
    public let transport: AuthMeExecutorTransport
    public let plan: AuthMeExecutorPlan?

    public init(id: Int, givenNames: String, surName: String, fatherName: String, phone: String, balance: Double, blockNote: String?, level: Int, blockExpiry: String?, status: String, condition: Bool, online: Bool, block: Bool, birthday: String, brandId: Int, photo: String, serviceIds: [Int], addressBrand: String?, brand: AuthMeExecutorBrand, addressId: Int, createdAt: String, tariffCategoryId: Int, register: String, activeness: Int, rating: String, fcmToken: String, fotocontrol: AuthMeExecutorFotocontrol, transport: AuthMeExecutorTransport, plan: AuthMeExecutorPlan?) {
        self.id = id
        self.givenNames = givenNames
        self.surName = surName
        self.fatherName = fatherName
        self.phone = phone
        self.balance = balance
        self.blockNote = blockNote
        self.level = level
        self.blockExpiry = blockExpiry
        self.status = status
        self.condition = condition
        self.online = online
        self.block = block
        self.birthday = birthday
        self.brandId = brandId
        self.photo = photo
        self.serviceIds = serviceIds
        self.addressBrand = addressBrand
        self.brand = brand
        self.addressId = addressId
        self.createdAt = createdAt
        self.tariffCategoryId = tariffCategoryId
        self.register = register
        self.activeness = activeness
        self.rating = rating
        self.fcmToken = fcmToken
        self.fotocontrol = fotocontrol
        self.transport = transport
        self.plan = plan
    }
    init(from network: DNetAuthMeResponse) {
        self.id = network.id
        self.givenNames = network.givenNames
        self.surName = network.surName
        self.fatherName = network.fatherName
        self.phone = network.phone
        self.balance = network.balance
        self.blockNote = network.blockNote
        self.level = network.level
        self.blockExpiry = network.blockExpiry
        self.status = network.status
        self.condition = network.condition
        self.online = network.online
        self.block = network.block
        self.birthday = network.birthday
        self.brandId = network.brandId
        self.photo = network.photo
        self.serviceIds = network.serviceIds
        self.addressBrand = network.addressBrand
        self.brand = AuthMeExecutorBrand(from: network.brand)
        self.addressId = network.addressId
        self.createdAt = network.createdAt
        self.tariffCategoryId = network.tariffCategoryId
        self.register = network.register
        self.activeness = network.activeness
        self.rating = network.rating
        self.fcmToken = network.fcmToken
        self.fotocontrol = AuthMeExecutorFotocontrol(from: network.fotocontrol)
        self.transport = AuthMeExecutorTransport(from: network.transport)
        self.plan = network.plan.map { AuthMeExecutorPlan(from: $0) }
    }
}

public struct AuthMeExecutorBrand {
    public let id: Int
    public let name, slug: String

    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    init(from network: DNetAuthMeBrand) {
        self.id = network.id
        self.name = network.name
        self.slug = network.slug
    }
}

public struct AuthMeExecutorFotocontrol {
    public let fotocontrolStatus: Bool
    public let moderatorStatus: String

    public init(fotocontrolStatus: Bool, moderatorStatus: String) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }
    init(from network: DNetAuthMeFotocontrol) {
        self.fotocontrolStatus = network.fotocontrolStatus
        self.moderatorStatus = network.moderatorStatus
    }
}

public struct AuthMeExecutorTransport {
    public let mark: AuthMeExecutorTransportInfo
    public let model: AuthMeExecutorTransportInfo
    public let stateNumber: String
    public let color: AuthMeExecutorTransportColor
    public let callsign: String

    public init(mark: AuthMeExecutorTransportInfo, model: AuthMeExecutorTransportInfo, stateNumber: String, color: AuthMeExecutorTransportColor, callsign: String) {
        self.mark = mark
        self.model = model
        self.stateNumber = stateNumber
        self.color = color
        self.callsign = callsign
    }
    
    init(from network: DNetAuthMeTransport) {
        self.mark = AuthMeExecutorTransportInfo(from: network.mark)
        self.model = AuthMeExecutorTransportInfo(from: network.model)
        self.stateNumber = network.stateNumber
        self.color = AuthMeExecutorTransportColor(from: network.color)
        self.callsign = network.callsign
    }
}

public struct AuthMeExecutorTransportInfo {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetAuthMeTransportInfo) {
        self.id = network.id
        self.name = network.name
    }
}

public struct AuthMeExecutorTransportColor {
    public let id: Int
    public let color: String
    public let name: String

    public init(id: Int, color: String, name: String) {
        self.id = id
        self.color = color
        self.name = name
    }
    init(from network: DNetAuthMeTransportColor) {
        self.id = network.id
        self.color = network.color
        self.name = network.name
    }
}

public struct AuthMeExecutorPlan {
    public let id: Int
    public let name: AuthMeExecutorLocalizedText
    public let description: AuthMeExecutorLocalizedText
    public let cost: Int
    public let limitTime: Int
    public let planExpire: Int
    public let deactivation: Bool
    public let orderPayCost: Int
    public let orderPayPresent: Int

    public init(id: Int, name: AuthMeExecutorLocalizedText, description: AuthMeExecutorLocalizedText, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.cost = cost
        self.limitTime = limitTime
        self.planExpire = planExpire
        self.deactivation = deactivation
        self.orderPayCost = orderPayCost
        self.orderPayPresent = orderPayPresent
    }
    
    init(from network: DNetAuthMePlan) {
        self.id = network.id
        self.name = AuthMeExecutorLocalizedText(from: network.name)
        self.description = AuthMeExecutorLocalizedText(from: network.description)
        self.cost = network.cost
        self.limitTime = network.limitTime
        self.planExpire = network.planExpire
        self.deactivation = network.deactivation
        self.orderPayCost = network.orderPayCost
        self.orderPayPresent = network.orderPayPresent
    }
}

public struct AuthMeExecutorLocalizedText {
    public let uz: String
    public let ru: String

    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }
    
    init(from network: DNetAuthMeLocalizedText) {
        self.uz = network.uz
        self.ru = network.ru
    }
}

public struct AuthMeExecutorCarMark: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorMark) {
        self.id = network.id
        self.name = network.name
    }
}
