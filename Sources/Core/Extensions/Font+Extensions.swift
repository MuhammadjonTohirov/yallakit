//
//  Font+Extensions.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 03/03/25.
//

import Foundation
import SwiftUI

public extension UIFont {
    enum Inter: String {
        case black = "Black"
        case bold = "Bold"
        case extraBold = "ExtraBold"
        case extraLight = "ExtraLight"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "SemiBold"
        case thin = "Thin"
        
        public enum Weight: String {
            /// Thin
            case w100 = "Thin"
            /// ExtraLight
            case w200 = "ExtraLight"
            /// Light
            case w300 = "Light"
            /// Regular
            case w400 = "Regular"
            /// Medium
            case w500 = "Medium"
            /// SemiBold
            case w600 = "SemiBold"
            /// Bold
            case w700 = "Bold"
            /// ExtraBold
            case w800 = "ExtraBold"
            /// Black
            case w900 = "Black"
        }
    }
    
    static func inter(_ type: Inter, size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func inter(weight: Inter.Weight, size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}

public extension Font {
    static func inter(_ type: UIFont.Inter, size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-\(type.rawValue)", size: size.sh(limit: 0.5)) ?? .systemFont(ofSize: size))
    }
    
    static func inter(_ type: UIFont.Inter.Weight, size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-\(type.rawValue)", size: size.sh(limit: 0.5)) ?? .systemFont(ofSize: size))
    }
    
    static func glNumbernschild(size: CGFloat) -> Font {
        return Font(UIFont(name: "GL-Nummernschild-Eng", size: size.sh(limit: 0.5)) ?? .systemFont(ofSize: size))
    }
}
