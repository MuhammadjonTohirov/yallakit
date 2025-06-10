//
//  ExecutorMeResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

public struct ExecutorMeInfo: DNetResBody {
    
    public var id: Int?
    public var phone: String?
    public var photo: String?
    public var givenNames: String?
    public var surName: String?
    public var fatherName: String?
    public var birthday: String?
    public var rating: Int?
    public var online: Bool?
    public var status: String?
    public var level: Int?
    public var register: String?
    public var balance: Double?
    public var block: Bool?
    public var blockNote: String?
    public var blockExpiry: String?
    public var condition: Bool?
    public var createdAt: String?
    public var addressId: Int?
    public var activeness: Int?
    public var priareted: Int?
    public var appVer: String?
    public var appVersions: String?
    public var brand: ExecutorBrand?
    public var fotocontrol: ExecutorFotoControl?
    public var transport: ExecutorTransport?
    public var executorServices: [ExecutorService]?
    public var plan: ExecutorPlan?
    
    public init(
        id: Int,
        phone: String,
        photo: String,
        givenNames: String,
        surName: String,
        fatherName: String,
        birthday: String,
        rating: Int,
        online: Bool,
        status: String,
        level: Int,
        register: String,
        balance: Double,
        block: Bool,
        blockNote: String?,
        blockExpiry: String?,
        condition: Bool,
        createdAt: String,
        addressId: Int,
        activeness: Int,
        priareted: Int,
        appVer: String,
        appVersions: String,
        brand: ExecutorBrand,
        fotocontrol: ExecutorFotoControl,
        transport: ExecutorTransport,
        executorServices: [ExecutorService],
        plan: ExecutorPlan?
    ) {
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
    
    init(from network: DNetExecutorMeResponse?) {
        self.id = network?.id
        self.phone = network?.phone
        self.photo = network?.photo
        self.givenNames = network?.givenNames
        self.surName = network?.surName
        self.fatherName = network?.fatherName
        self.birthday = network?.birthday
        self.rating = network?.rating
        self.online = network?.online
        self.status = network?.status
        self.level = network?.level
        self.register = network?.register
        self.balance = network?.balance
        self.block = network?.block
        self.blockNote = network?.blockNote ?? ""
        self.blockExpiry = network?.blockExpiry ?? ""
        self.condition = network?.condition
        self.createdAt = network?.createdAt
        self.addressId = network?.addressId
        self.activeness = network?.activeness
        self.priareted = network?.priareted
        self.appVer = network?.appVer
        self.appVersions = network?.appVersions
        self.brand = network?.brand.map { ExecutorBrand(from: $0) }
        self.fotocontrol = network?.fotocontrol.map { ExecutorFotoControl(from: $0) }
        self.transport = network?.transport.map { ExecutorTransport(from: $0) }
        self.executorServices = network?.executorService?.map { ExecutorService(from: $0) }
        self.plan = network?.plan.map { ExecutorPlan(from: $0) }
    }
}

public struct ExecutorBrand: Codable, Sendable {
    public var id: Int
    public var name: String
    public var slug: String
    
    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    init(from network: DNetExecutorBrand?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
        self.slug = network?.slug ?? ""
    }
}

public struct ExecutorFotoControl: Codable, Sendable {
    public var fotocontrolStatus: Bool?
    public var moderatorStatus: String?
    
    public init(fotocontrolStatus: Bool, moderatorStatus: String?) {
        self.fotocontrolStatus = fotocontrolStatus
        self.moderatorStatus = moderatorStatus
    }
    
    init(from network: DNetExecutorFotoControl?) {
        self.fotocontrolStatus = network?.fotocontrolStatus ?? false
        self.moderatorStatus = network?.moderatorStatus
    }
}

public struct ExecutorTransport: Codable, Sendable {
    public var callsign: String
    public var color: ExecutorCarColor
    public var mark: ExecutorCarMark
    public var model: ExecutorCarModel
    public var stateNumber: String
    
    public init(callsign: String, color: ExecutorCarColor, mark: ExecutorCarMark, model: ExecutorCarModel, stateNumber: String) {
        self.callsign = callsign
        self.color = color
        self.mark = mark
        self.model = model
        self.stateNumber = stateNumber
    }
    
    init(from network: DNetExecutorTransport?) {
        self.callsign = network?.callsign ?? ""
        self.color = ExecutorCarColor(from: network?.color)
        self.mark = ExecutorCarMark(from: network?.mark)
        self.model = ExecutorCarModel(from: network?.model)
        self.stateNumber = network?.stateNumber ?? ""
    }
}

public struct ExecutorCarColor: Codable, Sendable {
    public var color: String
    public var id: Int
    public var name: String
    
    public init(color: String, id: Int, name: String) {
        self.color = color
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorColor?) {
        self.color = network?.color ?? ""
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct ExecutorCarMark: Codable, Sendable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorMark?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct ExecutorCarModel: Codable, Sendable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorModel?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct ExecutorService: Codable, Sendable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetExecutorService?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct ExecutorPlan: Codable, Sendable {
    public var id: Int
    public var name: String
    public var description: String
    public var cost: Int
    public var limitTime: Int
    public var planExpire: Int
    public var deactivation: Bool
    public var orderPayCost: Int
    public var orderPayPresent: Int
    
    public init(
        id: Int,
        name: String,
        description: String,
        cost: Int,
        limitTime: Int,
        planExpire: Int,
        deactivation: Bool,
        orderPayCost: Int,
        orderPayPresent: Int
    ) {
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
    
    init(from network: DNetExecutorPlan?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
        self.description = network?.description ?? "" 
        self.cost = network?.cost ?? 0
        self.limitTime = network?.limitTime ?? 0
        self.planExpire = network?.planExpire ?? 0
        self.deactivation = network?.deactivation ?? false
        self.orderPayCost = network?.orderPayCost ?? 0
        self.orderPayPresent = network?.orderPayPresent ?? 0
    }

}


