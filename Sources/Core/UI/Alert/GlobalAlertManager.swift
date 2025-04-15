//
//  GlobalAlertManager.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 09/04/25.
//

import Foundation
import SwiftUI
import Combine

// Global alert manager that can be accessed from anywhere
public class GlobalAlertManager: ObservableObject {
    // Singleton instance
    @MainActor 
    public static let shared = GlobalAlertManager()
    
    @Published public var isPresented: Bool = false
    @Published public var title: String = ""
    @Published public var message: String = ""
    @Published public var buttons: [AlertButton] = []
    @Published public var customContent: AnyView? = nil
    
    private init() {}
    
    public func showAlert(
        title: String,
        message: String,
        buttons: [AlertButton],
        customContent: AnyView? = nil
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.customContent = customContent
        self.isPresented = true
    }
    
    public func showAlert(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        var alertButtons: [AlertButton] = [
            PrimaryAlertButton(
                title: primaryButtonTitle,
                action: {
                    primaryAction()
                    self.dismiss()
                }
            )
        ]
        
        if let secondaryButtonTitle = secondaryButtonTitle,
           let secondaryAction = secondaryAction {
            alertButtons.append(
                CancelAlertButton(
                    title: secondaryButtonTitle,
                    action: {
                        secondaryAction()
                        self.dismiss()
                    }
                )
            )
        }
        
        self.showAlert(title: title, message: message, buttons: alertButtons)
    }
    
    public func dismiss() {
        self.isPresented = false
    }
}

// Global Popup Alert modifier that sits at the root of the app
public struct GlobalPopupAlertModifier: ViewModifier {
    @StateObject private var alertManager = GlobalAlertManager.shared
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(alertManager.isPresented)
            
            if alertManager.isPresented {
                Color.black
                    .opacity(0.12)
                    .ignoresSafeArea(edges: .all)
                    .transition(.opacity)
                
                VStack {
                    if let customContent = alertManager.customContent {
                        PopupView(
                            title: alertManager.title,
                            message: alertManager.message,
                            buttons: alertManager.buttons,
                            content: { customContent }
                        )
                        .background(Color.tertiaryBackground)
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                    } else {
                        PopupView<EmptyView>(
                            title: alertManager.title,
                            message: alertManager.message,
                            buttons: alertManager.buttons
                        )
                        .background(Color.tertiaryBackground)
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                    }
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(999) // Ensure it's above everything
            }
        }
        .animation(.easeInOut(duration: 0.2), value: alertManager.isPresented)
    }
}

public extension View {
    func withGlobalPopupAlert() -> some View {
        self.modifier(GlobalPopupAlertModifier())
    }
}

// Helper function to show the global alert from anywhere
@MainActor public func showGlobalAlert(
    title: String,
    message: String,
    primaryButtonTitle: String,
    primaryAction: @escaping () -> Void,
    secondaryButtonTitle: String? = nil,
    secondaryAction: (() -> Void)? = nil
) {
    GlobalAlertManager.shared.showAlert(
        title: title,
        message: message,
        primaryButtonTitle: primaryButtonTitle,
        primaryAction: primaryAction,
        secondaryButtonTitle: secondaryButtonTitle,
        secondaryAction: secondaryAction
    )
}
