//
//  CheckLocation.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 20/10/25.
//

import SwiftUI

public struct CheckLocationResult: Codable {
    public let addressID, brandID: Int?
    public let isWorking: Bool?
    public let text: String?

    public init(addressID: Int?, brandID: Int?, isWorking: Bool?, text: String?) {
        self.addressID = addressID
        self.brandID = brandID
        self.isWorking = isWorking
        self.text = text
    }
    
    init?(from decoder: NetCheckLocationRes?) throws {
        guard let decoder = decoder else {return nil}
        
        self.addressID = decoder.addressID
        self.brandID = decoder.brandID
        self.isWorking = decoder.isWorking
        self.text = decoder.text
    }
}

