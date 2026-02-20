//
//  OrderDetails+Tariff.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public extension OrderDetails {
    struct OrderTariff: Sendable, Codable {
        public let id: Int?
        public let name: String?
        
        public init(id: Int?, name: String?) {
            self.id = id
            self.name = name
        }
        
        init?(res: NetResOrderTariff?) {
            self.id = res?.id
            self.name = res?.name
        }
    }
}
