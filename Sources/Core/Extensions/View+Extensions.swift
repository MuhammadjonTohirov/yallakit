//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 16/04/25.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func visibility(_ visibile: Bool) -> some View {
        if !visibile {
            EmptyView()
                .frame(height: 0)
        } else {
            self
        }
    }
}

public func withAnimation<Result>(
    animation: Animation? = .default,
    body: () throws -> Result,
    completion: @escaping (() -> Void) = {}
) rethrows -> Result {
    if #available(iOS 17.0, *) {
        return try withAnimation(animation, body, completion: completion)
    } else {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: completion)
        return try withAnimation(animation, body)
    }
}
