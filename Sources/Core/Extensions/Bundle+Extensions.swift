//
//  Bundle+extensions.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 05/02/25.
//

import Foundation

public extension Bundle {
    var shortVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.1"
    }
    
    var version: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    var name: String {
        return displayName?.nilIfEmpty ?? infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var displayName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
}
