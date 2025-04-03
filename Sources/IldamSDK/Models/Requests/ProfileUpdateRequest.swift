//
//  ProfileUpdateRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// ProfileUpdateRequest.swift
import Foundation
import Core

public struct ProfileUpdateRequest {
    public let givenNames: String?
    public let surname: String?
    public let birthday: String?
    public let gender: Gender?
    public let image: String?
    
    public init(givenNames: String? = nil, surname: String? = nil, birthday: String? = nil, gender: Gender? = nil, image: String? = nil) {
        self.givenNames = givenNames
        self.surname = surname
        self.birthday = birthday
        self.gender = gender
        self.image = image
    }
    
    func toNetworkRequest() -> NetReqUpdateProfile {
        return NetReqUpdateProfile(
            givenNames: givenNames,
            surName: surname,
            birthday: birthday,
            gender: gender,
            image: image
        )
    }
}
