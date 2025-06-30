//
//  AlertUtils.swift
//  Core
//
//  Created by applebro on 26/04/25.
//

import SwiftUI

// Helper class to make it easy to use alerts throughout the app
public struct AlertUtils {
    // Show an alert with a title, message, and primary button
    @MainActor public static func showAlert(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void
    ) {
        WindowAlertManager.shared.showAlert(
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryAction: primaryAction
        )
    }
    
    // Show an alert with a title, message, primary button, and secondary button
    @MainActor
    public static func showAlert(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String,
        secondaryAction: @escaping () -> Void
    ) {
        WindowAlertManager.shared.showAlert(
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryAction: primaryAction,
            secondaryButtonTitle: secondaryButtonTitle,
            secondaryAction: secondaryAction
        )
    }
    
    // Show an alert with custom buttons
    public static func showAlert(
        title: String,
        message: String,
        buttons: [AlertButton],
        onDismiss: @escaping () -> Void
    ) {
        WindowAlertManager.shared.showAlert(
            title: title,
            message: message,
            buttons: buttons,
            onDismiss: onDismiss
        )
    }
    
    @MainActor
    public static func showAlert(
        title: String,
        message: String,
        buttons: [AlertButton],
        customContent: AnyView,
        onDismiss: @escaping () -> Void
    ) {
        WindowAlertManager.shared.showAlert(
            title: title,
            message: message,
            buttons: buttons,
            customContent: customContent,
            onDismiss: onDismiss
        )
    }
    
    @MainActor
    public static func dismiss(_ onDismiss: (() -> Void)? = nil) {
        WindowAlertManager.shared.dismiss(onDismiss: onDismiss)
    }
}

// Extension to make it easier to replace GlobalAlertManager references
@MainActor
public extension GlobalAlertManager {
    // This extension helps with the transition from GlobalAlertManager to WindowAlertManager
    static func showAlert(
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        WindowAlertManager.shared.showAlert(
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryAction: primaryAction,
            secondaryButtonTitle: secondaryButtonTitle,
            secondaryAction: secondaryAction
        )
    }
}
