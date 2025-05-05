//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/05/25.
//

import Foundation

public struct Constants: Sendable {
    public var baseGoApi: String = "https://api2.ildam.uz"
    public var basePhpApi: String = "https://api.ildam.uz"
}

public struct ConstantsProvider: Sendable {
    public static let shared: ConstantsProvider = .init()
    
    public private(set) var constants: Constants = .init()
    
    mutating
    func setConstants(_ constants: Constants) {
        self.constants = constants
    }
}
