//
//  ExecutorMeResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

public struct ExecutorMeResponse {
    public let id: Int
    public let phone: String
    public let photo: String
    public let givenNames: String
    public let surName: String
    public let fatherName: String
    public let birthday: String
    public let rating: Int
    public let online: Bool
    public let status: String
    public let level: Int
    public let register: String
    public let balance: Double
    public let block: Bool
    public let blockNote: String?
    public let blockExpiry: String?
    public let condition: Bool
    public let createdAt: String
    public let addressId: Int
    public let activeness: Int
    public let priareted: Int
    public let appVer: String
    public let appVersions: String
    public let brand: ExecutorBrand
    public let fotocontrol: ExecutorFotoControl
    public let transport: ExecutorTransport
    public let executorServices: [ExecutorService]
    public let plan: ExecutorPlan? // null-able
    
    public init(id: Int, phone: String, photo: String, givenNames: String, surName: String, fatherName: String, birthday: String, rating: Int, online: Bool, status: String, level: Int, register: String, balance: Double, block: Bool, blockNote: String?, blockExpiry: String?, condition: Bool, createdAt: String, addressId: Int, activeness: Int, priareted: Int, appVer: String, appVersions: String, brand: ExecutorBrand, fotocontrol: ExecutorFotoControl, transport: ExecutorTransport, executorServices: [ExecutorService], plan: ExecutorPlan?) {
        self.id = id
        self.phone = phone
        self.photo = photo
        self.givenNames = givenNames
        self.surName = surName
        self.fatherName = fatherName
        self.birthday = birthday
        self.rating = rating
        self.online = online
        self.status = status
        self.level = level
        self.register = register
        self.balance = balance
        self.block = block
        self.blockNote = blockNote
        self.blockExpiry = blockExpiry
        self.condition = condition
        self.createdAt = createdAt
        self.addressId = addressId
        self.activeness = activeness
        self.priareted = priareted
        self.appVer = appVer
        self.appVersions = appVersions
        self.brand = brand
        self.fotocontrol = fotocontrol
        self.transport = transport
        self.executorServices = executorServices
        self.plan = plan
    }
    init(from network: DNetExecutorMeResponse) {
        self.id = network.id
        self.phone = network.phone
        self.photo = network.photo
        self.givenNames = network.givenNames
        self.surName = network.surName
        self.fatherName = network.fatherName
        self.birthday = network.birthday
        self.rating = network.rating
        self.online = network.online
        self.status = network.status
        self.level = network.level
        self.register = network.register
        self.balance = network.balance
        self.block = network.block
        self.blockNote = network.blockNote
        self.blockExpiry = network.blockExpiry
        self.condition = network.condition
        self.createdAt = network.createdAt
        self.addressId = network.addressId
        self.activeness = network.activeness
        self.priareted = network.priareted
        self.appVer = network.appVer
        self.appVersions = network.appVersions
        self.brand = ExecutorBrand(from: network.brand)
        self.fotocontrol = ExecutorFotoControl(from: network.fotocontrol)
        self.transport = ExecutorTransport(from: network.transport)
        self.executorServices = network.executorService.map { ExecutorService(from: $0) }
        self.plan = network.plan.map { ExecutorPlan(from: $0) }
    }
}

public struct ExecutorBrand: Codable {
    public let id: Int
    public let name: String
    public let slug: String
    
    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    init(from network: DNetExecutorBrand) {
        self.id = network.id
        self.name = network.name
        self.slug = network.slug
    }
}

public struct ExecutorFotoControl: Codable {
    public let fotocontrolStatus: Bool
    public let moderatorStatus: String?
    
    public init(fotocontrolStatus: Bool, moderatorStatus: String?) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }
    init(from network: DNetExecutorFotoControl) {
        self.fotocontrolStatus = network.fotocontrolStatus
        self.moderatorStatus = network.moderatorStatus
    }
}

public struct ExecutorTransport: Codable {
    public let callsign: String
    public let color: ExecutorCarColor
    public let mark: ExecutorCarMark
    public let model: ExecutorCarModel
    public let stateNumber: String
    
    public init(callsign: String, color: ExecutorCarColor, mark: ExecutorCarMark, model: ExecutorCarModel, stateNumber: String) {
        self.callsign = callsign
        self.color = color
        self.mark = mark
        self.model = model
        self.stateNumber = stateNumber
    }
    
    init(from network: DNetExecutorTransport) {
        self.callsign = network.callsign
        self.color = ExecutorCarColor(from: network.color)
        self.mark = ExecutorCarMark(from: network.mark)
        self.model = ExecutorCarModel(from: network.model)
        self.stateNumber = network.stateNumber
    }
}

public struct ExecutorCarColor: Codable {
    public let color: String
    public let id: Int
    public let name: String
    
    public init(color: String, id: Int, name: String) {
        self.color = color
        self.id = id
        self.name = name
    }
    init(from network: DNetExecutorColor) {
        self.color = network.color
        self.id = network.id
        self.name = network.name
    }
}

public struct ExecutorCarMark: Codable {
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

public struct ExecutorCarModel: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorModel) {
        self.id = network.id
        self.name = network.name
    }
}

public struct ExecutorService: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorService) {
        self.id = network.id
        self.name = network.name
    }
}
public struct ExecutorPlan: Codable {
    let id: Int
    let name: ExecutorLocalizedText
    let description: ExecutorLocalizedText
    let cost: Int
    let limitTime: Int
    let planExpire: Int
    let deactivation: Bool
    let orderPayCost: Int
    let orderPayPresent: Int

    public init(id: Int, name: ExecutorLocalizedText, description: ExecutorLocalizedText, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
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
    init(from network: DNetExecutorPlan) {
        self.id = network.id
        self.name =  ExecutorLocalizedText(uz: network.name.uz, ru: network.name.ru)
        self.description =  ExecutorLocalizedText(uz: network.description.uz, ru: network.description.ru)
        self.cost = network.cost
        self.limitTime = network.limitTime
        self.planExpire = network.planExpire
        self.deactivation = network.deactivation
        self.orderPayCost = network.orderPayCost
        self.orderPayPresent = network.orderPayPresent
        
    }
    
}

public struct ExecutorLocalizedText: Codable {
    public let uz: String
    public let ru: String
    
    public init(uz: String, ru: String) {
        self.uz = uz
        self.ru = ru
    }
    init(from network: DNetExecutorLocalizedText) {
        self.uz = network.uz
        self.ru = network.ru
    }
}
