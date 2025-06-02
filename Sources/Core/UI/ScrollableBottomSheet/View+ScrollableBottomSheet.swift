//
//  View+ScrollableBottomSheet.swift
//  TestAppForUI
//
//  Created by applebro on 02/06/25.
//

import Foundation
import SwiftUI

public struct ScrollableBottomSheetModifier: ViewModifier {
    public typealias BodyContent = View
    
    @Binding var isExpanded: Bool
    var height: CGFloat = 200
    
    var sheetContent: () -> any BodyContent
    
    public init(isExpanded: Binding<Bool>, sheetContent: @escaping () -> any BodyContent) {
        self.sheetContent = sheetContent
        self._isExpanded = isExpanded
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            ScrollableBottomSheet(
                minHeight: height,
                content: sheetContent
            ) {
                isExpanded = true
            } collapsed: {
                isExpanded = false
            }
        }
    }
}
