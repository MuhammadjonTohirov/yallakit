//
//  DNetRegisterResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//
import Foundation

struct DNetDriverRegisterBody: Encodable {
    let phone: String
    let givenNames: String
    let surName: String
    let addressId: Int
    let brandId: Int
    let modelId: Int
    let markId: Int
    let colorId: Int
    let driverLicenseCategories: [String]
    let stateNumber: String
    let carMakeDate: Int
    let driverLicense: String
    let driverLicenseDate: String
    let driverLicenseDateExpiry: String
    let driverGraduate: String
    let birthday: String
    let gender: String
    let fatherName: String

    enum CodingKeys: String, CodingKey {
        case phone, surName = "sur_name", givenNames = "given_names",
             addressId = "address_id", brandId = "brand_id", modelId = "model_id", markId = "mark_id",
             colorId = "color_id", driverLicenseCategories = "driver_license_categories",
             stateNumber = "state_number", carMakeDate = "car_make_date",
             driverLicense = "driver_license", driverLicenseDate = "driver_license_date",
             driverLicenseDateExpiry = "driver_license_date_expiry",
             driverGraduate = "driver_graduate", birthday, gender,
             fatherName = "father_name"
    }
}

struct DNetDriverRegisterResponse: DNetResBody {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let executor: DNetCreateExecutorResponse

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case executor
    }
}
struct DNetCreateExecutorResponse: Codable {
    let id: Int
    let givenNames: String
    let surName: String
    let fatherName: String
    let phone: String
    let balance: Double?
    let blockNote: String?
    let level: Int
    let blockExpiry: String?
    let status: String
    let condition: Bool?
    let online: Bool?
    let block: Bool?
    let birthday: String
    let brandId: Int
    let photo: String
    let serviceIds: [Int]
    let addressBrand: String?
    let brand: DNetCreateNewExecutorMeBrand
    let addressId: Int
    let createdAt: String
    let tariffCategoryId: Int
    let register: Bool
    let activeness: Int
    let rating: Int
    let fcmToken: String?
    let fotocontrol: DNetCreateNewExecutorFotocontrol
    let plan: DNetCreateNewExecutorPlan?

    enum CodingKeys: String, CodingKey {
        case id
        case givenNames = "given_names"
        case surName = "sur_name"
        case fatherName = "father_name"
        case phone
        case balance
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
        case plan
    }
}

struct DNetCreateNewExecutorMeBrand: Codable {
    let id: Int
    let name: String
    let slug: String
}

struct DNetCreateNewExecutorFotocontrol: Codable {
    let fotocontrolStatus: Bool
    let moderatorStatus: String?

    enum CodingKeys: String, CodingKey {
        case fotocontrolStatus = "fotocontrol_status"
        case moderatorStatus = "moderator_status"
    }
}

struct DNetCreateNewExecutorPlan: Codable {
    let id: Int
    let name: DNetCreateExecutorLocalizedText
    let description: DNetCreateExecutorLocalizedText
    let cost: Int
    let limitTime: Int
    let planExpire: Int
    let deactivation: Bool
    let orderPayCost: Int
    let orderPayPresent: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case cost
        case limitTime = "limit_time"
        case planExpire = "plan_expire"
        case deactivation
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
}

struct DNetCreateExecutorLocalizedText: Codable {
    let uz: String
    let ru: String
}
