//
//  DriverOTPResponseValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import SwiftUI
import Core
import Foundation

public struct DNetResDriverInformationResponse: DNetResBody {
    public let expiresIn: Int
    public let executor: ExecutorInfo
    
    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case executor
    }
    
    public struct ExecutorInfo: Codable {
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
        public let brand: ExecutorBrand
        public let addressId: Int
        public let createdAt: String
        public let tariffCategoryId: Int
        public let register: String
        public let activeness: Int
        public let rating: String
        public let fcmToken: String
        public let fotocontrol: DNetResExecutorFotocontrol
        public let transport: DNetResExecutorTransport
        public let plan: DNetResExecutorPlan
        
        enum CodingKeys: String, CodingKey {
            case id
            case givenNames = "given_names"
            case surName = "sur_name"
            case fatherName = "father_name"
            case balance
            case phone
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
    
}
