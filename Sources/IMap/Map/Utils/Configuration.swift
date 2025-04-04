//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 04/04/25.
//

import Foundation
import SwiftUI

public protocol Configuration {
    var color: ConfigurationColor { get set }
}

public protocol ConfigurationColor: Sendable {
    var iPrimary: Color { get set }
    
    var iAction: Color { get set }
}

public struct ConfigurationColorImpl: ConfigurationColor {
    public var iAction: Color = .label
    
    public var iPrimary: Color = .blue
}

struct MapConfiguration: Configuration, Sendable {
    var color: any ConfigurationColor = ConfigurationColorImpl()
    
    
    static let `default`: MapConfiguration = .init()
}

@MainActor public var mapConfiguration: any Configuration = MapConfiguration.default

@MainActor
extension Color {
    static var iPrimary: Color {
        mapConfiguration.color.iPrimary
    }
    
    static var iAction: Color {
        mapConfiguration.color.iAction
    }
}
