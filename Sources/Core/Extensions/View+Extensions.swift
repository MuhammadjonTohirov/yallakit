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


