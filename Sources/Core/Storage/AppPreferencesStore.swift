//
//  AppPreferencesStore.swift
//  Core
//
//  Created by YallaKit on 26/02/26.
//

import Foundation

public protocol AppPreferencesStoreProtocol: AnyObject {
    var language: String? { get set }
    var isLanguageSelected: Bool? { get set }
    var theme: AppTheme? { get set }
}

extension UserSettings: AppPreferencesStoreProtocol {}
