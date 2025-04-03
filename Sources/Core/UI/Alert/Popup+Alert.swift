//
//  FAlert.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 03/03/25.
//

import Foundation
import Foundation
import SwiftUI

public struct PupupAlert<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: PopupContent
    
    public init(isPresented: Binding<Bool>, @ViewBuilder content: () -> PopupContent) {
        self._isPresented = isPresented
        self.popupContent = content()
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
                
                VStack {
                    self.popupContent
                        .background(Color.tertiaryBackground)
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
}

// Dialog content view with support for multiple buttons
struct PopupView<Content: View>: View {
    let title: String
    let message: String
    let buttons: [AlertButton]
    @ViewBuilder let customContent: Content?
    
    public init(
        title: String,
        message: String,
        buttons: [AlertButton],
        content: (() -> Content)? = nil
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
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
        self.customContent = content?()
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.inter(.regular, size: 22))
                .padding(.top, 25)
                .foregroundStyle(Color.label)
            
            Text(message)
                .font(.inter(.regular, size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            if let customContent = customContent {
                customContent
                    .padding(.horizontal, 20)
            }
            
            VStack(spacing: 12) {
                ForEach(buttons, id: \.title) { button in
                    Button(action: button.action) {
                        Text(button.title)
                            .font(.inter(.regular, size: 14))
                            .foregroundColor(button.titleColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60.f.sh()) // Using your scale helper
                            .background(button.backgroundColor)
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

// Example of how to use it
struct ContentView: View {
    @State private var showPopup = false
    @State private var showMultiButtonPopup = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Show Standard Alert") {
                    showPopup = true
                }
                
                Button("Show Multi-Button Alert") {
                    showMultiButtonPopup = true
                }
            }
            .navigationTitle("Custom Popup Demo")
            .customPopup(isPresented: $showPopup) {
                PopupView<EmptyView>(
                    title: "Отменить заказ?",
                    message: "Ищем машину для вас, но если отмените сейчас, поиск новой займет больше времени.",
                    primaryButtonTitle: "Отменить заказ",
                    primaryAction: {
                        // Handle cancel action
                        showPopup = false
                    },
                    secondaryButtonTitle: "Продолжить поиск",
                    secondaryAction: {
                        // Handle continue action
                        showPopup = false
                    }
                )
            }
        }
    }
}

// SwiftUI preview for testing
#Preview {
    ContentView()
}
