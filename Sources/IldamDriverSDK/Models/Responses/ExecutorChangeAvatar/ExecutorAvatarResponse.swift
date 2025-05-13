//
//  ExecutorAvatarResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public struct ExecutorAvatarResponse {
    public let fullURL: URL

    public init(path: String, image: String) {
        self.fullURL = URL(string: path + image)!
    }

    init(from network: DNetExecutorAvatarResponse) {
        self.init(path: network.path, image: network.image)
    }
}
