//
//  TransitionBottomSheet+Advanced.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 07/04/25.
//

import Foundation
import SwiftUI

enum SheetState {
    case collapsed
    case middle
    case expanded
}

struct AdvancedTransitionBottomSheet<Content1: View, Content2: View>: View {

    // Configuration parameters
    private let minHeight: CGFloat
    private let midHeight: CGFloat?
    private let maxTopSpace: CGFloat
    private let content1: Content1
    private let content2: Content2
    private let showDragIndicator: Bool
    private let cornerRadius: CGFloat
    
    // State variables
    @State private var sheetOffset: CGFloat = 0
    @State private var startDragOffset: CGFloat = 0
    @State private var isDragging = false
    @Binding var sheetState: SheetState
    
    // Computed properties for screen dimensions
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    private var fullSheetHeight: CGFloat {
        screenHeight - maxTopSpace
    }
    
    // Computed value for transition progress (0 to 1)
    private var transitionProgress: CGFloat {
        let total = fullSheetHeight - minHeight
        let current = min(max(0, -sheetOffset), total)
        return current / total
    }
    
    init(
        minHeight: CGFloat = 300,
        midHeight: CGFloat? = nil,
        maxTopSpace: CGFloat = 0,
        sheetState: Binding<SheetState> = .constant(.collapsed),
        showDragIndicator: Bool = true,
        cornerRadius: CGFloat = 20,
        @ViewBuilder content1: () -> Content1,
        @ViewBuilder content2: () -> Content2
    ) {
        self.minHeight = minHeight
        self.midHeight = midHeight
        self.maxTopSpace = maxTopSpace
        self._sheetState = sheetState
        self.showDragIndicator = showDragIndicator
        self.cornerRadius = cornerRadius
        self.content1 = content1()
        self.content2 = content2()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Background overlay that dims as sheet rises
                Color.black
                    .opacity(0.3 * transitionProgress)
                    .ignoresSafeArea()
                    .animation(.easeOut(duration: 0.2), value: transitionProgress)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            sheetOffset = 0
                            sheetState = .collapsed
                        }
                    }
                
                // Sheet view
                VStack(spacing: 0) {
                    // Drag handle
                    if showDragIndicator {
                        RoundedRectangle(cornerRadius: 2.5)
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 5)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                    }
                    
                    // Content container with both views
                    ZStack {
                        // Content 1 (fades out when dragging up)
                        content1
                            .opacity(1 - transitionProgress)
                        
                        // Content 2 (fades in when dragging up)
                        content2
                            .opacity(transitionProgress)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    // Extra space for bouncing
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                )
                .offset(y: max(sheetOffset, -(fullSheetHeight - minHeight)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if !isDragging {
                                isDragging = true
                                startDragOffset = sheetOffset
                            }
                            
                            let translation = gesture.translation.height
                            sheetOffset = startDragOffset + translation
                            
                            // Prevent further dragging if we've reached maxTopSpace
                            if sheetOffset < -(fullSheetHeight - minHeight) {
                                sheetOffset = -(fullSheetHeight - minHeight)
                            }
                        }
                        .onEnded { gesture in
                            isDragging = false
                            
                            // Calculate velocity to determine if we should snap
                            let velocity = gesture.predictedEndTranslation.height - gesture.translation.height
                            let maxOffset = -(fullSheetHeight - minHeight)
                            
                            withAnimation(.spring()) {
                                if let midHeight = midHeight {
                                    let midOffset = -(midHeight - minHeight)
                                    
                                    // Logic for 3 snap points
                                    if velocity < -50 && sheetOffset < midOffset {
                                        // Fast swipe up from middle or below - go to top
                                        sheetOffset = maxOffset
                                        sheetState = .expanded
                                    } else if velocity > 50 && sheetOffset > midOffset {
                                        // Fast swipe down from middle or above - go to bottom
                                        sheetOffset = 0
                                        sheetState = .collapsed
                                    } else if sheetOffset < midOffset * 0.5 {
                                        // Closer to top than middle
                                        sheetOffset = maxOffset
                                        sheetState = .expanded
                                    } else if sheetOffset > midOffset * 1.5 {
                                        // Closer to bottom than middle
                                        sheetOffset = 0
                                        sheetState = .collapsed
                                    } else {
                                        // Snap to middle
                                        sheetOffset = midOffset
                                        sheetState = .middle
                                    }
                                } else {
                                    // Logic for 2 snap points
                                    if velocity < -50 || sheetOffset < maxOffset / 2 {
                                        // Snap to top
                                        sheetOffset = maxOffset
                                        sheetState = .expanded
                                    } else {
                                        // Snap to bottom
                                        sheetOffset = 0
                                        sheetState = .collapsed
                                    }
                                }
                            }
                        }
                )
                .onChange(of: sheetState) { newState in
                    withAnimation(.spring()) {
                        switch newState {
                        case .collapsed:
                            sheetOffset = 0
                        case .middle:
                            if let midHeight = midHeight {
                                sheetOffset = -(midHeight - minHeight)
                            }
                        case .expanded:
                            sheetOffset = -(fullSheetHeight - minHeight)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
