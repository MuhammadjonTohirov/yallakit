//
//  UIColor+Extension.swift
//  UnitedUIKit
//
//  Created by applebro on 08/10/23.
//

import Foundation
import SwiftUI

public extension Color {
    
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    static var label: Color {
        .init(uiColor: .label)
    }
    
    static var background: Color {
        .init(uiColor: .systemBackground)
    }
    
    static var secondaryBackground: Color {
        .init(uiColor: .secondarySystemBackground)
    }
    
    static var tertiaryBackground: Color {
        .init(uiColor: .tertiarySystemBackground)
    }
}

extension UIColor {
    public static var actionColor: UIColor {
        return .label
    }
}
