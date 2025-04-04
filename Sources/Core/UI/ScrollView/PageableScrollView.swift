//
//  PageableScrollView.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 01/04/25.
//

import Foundation
import SwiftUI

/// A custom scroll view that notifies when user scrolls near the bottom,
/// useful for implementing pagination.
public struct PageableScrollView<Content: View>: View {
    // MARK: - Properties
    
    /// The content to display inside the scroll view
    let content: Content
    
    /// The threshold to trigger loading (expressed as points from bottom)
    let bottomThreshold: CGFloat
    
    /// Callback that fires when user scrolls near the bottom
    let onReachedBottom: () -> Void
    
    /// Track if we already triggered the bottom reached callback
    @State private var hasReachedBottom = false
    
    /// Scroll position tracker
    @State private var scrollOffset: CGFloat = 0
    
    /// Content size tracker
    @State private var contentHeight: CGFloat = 0
    
    /// Scroll view height tracker
    @State private var scrollViewHeight: CGFloat = 0
    
    // MARK: - Initialization
    
    /// Initialize a new pageable scroll view
    /// - Parameters:
    ///   - bottomThreshold: Distance from bottom to trigger the callback (default: 200pt)
    ///   - onReachedBottom: Callback when user scrolls near bottom
    ///   - content: Content view builder
    public init(
        bottomThreshold: CGFloat = 200,
        onReachedBottom: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.bottomThreshold = bottomThreshold
        self.onReachedBottom = onReachedBottom
    }
    
    // MARK: - Body
    
    public var body: some View {
        ScrollView {
            LazyVStack {
                // Main content
                content
                
                // Spacer at the bottom that triggers pagination
                Color.clear
                    .frame(height: 1)
                    .onAppear {
                        // This will trigger when the bottom spacer becomes visible
                        if !hasReachedBottom {
                            hasReachedBottom = true
                            onReachedBottom()
                        }
                    }
            }
            // Track content size changes
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            contentHeight = geometry.size.height
                        }
                        .onChange(of: geometry.size.height) { newHeight in
                            contentHeight = newHeight
                            checkIfBottomReached()
                        }
                }
            )
        }
        // Track scroll view size and scroll position
        .overlay(
            GeometryReader { geometry in
                let offset = geometry.frame(in: .global).minY
                Color.clear
                    .preference(key: ScrollOffsetKey.self, value: offset)
                    .onAppear {
                        scrollViewHeight = geometry.size.height
                    }
                    .onChange(of: geometry.size.height) { newHeight in
                        scrollViewHeight = newHeight
                        checkIfBottomReached()
                    }
            }
        )
        .onPreferenceChange(ScrollOffsetKey.self) { offset in
            // Only process significant changes to reduce updates
            if abs(scrollOffset - offset) > 10 {
                scrollOffset = offset
                checkIfBottomReached()
            }
        }
        // Reset the bottom reached flag when the view disappears
        .onDisappear {
            hasReachedBottom = false
        }
    }
    
    // MARK: - Helper Methods
    
    /// Check if user has scrolled near the bottom and trigger callback if needed
    private func checkIfBottomReached() {
        // If content is shorter than scroll view, we don't need pagination
        guard contentHeight > scrollViewHeight else {
            return
        }
        
        // Calculate distance from bottom
        let distanceFromBottom = contentHeight - scrollViewHeight + scrollOffset
        
        // If we're near the bottom and haven't triggered the callback yet
        if distanceFromBottom < bottomThreshold && !hasReachedBottom {
            hasReachedBottom = true
            onReachedBottom()
        }
        
        // Reset the flag if user scrolls back up
        if distanceFromBottom > bottomThreshold + 100 && hasReachedBottom {
            hasReachedBottom = false
        }
    }
}

// MARK: - Preference Key for Scroll Offset
struct ScrollOffsetKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
