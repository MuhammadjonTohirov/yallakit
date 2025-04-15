//
//  TransitionBottomSheet.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 07/04/25.
//

import Foundation
import SwiftUI

struct TransitionBottomSheet<Content1: View, Content2: View>: View {
    // Configuration parameters
    private let minHeight: CGFloat
    private let maxTopSpace: CGFloat
    private let content1: Content1
    private let content2: Content2
    
    // State variables
    @State private var sheetOffset: CGFloat = 0
    @State private var startDragOffset: CGFloat = 0
    @State private var isDragging = false
    
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
    
    init(minHeight: CGFloat = 300, maxTopSpace: CGFloat = 0, @ViewBuilder content1: () -> Content1, @ViewBuilder content2: () -> Content2) {
        self.minHeight = minHeight
        self.maxTopSpace = maxTopSpace
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
                        }
                    }
                
                // Sheet view
                VStack(spacing: 0) {
                    // Drag handle
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 5)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
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
                    RoundedRectangle(cornerRadius: 20)
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
                            
                            withAnimation(.spring()) {
                                if velocity < -50 || (sheetOffset < -(fullSheetHeight - minHeight) / 2 && velocity > -50) {
                                    // Snap to top
                                    sheetOffset = -(fullSheetHeight - minHeight)
                                } else if velocity > 50 || sheetOffset > -(fullSheetHeight - minHeight) / 3 {
                                    // Snap to bottom
                                    sheetOffset = 0
                                } else {
                                    // Stay at middle position
                                    sheetOffset = -(fullSheetHeight - minHeight) / 2
                                }
                            }
                        }
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
