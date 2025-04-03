//
//  Popup+Actions.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 03/03/25.
//

import Foundation
import SwiftUI

public protocol AlertButton {
    var title: String { get }
    var detail: String? { get }
    var action: () -> Void { get }
    var backgroundColor: Color { get }
    var titleColor: Color { get }
}

// Button Action Structure
public struct PrimaryAlertButton: AlertButton {
    public let title: String
    public var detail: String?
    public let action: () -> Void
    public var backgroundColor: Color
    public var titleColor: Color
    
    public init(
        title: String,
        detail: String? = nil,
        backgroundColor: Color = .label,
        titleColor: Color = .background,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.detail = detail
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
    }
}

public struct CancelAlertButton: AlertButton {
    public let title: String
    public var detail: String?
    public let action: () -> Void
    public var backgroundColor: Color
    public var titleColor: Color
    
    public init(
        title: String,
        detail: String? = nil,
        backgroundColor: Color = .secondaryBackground,
        titleColor: Color = .label,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.detail = detail
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
    }
}
