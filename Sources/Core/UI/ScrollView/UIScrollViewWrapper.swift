//
//  UIScrollViewWrapper.swift
//  Core
//
//  Created by applebro on 11/04/25.
//

import Foundation
import SwiftUI
import UIKit

class ScrollViewCoordinator: NSObject, UIScrollViewDelegate {
    var offsetChanged: (CGPoint) -> Void
    
    init(offsetChanged: @escaping (CGPoint) -> Void) {
        self.offsetChanged = offsetChanged
        super.init()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offsetChanged(scrollView.contentOffset)
    }
}

struct UIScrollViewWrapper<Content: View>: UIViewRepresentable {
    @Binding var contentOffset: CGPoint
    var content: Content
    var showsIndicators: Bool
    var onOffsetChange: ((CGPoint) -> Void)?
    var axesConstraints: Axes // Control which axes are constrained
    
    init(contentOffset: Binding<CGPoint>,
         showsIndicators: Bool = true,
         axesConstraints: Axes = .vertical,
         onOffsetChange: ((CGPoint) -> Void)? = nil,
         @ViewBuilder content: () -> Content) {
        self._contentOffset = contentOffset
        self.showsIndicators = showsIndicators
        self.onOffsetChange = onOffsetChange
        self.axesConstraints = axesConstraints
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = showsIndicators
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.alwaysBounceVertical = axesConstraints.contains(.vertical)
        scrollView.alwaysBounceHorizontal = axesConstraints.contains(.horizontal)
        
        // Create host controller for SwiftUI content
        let hostController = UIHostingController(rootView: content)
        hostController.view.translatesAutoresizingMaskIntoConstraints = false
        hostController.view.backgroundColor = .clear
        
        // Add the hosting controller view to scroll view
        scrollView.addSubview(hostController.view)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            hostController.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostController.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostController.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            hostController.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        // Apply width constraint based on axesConstraints
        if !axesConstraints.contains(.horizontal) {
            NSLayoutConstraint.activate([
                hostController.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
            ])
        }
        
        // Apply height constraint based on axesConstraints
        if !axesConstraints.contains(.vertical) {
            NSLayoutConstraint.activate([
                hostController.view.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
            ])
        }
        
        return scrollView
    }
    
    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        // Get the hosting controller
        if let hostController = scrollView.subviews.first?.next as? UIHostingController<Content> {
            // Update the content
            hostController.rootView = content
            
            // Make sure content size is updated
            hostController.view.setNeedsLayout()
            hostController.view.layoutIfNeeded()
            
            // Explicitly calculate and set content size
            let fittingSize = hostController.view.sizeThatFits(
                CGSize(
                    width: axesConstraints.contains(.horizontal) ? CGFloat.greatestFiniteMagnitude : scrollView.frame.width,
                    height: axesConstraints.contains(.vertical) ? CGFloat.greatestFiniteMagnitude : scrollView.frame.height
                )
            )
            
            // Set content size with some safety checks
            scrollView.contentSize = CGSize(
                width: max(fittingSize.width, scrollView.frame.width),
                height: max(fittingSize.height, scrollView.frame.height)
            )
            
        }
        
        // Update scroll position if changed externally and it's a valid position
        if scrollView.contentOffset != contentOffset {
            let maxOffsetX = max(0, scrollView.contentSize.width - scrollView.bounds.width)
            let maxOffsetY = max(0, scrollView.contentSize.height - scrollView.bounds.height)
            let safeOffset = CGPoint(
                x: min(maxOffsetX, max(0, contentOffset.x)),
                y: min(maxOffsetY, max(0, contentOffset.y))
            )
            
            scrollView.setContentOffset(safeOffset, animated: true)
        }
    }
    
    func makeCoordinator() -> ScrollViewCoordinator {
        return ScrollViewCoordinator { offset in
            // Update binding
            self.contentOffset = offset
            
            // Call optional callback
            self.onOffsetChange?(offset)
        }
    }
    
}

// Define axes for scrolling
struct Axes: OptionSet {
    let rawValue: Int
    
    static let horizontal = Axes(rawValue: 1 << 0)
    static let vertical = Axes(rawValue: 1 << 1)
    
    static let both: Axes = [.horizontal, .vertical]
}

// Extension to make it easier to use
extension View {
    func trackScrollOffset(
        _ offset: Binding<CGPoint>,
        showsIndicators: Bool = true,
        axes: Axes = .vertical,
        onChange: ((CGPoint) -> Void)? = nil
    ) -> some View {
        UIScrollViewWrapper(
            contentOffset: offset,
            showsIndicators: showsIndicators,
            axesConstraints: axes,
            onOffsetChange: onChange
        ) {
            self
        }
    }
}

// Example usage
struct ScrollableListExample: View {
    @State private var scrollOffset: CGPoint = .zero
    
    var body: some View {
        VStack {
            Text("Current offset: \(Int(scrollOffset.y))")
                .padding()
            
            Button("Scroll to position 300") {
                // Set offset programmatically
                scrollOffset = CGPoint(x: 0, y: 300)
            }
            .padding()
            
            // Make sure to give this a specific frame height
            // otherwise it might not scroll
            UIScrollViewWrapper(contentOffset: $scrollOffset, axesConstraints: .vertical) {
                LazyVStack(spacing: 20) {
                    ForEach(0..<30) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ScrollableListExample()
}
