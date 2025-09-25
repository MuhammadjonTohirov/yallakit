//
//  ReadRect.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 08/04/25.
//

import Foundation
import SwiftUI

//SizePreferenceKey

public struct SizePreferenceKey: @preconcurrency PreferenceKey {
    public typealias Value = CGRect
    
    @MainActor
    public static var defaultValue: Value = .zero
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

public extension View {
    func readRect(rect: Binding<CGRect>) -> some View {
        self.modifier(ReadRectModifier(onRectChange: { _rect in
            rect.wrappedValue = _rect
        }))
    }
    
    func readRect(onRectChange: @escaping (CGRect) -> Void) -> some View {
        self.modifier(ReadRectModifier(onRectChange: onRectChange))
    }
}

