//
//  OTPResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// OTPResponse.swift
import Foundation

public struct OTPResponse {
    public let timeRemainingSeconds: Int
    public let resultMessage: String?
    
    init(networkResponse: NetResSendOTP) {
        self.timeRemainingSeconds = networkResponse.time
        self.resultMessage = networkResponse.resultMessage
    }
    
    public init(timeRemainingSeconds: Int, resultMessage: String? = nil) {
        self.timeRemainingSeconds = timeRemainingSeconds
        self.resultMessage = resultMessage
    }
}
