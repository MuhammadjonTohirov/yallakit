//
//  DNetResValidate.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//
import Foundation

public struct DriverOTPResponceValidateResponse {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let executor: DriverExecutor

    init(networkResponse: DNetResValidate) {
        self.accessToken = networkResponse.accessToken
        self.tokenType   = networkResponse.tokenType
        self.expiresIn   = networkResponse.expiresIn
        self.executor    = networkResponse.executor
    }

    public init(
        accessToken: String,
        tokenType: String,
        expiresIn: Int,
        executor: DriverExecutor
    ) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.executor = executor
    }
}
