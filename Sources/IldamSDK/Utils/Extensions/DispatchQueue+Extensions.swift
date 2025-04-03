//
//  DispatchQueue+Extensions.swift
//  USDK
//
//  Created by applebro on 23/10/23.
//

import Foundation
import Core

func mainIfNeeded(_ task: @Sendable @escaping () -> Void) {
    Core.mainIfNeeded(task)
}
