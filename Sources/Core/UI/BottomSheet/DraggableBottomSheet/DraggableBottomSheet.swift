//
//  DragState.swift
//  TestApp
//
//  Created by Muhammadjon Tohirov on 08/07/25.
//


import Foundation
import SwiftUI

public struct DraggableBottomSheet<FirstView: View, SecondView: View>: View {
    // Content views
    private let firstView: FirstView
    private let secondView: SecondView
    
    @StateObject
    var viewModel = DraggableBottomSheetViewModel()
    
    // Configuration
    private let minHeight: CGFloat
    private let maxTopSpace: CGFloat
    @Environment(\.scenePhase) private var scenePhase

    // State

    @GestureState private var isDragging = false
    
    // Screen dimensions
    @MainActor
    private var screenHeight: CGFloat {
        UIApplication.shared.screenFrame.height
    }
    
    @MainActor
    private var screenSafeAreaInsets: UIEdgeInsets {
        UIApplication.shared.safeArea
    }
    
    // Full height = screen height minus top space
    @MainActor
    private var fullHeight: CGFloat {
        screenHeight - maxTopSpace - screenSafeAreaInsets.top - screenSafeAreaInsets.bottom
    }
    
    // Maximum drag distance
    private var maxDragDistance: CGFloat {
        fullHeight - minHeight
    }
    
    // Current drag progress (0 = collapsed, 1 = expanded)
    private var dragProgress: CGFloat {
        1 - (viewModel.offset / maxDragDistance).clamped(to: 0...1)
    }
    
    @Binding var progress: CGFloat
    @Binding var isExpanded: Bool

    // Shadow opacity based on drag position
    private var shadowOpacity: Double {
        (1 - dragProgress) * _shadowOpacity
    }
    
    private var _shadowOpacity: CGFloat = 0.2

    private var _offset: CGFloat = 0
    private var _lastOffset: CGFloat = 0
    
    private var backgroundColor: Color
    private var shadowColor: Color = .black
    private var cornerRadius: CGFloat = 20

    public init(
        minHeight: CGFloat,
        maxTopSpace: CGFloat = 0,
        progress: Binding<CGFloat>,
        backgroundColor: Color = Color.init(uiColor: .systemBackground),
        shadowOpacity: CGFloat = 0.2,
        cornerRadius: CGFloat = 20,
        isExpanded: Binding<Bool> = .constant(false),
        @ViewBuilder firstView: () -> FirstView,
        @ViewBuilder secondView: () -> SecondView
    ) {
        self.minHeight = minHeight
        self.maxTopSpace = maxTopSpace
        self.firstView = firstView()
        self.secondView = secondView()
        self.backgroundColor = backgroundColor
        self._shadowOpacity = shadowOpacity
        self.cornerRadius = cornerRadius
        self._progress = progress
        self._isExpanded = isExpanded

        let currentOffset: CGFloat = maxDragDistance * (1 - self.progress)
        self._offset = currentOffset
        self._lastOffset = maxDragDistance
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Main sheet view
                VStack(spacing: 0) {
                    Capsule()
                        .foregroundStyle(Color.secondary)
                        .frame(width: 24, height: 6)
                        .padding(.vertical, 10)
                        .opacity(dragProgress)
                        
                    ZStack {
                        // First view fades out as we drag up
                        firstView
                            .opacity(1 - dragProgress)
                            .disabled(dragProgress != 0)
                        
                        secondViewBody
                    }
                }
                .frame(width: geometry.size.width)
                .background(
                    Rectangle()
                        .fill(Color.init(uiColor: .systemBackground))
                        .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
                        
                        .shadow(
                            color: Color.black.opacity(shadowOpacity),
                            radius: 10
                        )
                )
                .offset(y: viewModel.offset)
                .dragGestureInterruptable(isEnabled: !isExpanded) { state, value in
                    switch state {
                    case .dragging:
                        let dragAmount = value.translation.height
                        let canDragDown = viewModel.scrollAtTop || viewModel.offset > 0
                        
                        withTransaction(.init(animation: nil)) {
                            if dragAmount < 0 || canDragDown {
                                let newOffset = viewModel.lastOffset + dragAmount
                                
                                // Constrain to allowed range with resistance at ends
                                if newOffset < 0 {
                                    viewModel.offset = 0  // Resistance when pulling beyond top
                                } else if newOffset > viewModel.maxDragDistance {
                                    viewModel.offset = viewModel.maxDragDistance + (newOffset - viewModel.maxDragDistance) * 0.0001
                                } else {
                                    viewModel.offset = newOffset
                                }
                            }
                        }
                    case .ended:
                        onEndDragging(value: value)
                    case .interrupted:
                        onEndDragging(value: value)
                    default: break
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .background(
            backgroundColor.opacity(dragProgress)
        )
        .onChange(of: isExpanded) { newValue in
            toggleSheet(expanded: newValue)
        }
        .onChange(of: viewModel.dragState) { newValue in
            if newValue == .interrupted {
                self.dismissSheet()
                self.viewModel.dragState = .normal
            }
        }
        .onChange(of: isDragging) { newValue in
            if !newValue && viewModel.dragState == .started {
                self.viewModel.dragState = .interrupted
            }
        }
        .onAppear {
            viewModel.lastOffset = _lastOffset
            viewModel.offset = _offset
            viewModel.maxDragDistance = maxDragDistance
            viewModel.progress = progress

            viewModel.$offset.removeDuplicates().sink { newValue in
                if newValue == viewModel.maxDragDistance {
                    self.isExpanded = false
                }
                
                if newValue == 0 {
                    self.isExpanded = true
                }
            }
            .store(in: &viewModel.cancellables)
            
            viewModel.$progress.removeDuplicates().sink { prog in
                self.progress = prog
            }.store(in: &viewModel.cancellables)
        }
    }
    
    private var secondViewBody: some View {
        ScrollView {
            secondView
                .id("secondView")
                .transaction { transition in
                    transition.animation = nil
                }
                .introspectScrollView { scrollView in
                    viewModel.setScrollView(scrollView)
                }
        }
        .coordinateSpace(name: "scroll")
        .scrollIndicators(.hidden, axes: .vertical)
        .opacity(dragProgress)
    }
    
    // Toggle method to show/hide the sheet
    private func toggleSheet(expanded: Bool) {
        withAnimation(.spring(response: 0.2, dampingFraction: 0.9)) {
            viewModel.offset = expanded ? 0 : viewModel.maxDragDistance
            viewModel.lastOffset = viewModel.offset
            isExpanded = expanded
        }
    }
    private var minimumDragDistance: CGFloat {
        if !isExpanded {
            return 20
        }
        
        return 0
    }
    
    private func onEndDragging(value: DragGesture.Value) {
        viewModel.dragState = .ended
        viewModel.lastOffset = viewModel.offset
        withAnimation(.interactiveSpring(duration: 0.3)) {
            let diff = self.viewModel.maxDragDistance - self.viewModel.offset
            
            if diff > 50 {
                expandSeet()
            } else {
                dismissSheet()
            }
        }
    }
    
    private func dismissSheet() {
        viewModel.offset = maxDragDistance
        isExpanded = false
    }
    
    private func expandSeet() {
        viewModel.offset = 0
        isExpanded = true
    }
}

struct ScrollPreferenceKey: @preconcurrency PreferenceKey {
    @MainActor static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
