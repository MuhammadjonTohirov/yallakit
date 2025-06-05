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
    init?(from dNetResponse: DNetExecutorLoginResponse?) {
        guard let dNetResponse = dNetResponse,
              let expiresIn = dNetResponse.expiresIn,
              let executor = AuthMeExecutor(from: dNetResponse.executor) else {
            return nil // Initialization fails if essential data is missing
        }
        self.expiresIn = expiresIn
        self.executor = executor
    }
}

public struct AuthMeExecutor {
    public let id: Int
    public let givenNames: String
    public let surName: String
    public let phone: String
    public let balance: Double
    public let level: Int
    public let status: String
    public let condition: Bool
    public let online: Bool
    public let block: Bool
    public let birthday: String
    public let brandId: Int
    public let photo: String
    public let serviceIds: [Int]
    public let brand: AuthMeExecutorBrand
    public let addressId: Int
    public let createdAt: String
    public let tariffCategoryId: Int
    public let register: String
    public let activeness: Int
    public let rating: String
    
    // Optional properties
    public let fatherName: String?
    public let blockNote: String?
    public let blockExpiry: String?
    public let fcmToken: String?
    public let addressBrand: String?
    public let fotocontrol: AuthMeExecutorFotocontrol?
    public let transport: AuthMeExecutorTransport?
    public let plan: AuthMeExecutorPlan?
    
    public init(id: Int, givenNames: String, surName: String, phone: String, balance: Double, level: Int, status: String, condition: Bool, online: Bool, block: Bool, birthday: String, brandId: Int, photo: String, serviceIds: [Int], brand: AuthMeExecutorBrand, addressId: Int, createdAt: String, tariffCategoryId: Int, register: String, activeness: Int, rating: String, fatherName: String?, blockNote: String?, blockExpiry: String?, fcmToken: String?, addressBrand: String?, fotocontrol: AuthMeExecutorFotocontrol?, transport: AuthMeExecutorTransport?, plan: AuthMeExecutorPlan?) {
        self.id = id
        self.givenNames = givenNames
        self.surName = surName
        self.phone = phone
        self.balance = balance
        self.level = level
        self.status = status
        self.condition = condition
        self.online = online
        self.block = block
        self.birthday = birthday
        self.brandId = brandId
        self.photo = photo
        self.serviceIds = serviceIds
        self.brand = brand
        self.addressId = addressId
        self.createdAt = createdAt
        self.tariffCategoryId = tariffCategoryId
        self.register = register
        self.activeness = activeness
        self.rating = rating
        self.fatherName = fatherName
        self.blockNote = blockNote
        self.blockExpiry = blockExpiry
        self.fcmToken = fcmToken
        self.addressBrand = addressBrand
        self.fotocontrol = fotocontrol
        self.transport = transport
        self.plan = plan
    }
    init?(from dNetResponse: DNetAuthMeResponse?) {
        guard let response = dNetResponse else { return nil }
        
        // Required properties
        guard let id = response.id,
              let givenNames = response.givenNames,
              let surName = response.surName,
              let phone = response.phone,
              let balance = response.balance,
              let level = response.level,
              let status = response.status,
              let condition = response.condition,
              let online = response.online,
              let block = response.block,
              let birthday = response.birthday,
              let brandId = response.brandId,
              let photo = response.photo,
              let serviceIds = response.serviceIds,
              let brand = AuthMeExecutorBrand(from: response.brand),
              let addressId = response.addressId,
              let createdAt = response.createdAt,
              let tariffCategoryId = response.tariffCategoryId,
              let register = response.register,
              let activeness = response.activeness,
              let rating = response.rating else {
            return nil
        }
        
        self.id = id
        self.givenNames = givenNames
        self.surName = surName
        self.phone = phone
        self.balance = balance
        self.level = level
        self.status = status
        self.condition = condition
        self.online = online
        self.block = block
        self.birthday = birthday
        self.brandId = brandId
        self.photo = photo
        self.serviceIds = serviceIds
        self.brand = brand
        self.addressId = addressId
        self.createdAt = createdAt
        self.tariffCategoryId = tariffCategoryId
        self.register = register
        self.activeness = activeness
        self.rating = rating
        
        // Optional properties
        self.fatherName = response.fatherName
        self.blockNote = response.blockNote
        self.blockExpiry = response.blockExpiry
        self.fcmToken = response.fcmToken
        self.addressBrand = response.addressBrand
        self.fotocontrol = AuthMeExecutorFotocontrol(from: response.fotocontrol)
        self.transport = AuthMeExecutorTransport(from: response.transport)
        self.plan = AuthMeExecutorPlan(from: response.plan)
    }
}

// MARK: - Supporting Models
public struct AuthMeExecutorBrand {
    public let id: Int
    public let name: String
    public let slug: String
    
    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }

    init?(from network: DNetAuthMeBrand?) {
        guard let network = network,
              let id = network.id,
              let name = network.name,
              let slug = network.slug else {
            return nil
        }
        self.id = id
        self.name = name
        self.slug = slug
    }
}

public struct AuthMeExecutorFotocontrol {
    public let fotocontrolStatus: Bool
    public let moderatorStatus: String
    
    public init(fotocontrolStatus: Bool, moderatorStatus: String) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }
 
    init?(from network: DNetAuthMeFotocontrol?) {
        guard let network = network else { return nil }
        self.fotocontrolStatus = network.fotocontrolStatus ?? false
        self.moderatorStatus = network.moderatorStatus ?? ""
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
    
    init?(from network: DNetAuthMeTransport?) {
        guard let network = network,
              let mark = AuthMeExecutorTransportInfo(from: network.mark),
              let model = AuthMeExecutorTransportInfo(from: network.model),
              let color = AuthMeExecutorTransportColor(from: network.color) else {
            return nil
        }
        
        self.mark = mark
        self.model = model
        self.stateNumber = network.stateNumber ?? ""
        self.color = color
        self.callsign = network.callsign ?? ""
    }
}

public struct AuthMeExecutorTransportInfo {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    init?(from network: DNetAuthMeTransportInfo?) {
        guard let network = network,
              let id = network.id,
              let name = network.name else {
            return nil
        }
        self.id = id
        self.name = name
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
    
    init?(from network: DNetAuthMeTransportColor?) {
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

public struct AuthMeExecutorPlan {
    public let id: Int
    public let name: String
    public let description: String
    public let cost: Int
    public let limitTime: Int
    public let planExpire: Int
    public let deactivation: Bool
    public let orderPayCost: Int
    public let orderPayPresent: Int
    
    public init(id: Int, name: String, description: String, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
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
    
    init?(from network: DNetAuthMePlan?) {
        guard let network = network,
              let name = network.name,
              let description = network.description else {
            return nil
        }
        
        self.id = network.id ?? 0
        self.name = name
        self.description = description
        self.cost = network.cost ?? 0
        self.limitTime = network.limitTime ?? 0
        self.planExpire = network.planExpire ?? 0
        self.deactivation = network.deactivation ?? false
        self.orderPayCost = network.orderPayCost ?? 0
        self.orderPayPresent = network.orderPayPresent ?? 0
    }
}

 
