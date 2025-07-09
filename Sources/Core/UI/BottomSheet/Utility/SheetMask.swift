//
//  File.swift
//  RoyalKit
//
//  Created by Muhammadjon Tohirov on 09/07/25.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func bottomMaskForSheet(_ height: CGFloat = 50) -> some View {
        self
            .background(SheetRootViewFinder(height: height))
    }
}

fileprivate struct SheetRootViewFinder: UIViewRepresentable {
    var height: CGFloat = 50
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func makeUIView(context: Context) -> some UIView {
        .init()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if context.coordinator.isMasked { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let rootView = uiView.viewBeforeWindow {
                rootView.frame =
                    .init(
                        origin: .zero, size: .init(
                            width: rootView.frame.width,
                            height: rootView.frame.height - 1
                        )
                    )
                
                rootView.clipsToBounds = true
                for view in rootView.subviews {
                    view.layer.shadowRadius = 0
                    view.layer.shadowColor = UIColor.clear.cgColor
                }
                
                context.coordinator.isMasked = true
            }
        }
    }
    
    class Coordinator: NSObject {
        var isMasked: Bool = false
    }
}

extension UIView {
    var viewBeforeWindow: UIView? {
        if let superview, superview is UIWindow {
            return self
        }
        
        return superview?.viewBeforeWindow
    }
}

