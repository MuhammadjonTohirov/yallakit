//
//  ReadRect.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 08/04/25.
//

import Foundation
import SwiftUI

public extension View {
    func readRect(rect: Binding<CGRect>) -> some View {
        self.modifier(ReadRectModifier(onRectChange: { _rect in
            rect.wrappedValue = _rect
        }))
    }
    
    func readRect(onRectChange: @escaping (CGRect) -> Void) -> some View {
        self.modifier(ReadRectModifier(onRectChange: onRectChange))
    }
    
    func readSize(size: Biding<CGSize>) -> some View {
        
    }
}
