//
//  Popup+BottomSheet.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 19/03/25.
//

import Foundation
import SwiftUI

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
                .multilineTextAlignment(
                    isHorizontal ? .leading : .center
                )
                .padding(.horizontal, 20)
                
            if let customContent = customContent {
                customContent
                    .padding(.horizontal, 20)
            }
            
            actionsView
        }
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
        self.modifier(
            CustomBottomAlertModifier(
                isPresented: isPresented,
                sheetView: content
            )
        )
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
                    message: "Ищем машину для вас, но если отмените сейчас, поиск новой займет больше времени. Ищем машину для вас, но если отмените сейчас, поиск новой займет больше времени. Ищем машину для вас, но если отмените сейчас, поиск новой займет больше времени.",
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
                    isHorizontal: true
                )
            }
        }
    }
}

// SwiftUI preview for testing
#Preview {
    BottomSheetExample()
}

private struct CustomBottomAlertModifier<Container: View>: ViewModifier {
    var isPresented: Binding<Bool>
    var sheetView: () -> Container
    @State private var rect: CGRect = .zero
    @State private var sheetHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content.sheet(isPresented: isPresented) {
            ScrollView(content: {
                sheetView()
                .readRect(rect: $rect)
            })
            .presentationDetents([.height(sheetHeight)])
            .presentationCornerRadius(25)
        }
        .onChange(of: rect.height) { newValue in
            debugPrint("New height is \(newValue)")
            sheetHeight = newValue
        }
    }
}
