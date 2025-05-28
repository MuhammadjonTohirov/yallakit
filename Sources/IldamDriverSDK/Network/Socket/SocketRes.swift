//
//  File.swift
//  YallaKit
//
//  Created by applebro on 28/05/25.
//

import Foundation
import NetworkLayer

public struct SocketRes<T: NetResBody>: Codable {
    public let success: Bool
    public let result: T?
    public let message: String?
    public let code: Int?
    public var error: String?
    public let channel: String
    
    init (success: Bool, result: T?, message: String?, code: Int?, error: String?, channel: String = "") {
        self.success = success
        self.result = result
        self.message = message
        self.code = code
        self.error = error
        self.channel = channel
    }
    
    enum CodingKeys: CodingKey {
        case success
        case result
        case message
        case code
        case error
        case channel
        case status
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SocketRes<T>.CodingKeys> = try decoder.container(keyedBy: SocketRes<T>.CodingKeys.self)
        let success = try? container.decodeIfPresent(Bool.self, forKey: SocketRes<T>.CodingKeys.success)
        let status = try? container.decodeIfPresent(Bool.self, forKey: SocketRes<T>.CodingKeys.status)
        
        self.result = try? container.decodeIfPresent(T.self, forKey: SocketRes<T>.CodingKeys.result)
        self.message = try? container.decodeIfPresent(String.self, forKey: SocketRes<T>.CodingKeys.message)
        self.code = try? container.decodeIfPresent(Int.self, forKey: SocketRes<T>.CodingKeys.code)
        self.error = try? container.decodeIfPresent(String.self, forKey: SocketRes<T>.CodingKeys.error)
        
        if self.error == nil {
            self.error = (try? container.decodeIfPresent([String].self, forKey: SocketRes<T>.CodingKeys.error))?.joined(separator: " ")
        }
        
        self.success = success ?? status ?? false
        self.channel = (try? container.decodeIfPresent(String.self, forKey: SocketRes<T>.CodingKeys.channel)) ?? ""
    }
 
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SocketRes<T>.CodingKeys.self)
        try container.encode(self.success, forKey: .success)
        try container.encodeIfPresent(self.result, forKey: .result)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encodeIfPresent(self.code, forKey: .code)
        try container.encodeIfPresent(self.error, forKey: .error)
        try container.encodeIfPresent(self.channel, forKey: .channel)
    }
}
