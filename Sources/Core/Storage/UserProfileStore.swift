//
//  UserProfileStore.swift
//  Core
//
//  Created by YallaKit on 26/02/26.
//

import Foundation

public protocol UserProfileStoreProtocol: AnyObject {
    var username: String? { get set }
    var userInfo: UserInfo? { get set }
    var userAvatarURL: URL { get }
}

extension UserSettings: UserProfileStoreProtocol {}
