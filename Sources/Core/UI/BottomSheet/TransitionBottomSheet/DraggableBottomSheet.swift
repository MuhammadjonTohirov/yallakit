import Foundation
import SwiftUI

public enum DragState {
    case started
    case ended
    case interrupted
    case normal
}

public struct DraggableBottomSheet<FirstView: View, SecondView: View>: View {
    // Content views
    private let firstView: FirstView
    private let secondView: SecondView
    
    // Configuration
    private let minHeight: CGFloat
    private let maxTopSpace: CGFloat
    
    // State
    @State private var offset: CGFloat = 0 {
        didSet {
            progress = (1 - (offset / maxDragDistance).clamped(to: 0...1))
        }
    }
    
    @State private var lastOffset: CGFloat = 0
    @State private var scrollOffset: CGPoint = .zero
    @State private var scrollAtTop: Bool = true
    @GestureState private var isDragging = false
    @State private var isScrollEnabled: Bool = true
    @State private var dragState: DragState = .normal
    // Screen dimensions
    private var screenHeight: CGFloat {
        UIApplication.shared.screenFrame.height
    }
    
    private var screenSafeAreaInsets: UIEdgeInsets {
        UIApplication.shared.safeArea
    }
    
    // Full height = screen height minus top space
    private var fullHeight: CGFloat {
        screenHeight - maxTopSpace - screenSafeAreaInsets.top - screenSafeAreaInsets.bottom
    }
    
    // Maximum drag distance
    private var maxDragDistance: CGFloat {
        fullHeight - minHeight
    }
    
    // Current drag progress (0 = collapsed, 1 = expanded)
    private var dragProgress: CGFloat {
        1 - (offset / maxDragDistance).clamped(to: 0...1)
    }
    
    @Binding var progress: CGFloat
    @Binding var isExpanded: Bool

    // Shadow opacity based on drag position
    private var shadowOpacity: Double {
        (1 - dragProgress) * 0.2
    }
     
    public init(
        minHeight: CGFloat,
        maxTopSpace: CGFloat = 0,
        progress: Binding<CGFloat>,
        isExpanded: Binding<Bool> = .constant(false),
        @ViewBuilder firstView: () -> FirstView,
        @ViewBuilder secondView: () -> SecondView
    ) {
        self.minHeight = minHeight
        self.maxTopSpace = maxTopSpace
        self.firstView = firstView()
        self.secondView = secondView()
        
        self._progress = progress
        self._isExpanded = isExpanded
        let currentOffset: CGFloat = maxDragDistance * (1 - self.progress)
        self._offset = State(wrappedValue: currentOffset)
        self._lastOffset = State(initialValue: maxDragDistance)
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
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(
                            Color(UIColor.systemBackground)
                        )
                        .shadow(
                            color: Color.black.opacity(shadowOpacity),
                            radius: 10
                        )
                )
                .offset(y: offset)
                .gesture(dragGesture)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .background(
            Color.background
                .opacity(dragProgress)
        )
        .onChange(of: isExpanded) { newValue in
            toggleSheet(expanded: newValue)
        }
        .onChange(of: isDragging) { newValue in
            if !newValue && dragState == .started {
                self.dragState = .interrupted
            }
        }
        .onChange(of: dragState) { newValue in
            if newValue == .interrupted {
                self.isExpanded.toggle()
                dragState = .normal
            }
        }
    }
    
    private var secondViewBody: some View {
        ScrollViewReader(content: { scrollProxy in
            ScrollView {
                secondView
                    .id("secondView")
                    .transaction { transition in
                        transition.animation = nil
                    }
                    .background(content: {
                        secondViewBackgroundReader(scrollProxy)
                    })
            }
        })
        .coordinateSpace(name: "scroll")
        .sizeBasedBounce()
        .opacity(dragProgress)
//        .disabled(!isScrollEnabled)
        .disabled(dragProgress != 1)
    }
    
    private func secondViewBackgroundReader(_ scrollProxy: ScrollViewProxy) -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("scroll")).minY
            Color.clear
                .preference(
                    key: ScrollPreferenceKey.self,
                    value: minY
                )
                .onPreferenceChange(ScrollPreferenceKey.self) { value in
                    if value > 0 && scrollAtTop {
                        offset = 0.01
                        scrollProxy
                            .scrollTo("secondView", anchor: .top)

                        if offset != 0 {
                            DispatchQueue
                                .main
                                .asyncAfter(
                                    deadline: .now() + 0.2
                                ) {
                                    offset = 0
                                }
                        }
                    }
                }
        }
    }
    
    // Toggle method to show/hide the sheet
    private func toggleSheet(expanded: Bool) {
        withAnimation(.spring(response: 0.12, dampingFraction: 0.9)) {
            offset = expanded ? 0 : maxDragDistance
            lastOffset = offset
        }
    }
    
    // Drag gesture to handle sheet movement
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                let dragAmount = value.translation.height
                dragState = .started
                // Allow dragging UP from any state
                // Allow dragging DOWN only if ScrollView is at the top or sheet is not fully expanded
                let canDragDown = scrollAtTop || offset > 0
                
                withTransaction(.init(animation: nil)) {
                    if dragAmount < 0 || canDragDown {
                        let newOffset = lastOffset + dragAmount
                        
                        // Constrain to allowed range with resistance at ends
                        if newOffset < 0 {
                            offset = 0  // Resistance when pulling beyond top
                        } else if newOffset > maxDragDistance {
                            offset = maxDragDistance + (newOffset - maxDragDistance) * 0.0001  // Resistance when pulling beyond bottom
                        } else {
                            offset = newOffset
                        }
                    }
                }
            }
            .onEnded { value in
                onEndDragging(value: value)
            }
    }
    
    private func onEndDragging(value: DragGesture.Value) {
        dragState = .ended
        // Determine if we should snap to top or bottom based on drag velocity
        let dragAmount = value.translation.height
        let velocity = value.predictedEndTranslation.height - dragAmount
        
        withAnimation(.spring(response: 0.12, dampingFraction: 0.9)) {
            if dragAmount + velocity < -10 || offset < maxDragDistance * 0.1 {
                expandSeet()
            } else {
                dismissSheet()
            }
            lastOffset = offset
        }
    }
    
    private func dismissSheet() {
        offset = maxDragDistance
        isExpanded = false
    }
    
    private func expandSeet() {
        offset = 0
        isExpanded = true
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension View {
    
    func onChange<T>(val value: T, action: @escaping (_ old: T, _ new: T) -> Void) -> some View where T: Equatable {
        if #available(iOS 17.0, *) {
            return self.onChange(of: value) { oldValue, newValue in
                action(oldValue, newValue)
            }
        } else {
            return self.onChange(of: value, perform: { newValue in
                action(newValue, newValue)
            })
        }
    }
}

struct ScrollPreferenceKey: @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func sizeBasedBounce() -> some View {
        if #available(iOS 16.4, *) {
            self.scrollBounceBehavior(.basedOnSize)
        }
    }
}
