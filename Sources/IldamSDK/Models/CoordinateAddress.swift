//
//  CoordinateAddress.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation
import Core

extension CoordinateAddress {
    init?(with: NetResGetAddress?) {
        guard let with = with else {
            return nil
        }
        
        self.init(
            id: with.id,
            lat: with.lat,
            lng: with.lng,
            name: with.name,
            distance: with.distance,
            parent: with.parent.map({.init(id: $0.id, name: $0.name, lavel: $0.level)})
        )
    }
}
