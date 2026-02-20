//
//  NetReqBeDriver.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation

struct NetReqBeDriver: Codable {
    let firstName: String
    let lastName: String?
    let fatherName: String?
    let phone: String
    let addressId: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "given_name"
        case lastName = "sur_name"
        case fatherName = "father_name"
        case phone
        case addressId = "address_id"
    }
    
    init(firstName: String, lastName: String?, fatherName: String? = "", phone: String, addressId: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.fatherName = fatherName
        self.phone = phone
        self.addressId = addressId
    }
}
