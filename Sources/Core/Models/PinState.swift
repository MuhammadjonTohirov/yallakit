//
//  PinState.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 27/03/25.
//

import Foundation

public enum PinState: Hashable, Equatable, Identifiable {
    public var id: String {
        switch self {
        case .loading:
            return "loading"
        case .waiting:
            return "waiting"
        case .initial:
            return "initial"
        case .pinning:
            return "pinning"
        case .searching:
            return "searching"
        }
    }
    
    case loading
    case pinning
    case waiting(time: String, unit: String)
    case initial
    case searching
}
