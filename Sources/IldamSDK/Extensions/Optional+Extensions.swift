//
//  Optional+Extensions.swift
//  Ildam
//
//  Created by applebro on 04/02/24.
//

import Foundation

// for string
public extension Optional where Wrapped == String {
    var orEmpty: String {
        (self?.isEmpty ?? true) ? "" : self ?? ""
    }
}
