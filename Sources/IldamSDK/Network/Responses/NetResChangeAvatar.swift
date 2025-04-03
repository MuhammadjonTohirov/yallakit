//
//  NetResChangeAvatar.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 17/12/24.
//

import Foundation

struct NetResChangeAvatar: NetResBody {
    let path: String
    let image: String
    
    var fullUrl: String {
        path + image
    }
}

