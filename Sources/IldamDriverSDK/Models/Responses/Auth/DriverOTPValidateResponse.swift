//
//  DNetResValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//
import Foundation

public struct DriverOTPValidateResponse {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let executor: ValidExecutorResult?

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

        self.accessToken = network.accessToken ?? ""
        self.tokenType = network.tokenType ?? ""
        self.expiresIn = network.expiresIn ?? 0
        
        guard let executor = network.executor,
              let validExecutor = ValidExecutorResult(from: executor) else {
            return nil
        }
        self.executor = validExecutor
    }

}

public struct ValidExecutorResult: Codable {
    // Required properties
    public let id: Int?
    public let givenNames: String?
    public let surName: String?
    public let balance: Double?
    public let phone: String?
    public let level: Int?
    public let status: String?
    public let condition: Bool?
    public let online: Bool?
    public let block: Bool?
    public let birthday: String?
    public let brandId: Int?
    public let photo: String?
    public let serviceIds: [Int]?
    public let addressId: Int?
    public let createdAt: String?
    public let tariffCategoryId: Int?
    public let register: String?
    public let activeness: Int?
    public let rating: String?
    public let fcmToken: String
    public let fatherName: String?
    public let blockNote: String?
    public let blockExpiry: String?
    public let addressBrand: String?
    public let brand: ValidExecutorBrand?
    public let fotocontrol: ValidExecutorFotocontrol?
    public let transport: ValidExecutorTransport?
    public let plan: ValidExecutorPlan?
    
    // Manual initializer
    public init(
        id: Int,
        givenNames: String,
        surName: String,
        fatherName: String?,
        balance: Double,
        phone: String,
        blockNote: String?,
        level: Int,
        blockExpiry: String?,
        status: String,
        condition: Bool,
        online: Bool,
        block: Bool,
        birthday: String,
        brandId: Int,
        photo: String,
        serviceIds: [Int],
        addressBrand: String?,
        brand: ValidExecutorBrand?,
        addressId: Int,
        createdAt: String,
        tariffCategoryId: Int,
        register: String,
        activeness: Int,
        rating: String,
        fcmToken: String,
        fotocontrol: ValidExecutorFotocontrol?,
        transport: ValidExecutorTransport?,
        plan: ValidExecutorPlan?
    ) {
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
    
    // Network initializer
    init?(from network: DNetResExecutor?) {
        guard let network = network else { return nil }
        
        guard let id = network.id,
              let givenNames = network.givenNames,
              let surName = network.surName,
              let balance = network.balance,
              let phone = network.phone,
              let level = network.level,
              let status = network.status,
              let condition = network.condition,
              let online = network.online,
              let block = network.block,
              let birthday = network.birthday,
              let brandId = network.brandId,
              let photo = network.photo,
              let serviceIds = network.serviceIds,
              let addressId = network.addressId,
              let createdAt = network.createdAt,
              let tariffCategoryId = network.tariffCategoryId,
              let register = network.register,
              let activeness = network.activeness,
              let rating = network.rating,
              let fcmToken = network.fcmToken
        else {
            return nil
        }
        
        self.id = id
        self.givenNames = givenNames
        self.surName = surName
        self.balance = balance
        self.phone = phone
        self.level = level
        self.status = status
        self.condition = condition
        self.online = online
        self.block = block
        self.birthday = birthday
        self.brandId = brandId
        self.photo = photo
        self.serviceIds = serviceIds
        self.addressId = addressId
        self.createdAt = createdAt
        self.tariffCategoryId = tariffCategoryId
        self.register = register
        self.activeness = activeness
        self.rating = rating
        self.fcmToken = fcmToken
        
        // Optional properties
        self.fatherName = network.fatherName
        self.blockNote = network.blockNote
        self.blockExpiry = network.blockExpiry
        self.addressBrand = network.addressBrand
        self.brand = ValidExecutorBrand.init(from:network.brand)
        self.fotocontrol = ValidExecutorFotocontrol.init(from:network.fotocontrol)
        self.transport = ValidExecutorTransport.init(from:network.transport)
        self.plan = ValidExecutorPlan.init(from:network.plan)
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

    init?(from network: DNetResExecutorBrand?) {
        guard
            let id = network?.id,
            let name = network?.name,
            let slug = network?.slug else { return nil }
        
        self.id = id
        self.name = name
        self.slug = slug
    }
}
public struct ValidExecutorFotocontrol: Codable {
    public let fotocontrolStatus: Bool?
    public let moderatorStatus: String?

    public init(fotocontrolStatus: Bool, moderatorStatus: String?) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }

    init?(from network: DNetResExecutorFotocontrol?) {
        guard let fotocontrolStatus = network?.fotocontrolStatus,
              let moderatorStatus = network?.moderatorStatus else { return nil }
        
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
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

    init?(from network: DNetResExecutorTransport?) {
        guard let network = network,
              let stateNumber = network.stateNumber,
              let callsign = network.callsign,
              let mark = ValidExecutorTransportMark(from: network.mark),
              let model = ValidExecutorTransportModel(from: network.model),
              let color = ValidExecutorTransportColor(from: network.color) else {
            return nil
        }
        
        self.mark = mark
        self.model = model
        self.stateNumber = stateNumber
        self.color = color
        self.callsign = callsign
    }
}
public struct ValidExecutorTransportMark: Codable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init?(from network: ExecutorTransportMark?) {
        guard let id = network?.id,
              let name = network?.name
        else {return nil}
        
        self.id = id
        self.name = name
    }
}
public struct ValidExecutorTransportModel: Codable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init?(from network: ExecutorTransportModel?) {  // Note the optional parameter
        guard let network = network,
              let id = network.id,
              let name = network.name else {
            return nil
        }
        self.id = id
        self.name = name
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

    init?(from network: ExecutorTransportColor?) {
        guard let network = network,
              let id = network.id,
              let color = network.color,
              let name = network.name else {
            return nil
        }
        self.id = id
        self.color = color
        self.name = name
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
    
    init(id: Int, name: ValidExecutorPlanName, description: ValidExecutorPlanDescription, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
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
    init?(from network: DNetResExecutorPlan?) {
        guard let network = network,
              let id = network.id,
              let cost = network.cost,
              let lineLimitTime = network.limitTime,
              let planExpire = network.planExpire,
              let deactivation = network.deactivation,
              let orderPayCost = network.orderPayCost,
              let orderPayPresent = network.orderPayPresent,
              let name = ValidExecutorPlanName(from: network.name),
              let description = ValidExecutorPlanDescription(from: network.description) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.cost = cost
        self.limitTime = lineLimitTime
        self.planExpire = planExpire
        self.deactivation = deactivation
        self.orderPayCost = orderPayCost
        self.orderPayPresent = orderPayPresent
    }
}

public struct ValidExecutorPlanName: Codable {
    public let uz: String
    public let ru: String

    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }

    init?(from network: DNetExecutorPlanName?) {
        
        guard
            let uz = network?.uz,
            let ru = network?.ru
        
        else {return nil}
        
        self.uz = uz
        self.ru = ru
    }
}

public struct ValidExecutorPlanDescription: Codable {
    public let uz: String
    public let ru: String
   
    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }
    
    init?(from network: DNetExecutorPlanDescription?) {
        guard let network = network,
              let uz = network.uz,
              let ru = network.ru else {
            return nil
        }
        self.uz = uz
        self.ru = ru
    }
}
