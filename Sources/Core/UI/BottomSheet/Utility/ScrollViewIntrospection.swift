//
//  ScrollViewIntrospection.swift
//  TestApp
//
//  Created by Muhammadjon Tohirov on 08/07/25.
//

import Foundation
import SwiftUI
import UIKit

/// A view modifier that provides access to the underlying UIScrollView of a SwiftUI ScrollView
public struct ScrollViewIntrospectionModifier: ViewModifier {
    let onScrollViewFound: (UIScrollView) -> Void
    
    public func body(content: Content) -> some View {
        content
            .background(
                ScrollViewIntrospector(onScrollViewFound: onScrollViewFound)
            )
    }
}

/// Internal view that finds and extracts the UIScrollView
private struct ScrollViewIntrospector: UIViewRepresentable {
    let onScrollViewFound: (UIScrollView) -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            self.findScrollView(in: view)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            self.findScrollView(in: uiView)
        }
    }
    
    private func findScrollView(in view: UIView) {
        // Look for UIScrollView in the view hierarchy
        if let scrollView = findScrollViewInHierarchy(view: view) {
            onScrollViewFound(scrollView)
        }
    }
    
    private func findScrollViewInHierarchy(view: UIView) -> UIScrollView? {
        // First check if current view is a scroll view
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        
        // Check parent views
        var currentView: UIView? = view
        while let parentView = currentView?.superview {
            if let scrollView = parentView as? UIScrollView {
                return scrollView
            }
            currentView = parentView
        }
        
        // Check subviews recursively
        for subview in view.subviews {
            if let scrollView = findScrollViewInHierarchy(view: subview) {
                return scrollView
            }
        }
        
        return nil
    }
}

/// Extension to provide convenient access to UIScrollView introspection
public extension View {
    /// Provides access to the underlying UIScrollView of a SwiftUI ScrollView
    /// - Parameter onScrollViewFound: Callback that receives the UIScrollView when found
    func introspectScrollView(_ onScrollViewFound: @escaping (UIScrollView) -> Void) -> some View {
        self.modifier(ScrollViewIntrospectionModifier(onScrollViewFound: onScrollViewFound))
    }
}

/// Enhanced scroll view introspection with more specific targeting
public struct AdvancedScrollViewIntrospectionModifier: ViewModifier {
    let onScrollViewFound: (UIScrollView) -> Void
    let searchDepth: Int
    let searchDelay: TimeInterval
    
    public init(
        onScrollViewFound: @escaping (UIScrollView) -> Void,
        searchDepth: Int = 10,
        searchDelay: TimeInterval = 0.1
    ) {
        self.onScrollViewFound = onScrollViewFound
        self.searchDepth = searchDepth
        self.searchDelay = searchDelay
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                AdvancedScrollViewIntrospector(
                    onScrollViewFound: onScrollViewFound,
                    searchDepth: searchDepth,
                    searchDelay: searchDelay
                )
            )
    }
}

private struct AdvancedScrollViewIntrospector: UIViewRepresentable {
    let onScrollViewFound: (UIScrollView) -> Void
    let searchDepth: Int
    let searchDelay: TimeInterval
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false
        
        // Delayed search to ensure view hierarchy is established
        DispatchQueue.main.asyncAfter(deadline: .now() + searchDelay) {
            self.performAdvancedSearch(in: view)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + searchDelay) {
            self.performAdvancedSearch(in: uiView)
        }
    }
    
    private func performAdvancedSearch(in view: UIView) {
        if let scrollView = findScrollViewAdvanced(view: view, currentDepth: 0) {
            onScrollViewFound(scrollView)
        }
    }
    
    private func findScrollViewAdvanced(view: UIView, currentDepth: Int) -> UIScrollView? {
        guard currentDepth < searchDepth else { return nil }
        
        // Check current view
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        
        // Check parent hierarchy
        var currentView: UIView? = view
        var parentDepth = 0
        while let parentView = currentView?.superview, parentDepth < searchDepth {
            if let scrollView = parentView as? UIScrollView {
                return scrollView
            }
            currentView = parentView
            parentDepth += 1
        }
        
        // Check children hierarchy
        for subview in view.subviews {
            if let scrollView = findScrollViewAdvanced(view: subview, currentDepth: currentDepth + 1) {
                return scrollView
            }
        }
        
        return nil
    }
}

public extension View {
    /// Advanced UIScrollView introspection with customizable search parameters
    /// - Parameters:
    ///   - searchDepth: Maximum depth to search in view hierarchy
    ///   - searchDelay: Delay before starting search (to ensure view hierarchy is ready)
    ///   - onScrollViewFound: Callback that receives the UIScrollView when found
    func introspectScrollViewAdvanced(
        searchDepth: Int = 10,
        searchDelay: TimeInterval = 0.1,
        _ onScrollViewFound: @escaping (UIScrollView) -> Void
    ) -> some View {
        self.modifier(
            AdvancedScrollViewIntrospectionModifier(
                onScrollViewFound: onScrollViewFound,
                searchDepth: searchDepth,
                searchDelay: searchDelay
            )
        )
    }
}