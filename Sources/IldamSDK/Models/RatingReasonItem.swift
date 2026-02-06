//
//  RatingReasonItem.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation

public struct RatingReasonItem: Sendable, Identifiable {
    public let id: Int
    public let name: String
    public let rating: Int
    public let icon: String?
    
    public init(id: Int, name: String, rating: Int, icon: String?) {
        self.id = id
        self.name = name
        self.rating = rating
        self.icon = icon
    }
}
