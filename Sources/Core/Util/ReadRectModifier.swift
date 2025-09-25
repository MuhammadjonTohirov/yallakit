//
//  File.swift
//  RoyalKit
//
//  Created by Muhammadjon Tohirov on 24/09/25.
//

import Foundation
import SwiftUI

struct ReadRectModifier: ViewModifier {
    let onRectChange: (CGRect) -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            let rect = geometry.frame(in: .global)
                            onRectChange(rect)
                        }
                        .onChange(of: geometry.frame(in: .global)) { newValue in
                            onRectChange(newValue)
                        }
                }
            )
    }
}

private struct RectPreferenceKey: @MainActor PreferenceKey {
    @MainActor static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
