//
//  CardVerificaitonResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

public struct CardVerificaitonResponse: DNetResBody {
   public let id: String
    
    public init(id: String) {
        self.id = id
    }
    init(from network: DNetCardVerificationResponse) {
        self.id = network.id
    }
}
