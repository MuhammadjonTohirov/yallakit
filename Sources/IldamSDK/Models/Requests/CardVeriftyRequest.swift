//
//  CardVeriftyRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/CardVerifyRequest.swift
import Foundation

public struct CardVerifyRequest {
    public let key: String
    public let code: String
    
    public init(key: String, code: String) {
        self.key = key
        self.code = code
    }
}
