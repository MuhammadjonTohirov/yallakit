//
//  DNetResValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//
import Foundation

public struct DriverOTPValidateResponse {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int

    public init(
        accessToken: String,
        tokenType: String,
        expiresIn: Int
    ) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }

    init?(from network: DNetResValidate?) {
        guard let network else { return nil }

        self.accessToken = network.accessToken ?? ""
        self.tokenType = network.tokenType ?? ""
        self.expiresIn = network.expiresIn ?? 0
        
    }
}
