//
//  SendFotoControlBody.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

struct SendFotoControlBody: Encodable {
     let items: [SendFotoControlBodyItem]

     init(items: [SendFotoControlBodyItem]) {
        self.items = items
    }
    
     enum CodingKeys: String, CodingKey {
        case items
    }
}

public struct SendFotoControlBodyItem: Encodable {
     let type: String
     let photoControlId: Int
     let file: String
    
     init(type: String, photoControlId: Int, file: String) {
        self.type = type
        self.photoControlId = photoControlId
        self.file = file
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case photoControlId = "photo_control_id"
        case file
    }
}
