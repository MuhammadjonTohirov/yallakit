//
//  Comperable+.swift
//  TestApp
//
//  Created by Muhammadjon Tohirov on 07/07/25.
//

import Foundation

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
