//
//  ProccessInfo+Extensioons.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 01/01/25.
//

import Foundation

public extension ProcessInfo {
    static var isInPreview: Bool {
        let val = (
            (
                ProcessInfo.processInfo
                    .environment["XCODE_RUNNING_FOR_PREVIEWS"] ?? "0"
            ) as String
        )
        
        return Int(val)! >= 1
    }
}
