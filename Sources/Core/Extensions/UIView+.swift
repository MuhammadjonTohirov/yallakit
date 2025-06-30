//
//  UIView+.swift
//  TestAppForUI
//
//  Created by applebro on 30/05/25.
//

import Foundation
import UIKit
import SwiftUI


struct UIViewReresenterWrapper<T: UIKit.UIView>: UIViewRepresentable {
    private(set) var view: T

    init(_ view: T) {
        self.view = view
    }

    func makeUIView(context: Context) -> some UIView {
        view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


public extension UIView {
    var asSwiftUI: some View {
        UIViewReresenterWrapper(self)
    }
    
    func appendSubviews(_ appendedSubviews: UIView?...) {
        for subview in appendedSubviews where subview != nil {
            self.addSubview(subview!)
        }
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4,
        cornerRadius: CGFloat = 0,
        shouldRasterize: Bool = true
    ) {
        // Set the shadow color, opacity, offset, and radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        // Set the corner radius if required
        self.layer.cornerRadius = cornerRadius
        
        // To improve performance, rasterize the shadow
        self.layer.shouldRasterize = shouldRasterize
        self.layer.rasterizationScale = UIScreen.main.scale
        
        // Optional: Adds a shadow path to enhance performance further
        if cornerRadius > 0 {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        }
    }
    
    func removeShadow() {
        self.layer.shadowColor = nil
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
    }
    
    func onClick(target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    var border: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor? {
        get {
            return self.layer.borderColor
        }
        set {
            self.layer.borderColor = newValue
        }
    }
    
    var radius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
