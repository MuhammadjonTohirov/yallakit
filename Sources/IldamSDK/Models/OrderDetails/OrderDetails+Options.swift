//
//  OrderDetails+Options.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public extension OrderDetails {
    struct OrderOption: Sendable, Identifiable, Hashable, Codable {
        public var id: Int?
        public var cost: Double?
        public var costType: String?
        public var name: String?
        
        public init(id: Int? = nil, cost: Double? = nil, costType: String? = nil, name: String? = nil) {
            self.id = id
            self.cost = cost
            self.costType = costType
            self.name = name
        }
        
        init?(res: NetResOrderOption?) {
            self.init(id: res?.id, cost: res?.cost, costType: res?.costType, name: res?.name)
        }
    }
}

public extension OrderDetails {
    struct OrderIntercity: Sendable, Codable {
        public let startHour: String?
        public let endHour: String?
        public let scheduleId: Int?
        public let totalPrice: Double?
        public let isBooked: Bool?
        public let seatLayouts: [SeatLayout]?
        public let isPostal: Bool?

        public struct SeatLayout: Sendable, Codable {
            public let slug: String?
            public let index: Int?
            public let seatLayoutId: Int?
            public let price: Double?
            
            public init(slug: String?, index: Int?, seatLayoutId: Int?, price: Double?) {
                self.slug = slug
                self.index = index
                self.seatLayoutId = seatLayoutId
                self.price = price
            }
            
            init?(res: NetResOrderIntercity.SeatLayout?) {
                self.init(
                    slug: res?.slug,
                    index: res?.index,
                    seatLayoutId: res?.seatLayoutId,
                    price: res?.price
                )
            }
        }
        
        public init(startHour: String?, endHour: String?, scheduleId: Int?, totalPrice: Double?, isBooked: Bool?, seatLayouts: [SeatLayout]?, isPostal: Bool?) {
            self.startHour = startHour
            self.endHour = endHour
            self.scheduleId = scheduleId
            self.totalPrice = totalPrice
            self.isBooked = isBooked
            self.seatLayouts = seatLayouts
            self.isPostal = isPostal
        }
        
        init?(res: NetResOrderIntercity?) {
            self.init(
                startHour: res?.startHour,
                endHour: res?.endHour,
                scheduleId: res?.scheduleId,
                totalPrice: res?.totalPrice,
                isBooked: res?.isBooked,
                seatLayouts: res?.seatLayouts?.compactMap {.init(res:$0)},
                isPostal: res?.isPostal
            )
        }
    }
}
