//
//  MyAddressItem.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 27/03/25.
//


import Foundation
import Core

public class MyAddressItem: Identifiable {
    public var id: Int
    public var name: String
    public var address: String
    public var lat: Double
    public var lng: Double
    public var type: MyAddressType?
    public var enter: String?
    public var apartment: String?
    public var floor: String?
    public var comment: String?
    public var createdAt: Date?
    
    public init(id: Int, name: String, address: String, lat: Double, lng: Double, type: MyAddressType?, enter: String?, apartment: String?, floor: String?, comment: String?, createdAt: Date?) {
        self.name = name
        self.address = address
        self.lat = lat
        self.lng = lng
        self.type = type
        self.enter = enter
        self.apartment = apartment
        self.floor = floor
        self.comment = comment
        self.createdAt = createdAt
        self.id = id
    }
    
    public init(place: MyPlaceItem) {
        self.name = place.name
        self.address = place.address
        self.lat = place.lat
        self.lng = place.lng
        self.type = place.type
        self.enter = place.enter
        self.apartment = place.apartment
        self.floor = place.floor
        self.comment = place.comment
        self.createdAt = place.createdAt.asDate(format: Date.serverFormat)
        self.id = place.id
    }
}
