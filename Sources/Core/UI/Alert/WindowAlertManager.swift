//
//  File.swift
//  YallaKit
//
//  Created by applebro on 27/05/25.
//


import Foundation
import Combine
import SwiftUI
import UIKit

// Global alert manager that uses a UIWindow to display alerts on top of everything
public class WindowAlertManager: ObservableObject, @unchecked Sendable {
    // Singleton instance
    public static let shared = WindowAlertManager()
    
    @Published public var isPresented: Bool = false
    @Published public var title: String = ""
    @Published public var message: String = ""
    @Published public var buttons: [AlertButton] = []
    @Published public var customContent: AnyView? = nil
    public var onDismiss: () -> Void = {}
    
    // UIWindow for displaying the alert on top of everything
    private var alertWindow: UIWindow?
    private var hostingController: UIHostingController<AlertHostView>?
    
    private init() {
        // Initialize with an empty alert
    }
    
    public func showAlert(
        title: String,
        message: String,
        buttons: [AlertButton],
        customContent: AnyView? = nil,
        onDismiss: @escaping () -> Void = {}
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.customContent = customContent
        self.isPresented = true
        self.onDismiss = onDismiss

        Task { @MainActor in
            self.presentAlertWindow()
        }
    }
    
    public func showAlert(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil,
        onDismiss: @escaping () -> Void = {}
    ) {
        var alertButtons: [AlertButton] = [
            PrimaryAlertButton(
                title: primaryButtonTitle,
                action: { [weak self] in
                    primaryAction()
                    self?.dismiss()
                }
            )
        ]
        
        if let secondaryButtonTitle = secondaryButtonTitle,
           let secondaryAction = secondaryAction {
            alertButtons.append(
                CancelAlertButton(
                    title: secondaryButtonTitle,
                    action: { [weak self] in
                        secondaryAction()
                        self?.dismiss()
                    }
                )
            )
        }
        
        self.showAlert(title: title, message: message, buttons: alertButtons, onDismiss: onDismiss)
    }
    
    @MainActor
    private func presentAlertWindow() {
        guard isPresented else { return }
        
        // Create alert host view
        let alertView = AlertHostView(alertManager: self)
        
        // Create hosting controller for the alert view
        let hostingController = UIHostingController(rootView: alertView)
        hostingController.view.backgroundColor = .clear
        self.hostingController = hostingController
        
        // Create a new window that sits above everything
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let alertWindow = UIWindow(windowScene: windowScene)
        alertWindow.backgroundColor = .clear
        alertWindow.windowLevel = .alert + 1 // Above system alerts
        alertWindow.rootViewController = hostingController
        alertWindow.makeKeyAndVisible()
        self.alertWindow = alertWindow
    }
    
    public func dismiss() {
        Task { @MainActor in
            self.isPresented = false
            self.dismissAlertWindow()
        }
    }
    
    @MainActor
    private func dismissAlertWindow() {
        // Dismiss with a short delay to allow animations to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.alertWindow?.isHidden = true
            self.alertWindow = nil
            self.hostingController = nil
            self.onDismiss()
        }
    }
}

// View that hosts the alert UI
struct AlertHostView: View {
    @ObservedObject var alertManager: WindowAlertManager
    var onDismiss: () -> Void = { }
    
    var body: some View {
        ZStack {
            if alertManager.isPresented {
                // Semi-transparent background
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        // Optional: dismiss on background tap
                        // alertManager.dismiss()
                    }
                
                // Alert content
                VStack {
                    if let customContent = alertManager.customContent {
                        PopupView(
                            title: alertManager.title,
                            message: alertManager.message,
                            buttons: alertManager.buttons,
                            content: { customContent }
                        )
                        .background(Color.tertiaryBackground)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    } else {
                        PopupView<EmptyView>(
                            title: alertManager.title,
                            message: alertManager.message,
                            buttons: alertManager.buttons
                        )
                        .background(Color.tertiaryBackground)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                }
                .transition(.scale.combined(with: .opacity))
            }
        }.onAppear {
            alertManager.onDismiss = onDismiss
        }
    }
}

// Helper function to show the global alert from anywhere
public func showWindowAlert(
    title: String,
    message: String,
    primaryButtonTitle: String,
    primaryAction: @escaping () -> Void,
    secondaryButtonTitle: String? = nil,
    secondaryAction: (() -> Void)? = nil,
    onDismiss: @escaping (() -> Void) = {}
) {
    WindowAlertManager.shared.showAlert(
        title: title,
        message: message,
        primaryButtonTitle: primaryButtonTitle,
        primaryAction: primaryAction,
        secondaryButtonTitle: secondaryButtonTitle,
        secondaryAction: secondaryAction,
        onDismiss: onDismiss
    )
}
