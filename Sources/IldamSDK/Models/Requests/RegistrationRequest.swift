//
//  RegistrationRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public struct RegistrationRequest: Sendable {
    public let phone: String
    public let givenNames: String
    public let surname: String
    public let gender: Gender
    public let birthday: String?
    public let key: String
    
    public init(phone: String, givenNames: String, surname: String, gender: Gender, birthday: String? = nil, key: String) {
        self.phone = phone
        self.givenNames = givenNames
        self.surname = surname
        self.gender = gender
        self.birthday = birthday
        self.key = key
    }
    
    func toNetworkRequest() -> NetReqRegisterProfile {
        return NetReqRegisterProfile(
            phone: phone,
            givenNames: givenNames,
            surname: surname,
            gender: gender,
            birthday: birthday ?? "",
            key: key
        )
    }
}
