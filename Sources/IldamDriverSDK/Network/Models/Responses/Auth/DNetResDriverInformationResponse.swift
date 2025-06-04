//
//  DriverOTPResponseValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import SwiftUI
import Core
import Foundation

struct DNetResDriverInformationResponse: DNetResBody {
     let expiresIn: Int?
     let executor: ExecutorInfo?
    
    enum CodingKeys: String, CodingKey {
        case expiresIn = "expires_in"
        case executor
    }
    
    struct ExecutorInfo: Codable {
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
