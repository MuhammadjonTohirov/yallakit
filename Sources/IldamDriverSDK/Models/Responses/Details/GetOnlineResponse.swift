//
//  GetOnlineResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

public struct GetOnlineResponse: DNetResBody {
    public let online: Bool
    
    public init(online: Bool) {
        self.online = online
    }
    
    init(network: DNetGetOnlineResponse) {
        self.online = network.online
    }
}
