//
//  BecomeDriverRequest.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation

public struct BecomeDriverRequest: Sendable {
    public let firstName: String
    public let lastName: String?
    public let fatherName: String?
    public let phone: String
    public let addressId: Int

    public init(
        firstName: String,
        lastName: String?,
        fatherName: String? = "",
        phone: String,
        addressId: Int
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.fatherName = fatherName
        self.phone = phone
        self.addressId = addressId
    }
}

extension BecomeDriverRequest {
    func toNetworkRequest() -> NetReqBeDriver {
        NetReqBeDriver(
            firstName: firstName,
            lastName: lastName,
            fatherName: fatherName,
            phone: phone,
            addressId: addressId
        )
    }
}
