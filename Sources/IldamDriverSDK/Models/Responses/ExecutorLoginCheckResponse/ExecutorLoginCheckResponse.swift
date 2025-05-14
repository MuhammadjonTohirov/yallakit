//
//  DNetExecutorLoginCheckResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import Foundation

public struct ExecutorLoginCheckResponse: DNetResBody {
    public let login: Bool
    public let register: Bool
    
    public init(login: Bool, register: Bool) {
        self.login = login
        self.register = register
    }
    init(from network: DNetExecutorLoginCheckResponse) {
        self.login = network.login
        self.register = network.register
    }
    
}
