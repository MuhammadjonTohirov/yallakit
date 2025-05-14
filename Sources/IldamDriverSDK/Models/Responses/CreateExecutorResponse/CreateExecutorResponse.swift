//
//  CreateExecutorResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import Foundation

public struct CreateExecutorResponse {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let executor: ExecutorProfile
    
    public init(accessToken: String, tokenType: String, expiresIn: Int, executor: ExecutorProfile) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.executor = executor
    }
    
    init(from network: DNetDriverRegisterResponse) {
        self.accessToken = network.accessToken
        self.tokenType = network.tokenType
        self.expiresIn = network.expiresIn
        self.executor = ExecutorProfile(from: network.executor)
    }
}


public struct ExecutorProfile {
    public let id: Int
    public let givenNames: String
    public let surName: String
    public let fatherName: String
    public let phone: String
    public let balance: Double
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
    public let brand: NewExecutorBrand
    public let addressId: Int
    public let createdAt: String
    public let tariffCategoryId: Int
    public let register: Bool
    public let activeness: Int
    public let rating: Int
    public let fcmToken: String
    public let fotocontrol: NewExecutorFotoControl
    public let plan: NewExecutorPlan?
    
    public init(id: Int, givenNames: String, surName: String, fatherName: String, phone: String, balance: Double, blockNote: String?, level: Int, blockExpiry: String?, status: String, condition: Bool, online: Bool, block: Bool, birthday: String, brandId: Int, photo: String, serviceIds: [Int], addressBrand: String?, brand: NewExecutorBrand, addressId: Int, createdAt: String, tariffCategoryId: Int, register: Bool, activeness: Int, rating: Int, fcmToken: String, fotocontrol: NewExecutorFotoControl, plan: NewExecutorPlan?) {
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
        self.plan = plan
    }
    
    init(from network: DNetCreateExecutorResponse) {
        self.id = network.id
        self.givenNames = network.givenNames
        self.surName = network.surName
        self.fatherName = network.fatherName
        self.balance = network.balance ?? 0
        self.phone = network.phone
        self.blockNote = network.blockNote
        self.level = network.level
        self.blockExpiry = network.blockExpiry
        self.status = network.status
        self.condition = network.condition ?? false
        self.online = network.online ?? false
        self.block = network.block ?? false
        self.birthday = network.birthday
        self.brandId = network.brandId
        self.photo = network.photo
        self.serviceIds = network.serviceIds
        self.addressBrand = network.addressBrand
        self.brand = NewExecutorBrand(from: network.brand)
        self.addressId = network.addressId
        self.createdAt = network.createdAt
        self.tariffCategoryId = network.tariffCategoryId
        self.register = network.register
        self.activeness = network.activeness
        self.rating = network.rating
        self.fcmToken = network.fcmToken ?? ""
        self.fotocontrol = NewExecutorFotoControl(from: DNetExecutorFotoControl(
            fotocontrolStatus: network.fotocontrol.fotocontrolStatus,
            moderatorStatus: network.fotocontrol.moderatorStatus
        ))
        self.plan = network.plan.map { NewExecutorPlan(from: $0) }
    }
    
    public struct NewExecutorBrand: Codable {
        public let id: Int
        public let name: String
        public let slug: String
        
        public init(id: Int, name: String, slug: String) {
            self.id = id
            self.name = name
            self.slug = slug
        }
        
        init(from network: DNetCreateNewExecutorMeBrand) {
            self.id = network.id
            self.name = network.name
            self.slug = network.slug
        }
    }
    
    public struct NewExecutorFotoControl: Codable {
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
    
    public struct NewExecutorPlan: Codable {
        let id: Int
        let name: NewExecutorLocalizedText
        let description: NewExecutorLocalizedText
        let cost: Int
        let limitTime: Int
        let planExpire: Int
        let deactivation: Bool
        let orderPayCost: Int
        let orderPayPresent: Int
        
        public init(id: Int, name: NewExecutorLocalizedText, description: NewExecutorLocalizedText, cost: Int, limitTime: Int, planExpire: Int, deactivation: Bool, orderPayCost: Int, orderPayPresent: Int) {
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
        init(from network: DNetCreateNewExecutorPlan) {
            self.id = network.id
            self.name =  NewExecutorLocalizedText(uz: network.name.uz, ru: network.name.ru)
            self.description =  NewExecutorLocalizedText(uz: network.description.uz, ru: network.description.ru)
            self.cost = network.cost
            self.limitTime = network.limitTime
            self.planExpire = network.planExpire
            self.deactivation = network.deactivation
            self.orderPayCost = network.orderPayCost
            self.orderPayPresent = network.orderPayPresent
            
        }
        
    }
    public struct NewExecutorLocalizedText: Codable {
        public let uz: String
        public let ru: String
        
        public init(uz: String, ru: String) {
            self.uz = uz
            self.ru = ru
        }
        init(from network: DNetCreateExecutorLocalizedText) {
            self.uz = network.uz
            self.ru = network.ru
        }
    }

    
}
