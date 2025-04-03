//
//  SyncFCMUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 28/01/25.
//

import Foundation
import NetworkLayer
import Core

public protocol SyncFCMUseCase {
    func sendFCMToken(token: String) async -> Bool
    
    @discardableResult
    func syncFCMtoken() async -> Bool
}

public struct SyncFCMUseCaseImpl: SyncFCMUseCase {
    struct Request: URLRequestProtocol {
        var token: String
        
        var url: URL {
            URL.baseAPICli.appending(path: "fcm-token")
        }

        var body: Data? {
            let dict: [String: String] = ["fcm_token": token]
            return dict.asData
        }

        var method: NetworkLayer.HTTPMethod { .post }

        func request() -> URLRequest {
            var request = URLRequest.new(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            return request
        }
    }
    
    public init() {
        
    }
    
    public func sendFCMToken(token: String) async -> Bool {
        let result: NetRes<String>? = await Network.send(request: Request(token: token))
        
        return result != nil && result?.error == nil
    }
    
    @discardableResult
    public func syncFCMtoken() async -> Bool {
        guard let token = UserSettings.shared.fcmToken else {
            debugPrint("FCM token not found")
            return false
        }
        
        return await sendFCMToken(token: token)
    }
}
