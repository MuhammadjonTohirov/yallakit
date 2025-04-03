//
//  Popup+BottomSheet.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 19/03/25.
//

import Foundation
import SwiftUI

public struct BottomSheetAlert<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetContent: SheetContent
    
    public init(isPresented: Binding<Bool>, @ViewBuilder content: () -> SheetContent) {
        self._isPresented = isPresented
        self.sheetContent = content()
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
            
            if isPresented {
                Color.black
                    .opacity(0.12)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        isPresented = false
                    }
                
                VStack {
                    Spacer()
                    self.sheetContent
                        .background(
                            Color.background
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .ignoresSafeArea()
                        )
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

// BottomSheet content view with support for multiple buttons
public struct BottomAlertView<Content: View>: View {
    let title: String
    let message: String
    let buttons: [AlertButton]
    let isHorizontal: Bool
    @ViewBuilder let customContent: Content?
    
    public init(
        title: String,
        message: String,
        buttons: [AlertButton],
        isHorizontal: Bool = false,
        content: (() -> Content)? = nil
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.isHorizontal = isHorizontal
        self.customContent = content?()
    }
    
    // Legacy support for primary/secondary buttons
    public init(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil,
        isHorizontal: Bool = false,
        content: (() -> Content)? = nil
    ) {
        var alertButtons: [AlertButton] = [
            PrimaryAlertButton(
                title: primaryButtonTitle,
                action: primaryAction
            )
        ]
        
        if let secondaryButtonTitle = secondaryButtonTitle,
           let secondaryAction = secondaryAction {
            alertButtons.append(
                CancelAlertButton(
                    title: secondaryButtonTitle,
                    action: secondaryAction
                )
            )
        }
        
        self.title = title
        self.message = message
        self.buttons = alertButtons
        self.isHorizontal = isHorizontal
        self.customContent = content?()
    }
    
    public var body: some View {
        VStack(alignment: isHorizontal ? .leading : .center, spacing: 16) {
            // Handle to show it's draggable
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .cornerRadius(2.5)
                    .padding(.top, 10)
                Spacer()
            }
                
            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)

            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(isHorizontal ? .leading : .center)
                .padding(.horizontal, 20)
            
            if let customContent = customContent {
                customContent
                    .padding(.horizontal, 20)
            }
            
            actionsView
        }
        .padding(.bottom, 20) // For devices with home indicator
    }
    
    @ViewBuilder
    private var actionsView: some View {
        if isHorizontal && buttons.count > 1 {
            // Horizontal layout for buttons
            HStack(spacing: 12) {
                ForEach(buttons, id: \.title) { button in
                    Button(action: button.action) {
                        Text(button.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(button.titleColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(button.backgroundColor)
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 10)
        } else {
            // Vertical layout for buttons
            VStack(spacing: 12) {
                ForEach(buttons, id: \.title) { button in
                    Button(action: button.action) {
                        Text(button.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(button.titleColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(button.backgroundColor)
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
    }
}

// Extension for using the bottom sheet modifier
extension View {
    public func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(BottomSheetAlert(isPresented: isPresented, content: content))
    }
}

// Example of how to use it
struct BottomSheetExample: View {
    @State private var showBottomSheet = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Show Bottom Sheet") {
                    showBottomSheet = true
                }
            }
            .navigationTitle("Bottom Sheet Demo")
            .bottomSheet(isPresented: $showBottomSheet) {
                BottomAlertView<EmptyView>(
                    title: "Отменить заказ?",
                    message: "Ищем машину для вас, но если отмените сейчас, поиск новой займет больше времени.",
                    primaryButtonTitle: "Отменить заказ",
                    primaryAction: {
                        // Handle cancel action
                        showBottomSheet = false
                    },
                    secondaryButtonTitle: "Продолжить поиск",
                    secondaryAction: {
                        // Handle continue action
                        showBottomSheet = false
                    },
                    isHorizontal: false
                )
            }
        }
    }
}

// SwiftUI preview for testing
#Preview {
    BottomSheetExample()
}
