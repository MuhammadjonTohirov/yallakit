//
//  AddMyPlaceRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/AddPlaceRequest.swift
import Foundation
import Core

public struct AddPlaceRequest {
    public let name: String
    public let address: String
    public let lat: Double
    public let lng: Double
    public let type: MyAddressType
    public let enter: String?
    public let apartment: String?
    public let floor: String?
    public let comment: String?
    
    public init(
        name: String,
        address: String,
        lat: Double,
        lng: Double,
        type: MyAddressType,
        enter: String? = nil,
        apartment: String? = nil,
        floor: String? = nil,
        comment: String? = nil
    ) {
        self.name = name
        self.address = address
        self.lat = lat
        self.lng = lng
        self.type = type
        self.enter = enter
        self.apartment = apartment
        self.floor = floor
        self.comment = comment
    }
    
    func toNetworkRequest() -> NetReqAddAddress {
        return NetReqAddAddress(
            name: name,
            address: address,
            lat: lat,
            lng: lng,
            type: type,
            enter: enter,
            apartment: apartment,
            floor: floor,
            comment: comment
        )
    }
}
