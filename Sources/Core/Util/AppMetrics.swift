//
//  AppMetrics.swift
//  Ildam
//
//  Created by applebro on 20/11/23.
//

import Foundation
import UIKit

public struct AppMetrics {
    public static let designHeight: CGFloat = 780
    public static let designWidth: CGFloat = 360
    
    @MainActor public static func width(_ width: CGFloat) -> CGFloat {
        return (width * UIScreen.main.bounds.width / designWidth).limitTop(width * 1.1)
    }
    
    @MainActor public static func height(_ height: CGFloat) -> CGFloat {
        return (height * UIScreen.main.bounds.height / designHeight).limitTop(height * 1.1)
    }
}

public extension CGFloat {
    @MainActor var w: CGFloat {
        AppMetrics.width(self)
    }
    
    @MainActor var h: CGFloat {
        AppMetrics.height(self)
    }
}
