//
//  SimpleBottomSheet.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import SwiftUI

/// PreferenceKey to measure content height
struct HeightKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue next: () -> CGFloat) {
        value = max(value, next())
    }
}

struct FooterHeightKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue next: () -> CGFloat) {
        value = max(value, next())
    }
}

extension View {
    @ViewBuilder
    func ifLet<Content: View, V>(_ value: V?, @ViewBuilder content: (V) -> Content) -> some View {
        if let v = value {
            content(v)
        } else {
            self
        }
    }
}

public struct SimpleBottomSheet<Content: View, Footer: View>: View {
    // MARK: Config
    let partialRatio: CGFloat
    let backgroundColor: Color
    let content: Content
    let footer: Footer?

    // MARK: Drag State
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isExpanded = false
    @State private var contentHeight: CGFloat = .zero
    @State private var footerHeight: CGFloat = .zero

    private var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.safeArea
    }
    
    public init(
        partialRatio: CGFloat = 0.4,
        backgroundColor: Color = .white,
        @ViewBuilder content: () -> Content
    ) where Footer == EmptyView {
        self.partialRatio = partialRatio
        self.backgroundColor = backgroundColor
        self.content = content()
        self.footer = nil
    }

    public init(
        partialRatio: CGFloat = 0.4,
        backgroundColor: Color = .white,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.partialRatio = partialRatio
        self.backgroundColor = backgroundColor
        self.content = content()
        self.footer = footer()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            innerBody
                .padding(.bottom, footerHeight - safeAreaInsets.bottom - safeAreaInsets.top)
            if let footer {
                footer
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: FooterHeightKey.self, value: proxy.size.height)
                        }
                    )
                    .background(Color.background)
                    .onPreferenceChange(FooterHeightKey.self) { footerHeight = $0 }
            }
        }
    }

    private var innerBody: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // Handle
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.top, 8)

                // Content
                content
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: HeightKey.self, value: proxy.size.height)
                        }
                    )
            }
            .background(backgroundColor.cornerRadius(20).ignoresSafeArea())
            .frame(height: contentHeight + 20)
            .offset(y: calculateOffset(screenHeight: geo.size.height) + 4)
            .gesture(dragGesture)
            .onPreferenceChange(HeightKey.self) { contentHeight = $0 }
            .animation(.linear(duration: 0.2), value: isExpanded)
            .ignoresSafeArea(edges: .bottom)
        }
    }

    // Compute dynamic offset so the sheet sits at bottom initially and expands upward
    private func calculateOffset(screenHeight: CGFloat) -> CGFloat {
        let sheetHeight = contentHeight + 20
        let collapsedHeight = sheetHeight * partialRatio
        // Y position top of sheet when collapsed or expanded
        let baseY = isExpanded
            ? (screenHeight - sheetHeight)
            : (screenHeight - collapsedHeight)
        // raw dragged offset
        let rawY = baseY + dragOffset
        // clamp between fully expanded and collapsed
        let minY = screenHeight - sheetHeight
        let maxY = screenHeight - collapsedHeight
        return min(max(rawY, minY), maxY)
    }

    // Single drag gesture for both updating and ending
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                withTransaction(.init(animation: nil)) {
                    state = value.translation.height
                    debugPrint(state)
                }
            }
            .onEnded { value in
                // Simple threshold toggle
                let halfway = contentHeight * (1 - partialRatio) / 2
                isExpanded = (isExpanded && value.translation.height < halfway)
                    || (!isExpanded && value.translation.height < -halfway)
            }
    }
}

struct DemoBottomSheetView: View {
    var body: some View {
        ZStack {
            // MARK: Background content
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                Text("Your Main App Content")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            
            // MARK: Bottom sheet
            SimpleBottomSheet(partialRatio: 0.6, backgroundColor: Color.white, content: {
                VStack {
                    bottomSheetContent
                    if showLarger {
                        bottomSheetContent
                    }
                }
            }, footer: {
                Button(action: {
                    print("Button tapped!")
                }) {
                    Text("Tap Me")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showLarger = true
            }
        }
    }
    
    @State private var showLarger: Bool = false
    
    private var bottomSheetContent: some View {
        VStack(spacing: 16) {
            Text("Hello from the sheet!")
                .font(.headline)
            
            Divider()
            
            Text("Drag up to expand, drag down to collapse.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct DemoBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DemoBottomSheetView()
    }
}
