//
//  OTPResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import Core

public struct DriverOTPResponse {
    public let timeRemainingSeconds: Int
    public let resultMessage: String?
    
    init(networkResponse: DNetResSendOTP) {
        self.timeRemainingSeconds = networkResponse.time
        self.resultMessage = networkResponse.resultMessage
    }
    
    public init(timeRemainingSeconds: Int, resultMessage: String? = nil) {
        self.timeRemainingSeconds = timeRemainingSeconds
        self.resultMessage = resultMessage
    }
}
