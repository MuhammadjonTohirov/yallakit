//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/02/26.
//

import Foundation

public struct BrandServiceItem: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let photo: String?
    
    init(networkResponse: NetResBrandServiceItem) {
        self.id = networkResponse.id ?? 0
        self.name = networkResponse.name ?? ""
        self.photo = networkResponse.photo
    }
}
