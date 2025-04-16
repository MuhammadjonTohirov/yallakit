//
//  PinViewModel.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation
import SwiftUI
import Combine
import Core

public class PinViewModel: ObservableObject {
    @Published public var state: PinState = .initial
    
    public init() {
        
    }
    
    @MainActor
    open func set(state: PinState) {
        debugPrint("Set pin state \(state.id)")
        if state == .initial {
            print(#file, #function, #line)
        }
        
        withAnimation(.easeInOut(duration: 0.2)) {
            self.state = state
        }
    }
}
