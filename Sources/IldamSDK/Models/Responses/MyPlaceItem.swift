//
//  MyPlaceItem.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/MyPlaceItem.swift
import Foundation
import Core

public struct MyPlaceItem {
    public let id: Int
    public let name: String
    public let address: String
    public let lat: Double
    public let lng: Double
    public let type: MyAddressType?
    public let enter: String?
    public let apartment: String?
    public let floor: String?
    public let comment: String?
    public let createdAt: String
    
    public init(
        id: Int,
        name: String,
        address: String,
        lat: Double,
        lng: Double,
        type: MyAddressType?,
        enter: String?,
        apartment: String?,
        floor: String?,
        comment: String?,
        createdAt: String
    ) {
        self.id = id
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
    }
    
    init(networkResponse: NetResMyAddressItem) {
        self.id = networkResponse.id
        self.name = networkResponse.name
        self.address = networkResponse.address
        self.lat = networkResponse.coords.lat
        self.lng = networkResponse.coords.lng
        self.type = networkResponse.type
        self.enter = networkResponse.enter
        self.apartment = networkResponse.apartment
        self.floor = networkResponse.floor
        self.comment = networkResponse.comment
        self.createdAt = networkResponse.createdAt
    }
}
