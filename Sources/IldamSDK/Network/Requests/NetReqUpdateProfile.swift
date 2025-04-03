//
//  NetReqEditProfile.swift
//  Ildam
//
//  Created by applebro on 03/01/24.
//

import Foundation
import Core

struct NetReqUpdateProfile: Codable {
    // generate struct using json
    let givenNames: String?
    let surName: String?
    let birthday: String?
    let gender: Gender?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case givenNames = "given_names"
        case surName = "sur_name"
        case birthday
        case gender
        case image
    }
}
