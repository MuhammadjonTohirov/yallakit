//
//  Brand.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

public struct Brand {
    public let id: Int
    public let name: String
    public let slug: String

    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }

    init(from network: DNetOrderBrandsResponse) {
        self.id = network.id
        self.name = network.name
        self.slug = network.slug
    }
}
