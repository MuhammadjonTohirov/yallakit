//
//  DNetResValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//
import Foundation

public struct DriverOTPResponceValidateResponse {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let executor: ValidExecutorResult

    public init(
        accessToken: String,
        tokenType: String,
        expiresIn: Int,
        executor: ValidExecutorResult
    ) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.executor = executor
    }

    init?(from network: DNetResValidate?) {
        guard let network else { return nil }

        self.accessToken = network.accessToken
        self.tokenType = network.tokenType
        self.expiresIn = network.expiresIn
        
        guard let executor = network.executor,
              let validExecutor = ValidExecutorResult(from: executor) else {
            return nil
        }
        self.executor = validExecutor
    }

}

public struct ValidExecutorResult: Codable {
    public let id: Int
    public let givenNames: String
    public let surName: String
    public let fatherName: String
    public let balance: Double
    public let phone: String
    public let blockNote: String?
    public let level: Int
    public let blockExpiry: String?
    public let status: String
    public let condition: Bool
    public let online: Bool
    public let block: Bool
    public let birthday: String
    public let brandId: Int
    public let photo: String
    public let serviceIds: [Int]
    public let addressBrand: String?
    public let brand: ValidExecutorBrand
    public let addressId: Int
    public let createdAt: String
    public let tariffCategoryId: Int
    public let register: String
    public let activeness: Int
    public let rating: String
    public let fcmToken: String
    public let fotocontrol: ValidExecutorFotocontrol
    public let transport: ValidExecutorTransport
    public let plan: ValidExecutorPlan

    public init(id: Int, givenNames: String, surName: String, fatherName: String, balance: Double, phone: String, blockNote: String?, level: Int, blockExpiry: String?, status: String, condition: Bool, online: Bool, block: Bool, birthday: String, brandId: Int, photo: String, serviceIds: [Int], addressBrand: String?, brand: ValidExecutorBrand, addressId: Int, createdAt: String, tariffCategoryId: Int, register: String, activeness: Int, rating: String, fcmToken: String, fotocontrol: ValidExecutorFotocontrol, transport: ValidExecutorTransport, plan: ValidExecutorPlan) {
        self.id = id
        self.givenNames = givenNames
        self.surName = surName
        self.fatherName = fatherName
        self.balance = balance
        self.phone = phone
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

    init?(from network: DNetResExecutor?) {
        guard let network else { return nil }

        self.id = network.id
        self.givenNames = network.givenNames
        self.surName = network.surName
        self.fatherName = network.fatherName
        self.balance = network.balance
        self.phone = network.phone
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
        self.brand = ValidExecutorBrand(from: network.brand)
        self.addressId = network.addressId
        self.createdAt = network.createdAt
        self.tariffCategoryId = network.tariffCategoryId
        self.register = network.register
        self.activeness = network.activeness
        self.rating = network.rating
        self.fcmToken = network.fcmToken

        guard let fotocontrol = network.fotocontrol,
              let transport = network.transport,
              let plan = network.plan else {
            return nil
        }

        self.fotocontrol = ValidExecutorFotocontrol(from: fotocontrol)
        self.transport = ValidExecutorTransport(from: transport)
        self.plan = ValidExecutorPlan(from: plan)
    }

}
public struct ValidExecutorBrand: Codable {
    public let id: Int
    public let name: String
    public let slug: String

    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }

    init(from network: DNetResExecutorBrand) {
        self.id = network.id
        self.name = network.name
        self.slug = network.slug
    }
}
public struct ValidExecutorFotocontrol: Codable {
    public let fotocontrolStatus: Bool
    public let moderatorStatus: String?

    public init(fotocontrolStatus: Bool, moderatorStatus: String?) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }

    init(from network: DNetResExecutorFotocontrol) {
        self.fotocontrolStatus = network.fotocontrolStatus
        self.moderatorStatus = network.moderatorStatus
    }
}
public struct ValidExecutorTransport: Codable {
    public let mark: ValidExecutorTransportMark
    public let model: ValidExecutorTransportModel
    public let stateNumber: String
    public let color: ValidExecutorTransportColor
    public let callsign: String

    public init(mark: ValidExecutorTransportMark, model: ValidExecutorTransportModel, stateNumber: String, color: ValidExecutorTransportColor, callsign: String) {
        self.mark = mark
        self.model = model
        self.stateNumber = stateNumber
        self.color = color
        self.callsign = callsign
    }

    init(from network: DNetResExecutorTransport) {
        self.mark = ValidExecutorTransportMark(from: network.mark)
        self.model = ValidExecutorTransportModel(from: network.model)
        self.stateNumber = network.stateNumber
        self.color = ValidExecutorTransportColor(from: network.color)
        self.callsign = network.callsign
    }
}
public struct ValidExecutorTransportMark: Codable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(from network: ExecutorTransportMark) {
        self.id = network.id
        self.name = network.name
    }
}

public struct ValidExecutorTransportModel: Codable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(from network: ExecutorTransportModel) {
        self.id = network.id
        self.name = network.name
    }
}

public struct ValidExecutorTransportColor: Codable {
    public let id: Int
    public let color: String
    public let name: String

    public init(id: Int, color: String, name: String) {
        self.id = id
        self.color = color
        self.name = name
    }

    init(from network: ExecutorTransportColor) {
        self.id = network.id
        self.color = network.color
        self.name = network.name
    }
}
public struct ValidExecutorPlan: Codable {
    public let id: Int
    public let name: ValidExecutorPlanName
    public let description: ValidExecutorPlanDescription
    public let cost: Int
    public let limitTime: Int
    public let planExpire: Int
    public let deactivation: Bool
    public let orderPayCost: Int
    public let orderPayPresent: Int

    public init(id: Int, name: ValidExecutorPlanName, description: ValidExecutorPlanDescription, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
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

    init(from network: DNetResExecutorPlan) {
        self.id = network.id
        self.name = ValidExecutorPlanName(from: network.name)
        self.description = ValidExecutorPlanDescription(from: network.description)
        self.cost = network.cost
        self.limitTime = network.limitTime
        self.planExpire = network.planExpire
        self.deactivation = network.deactivation
        self.orderPayCost = network.orderPayCost
        self.orderPayPresent = network.orderPayPresent
    }
}

public struct ValidExecutorPlanName: Codable {
    public let uz: String
    public let ru: String

    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }

    init(from network: DNetExecutorPlanName) {
        self.uz = network.uz
        self.ru = network.ru
    }
}

public struct ValidExecutorPlanDescription: Codable {
    public let uz: String
    public let ru: String

    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }

    init(from network: DNetExecutorPlanDescription) {
        self.uz = network.uz
        self.ru = network.ru
    }
}
