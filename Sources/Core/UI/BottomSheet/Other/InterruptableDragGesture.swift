//
//  File.swift
//  RoyalKit
//
//  Created by Muhammadjon Tohirov on 08/08/25.
//

import Foundation
import SwiftUI

public struct InterruptableDragGestureModifier: ViewModifier {
    enum DragState {
        case dragging
        case ended
        case interrupted
        case initial
    }
    
    var isEnabled: Bool = true
    
    @GestureState private var isDragging: Bool = false
    
    @State
    private var dragState: DragState = .initial
    
    var onStateChange: ((DragState, _ value: DragGesture.Value) -> Void)
    
    @State
    private var lastValue: DragGesture.Value?
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: isDragging, perform: { newValue in
                if !newValue, dragState == .dragging {
                    setDragState(.interrupted)
                }
            })
            .gesture(gesture, isEnabled: isEnabled)
    }
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($isDragging) { value, state, transaction in
                lastValue = value
                state = dragState == .dragging
            }
            .onChanged({ val in
                if lastValue == nil {
                    lastValue = val
                }
                
                setDragState(.dragging)
            })
            .onEnded { val in
                setDragState(.ended)
            }
    }
    
    private func setDragState(_ state: DragState) {
        self.dragState = state
        if let lastValue {
            self.onStateChange(dragState, lastValue)
        }
    }
}

extension View {
    func dragGestureInterruptable(
        isEnabled: Bool = true,
        onStateChange: @escaping (
            InterruptableDragGestureModifier.DragState,
            DragGesture.Value
        ) -> Void = {_, _ in}
    ) -> some View {
        modifier(InterruptableDragGestureModifier(
            isEnabled: isEnabled,
            onStateChange: onStateChange
        ))
    }
}
