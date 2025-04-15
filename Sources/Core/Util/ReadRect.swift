//
//  ReadRect.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 08/04/25.
//

import Foundation
import SwiftUI

// Read Size Modifier

struct RectModifer: ViewModifier {
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.frame(in: .global))
                        .onChange(of: proxy.frame(in: .global), perform: { value in
                            if value == rect {
                                return
                            }
                            rect = value
                        })
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
                if rect == preferences {
                    return
                }
                rect = preferences
            }
    }
}

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
        self.modifier(RectModifer(rect: rect))
    }
}

