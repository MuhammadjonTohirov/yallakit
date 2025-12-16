//
//  ReadSizeModifier.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 16/12/25.
//

import Foundation
import SwiftUI

// MARK: - Size Preference Key
public struct SizePreferenceKey: @MainActor PreferenceKey {
    public typealias Value = CGSize
    
    @MainActor
    public static var defaultValue: CGSize = .zero
    
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Read Size Modifier
public struct ReadSizeModifier: ViewModifier {
    private let onSizeChange: (CGSize) -> Void
    
    public init(onSizeChange: @escaping (CGSize) -> Void) {
        self.onSizeChange = onSizeChange
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: SizePreferenceKey.self,
                            value: geometry.size
                        )
                        .onPreferenceChange(SizePreferenceKey.self) { size in
                            onSizeChange(size)
                        }
                }
            )
    }
}

// MARK: - View Extensions
public extension View {
    /// Attaches a modifier that reads the size of the view and reports changes
    /// - Parameter size: A binding to receive the size updates
    /// - Returns: A view with the size reading modifier applied
    func readSize(size: Binding<CGSize>) -> some View {
        self.modifier(ReadSizeModifier(onSizeChange: { newSize in
            size.wrappedValue = newSize
        }))
    }
    
    /// Attaches a modifier that reads the size of the view and reports changes
    /// - Parameter onSizeChange: A closure to execute when the size changes
    /// - Returns: A view with the size reading modifier applied
    func readSize(onSizeChange: @escaping (CGSize) -> Void) -> some View {
        self.modifier(ReadSizeModifier(onSizeChange: onSizeChange))
    }
}
