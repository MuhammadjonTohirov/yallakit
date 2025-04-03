//
//  Bool+Extensions.swift
//  Core
//
//  Created by applebro on 11/09/24.
//

import Foundation

infix operator <- : AssignmentPrecedence

public extension Bool {
    @MainActor
    mutating func set(_ value: Bool) {
        self = value
    }
}
