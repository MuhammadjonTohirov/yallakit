//
//  Array+Extensions.swift
//  YuzSDK
//
//  Created by applebro on 28/04/23.
//

import Foundation
import SwiftUI

public extension Array where Element: Codable {
    func mapTo<T>(_ type: T.Type) -> [T] where T: Codable {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func mapTo<T>(_ type: T.Type) -> T where T: Codable {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return self as! T
        }
    }
}

public extension Array where Element: View {
    func vstack(alignment: HorizontalAlignment = .center, spacing: CGFloat = 4) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(self.indices, id: \.self) { index in
                self[index]
            }
        }
    }
}
