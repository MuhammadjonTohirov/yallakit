//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 25/09/25.
//

import Foundation
import SwiftUI

struct MenuSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var sheetContent: () -> SheetContent
    
    @State private var rect: CGRect?
    private var radius: CGFloat = 20
    init(isPresented: Binding<Bool>, radius: CGFloat = 20, sheetContent: @escaping () -> SheetContent) {
        self._isPresented = isPresented
        self.sheetContent = sheetContent
        self.radius = radius
    }
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ScrollView(.vertical) {
                    sheetContent()
                        .readRect { rect in
                            self.rect = rect
                        }
                        .scrollIndicators(.hidden)
                }
                .presentationDetents([.height(((rect?.height) ?? 0) + UIApplication.shared.safeArea.bottom)])
                .presentationCornerRadius(radius)
            }
    }
}

public extension View {
    func showMenuSheet<SheetContent: View>(isPresented: Binding<Bool>, radius: CGFloat = 20, @ViewBuilder content: @escaping () -> SheetContent) -> some View {
        modifier(MenuSheetModifier(isPresented: isPresented, sheetContent: content))
    }
}
