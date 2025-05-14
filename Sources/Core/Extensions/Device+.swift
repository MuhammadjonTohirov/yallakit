//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 14/05/25.
//

import Foundation
import UIKit

public extension UIDevice {
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    }
}
