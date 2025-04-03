//
//  NetReqValidate.swift
//  Ildam
//
//  Created by applebro on 07/12/23.
//

import Foundation

//{
//    "phone": "998916675985",
//    "code": 96636
//}

struct NetReqValidate: Codable {
    let phone: String
    let code: Int
}
