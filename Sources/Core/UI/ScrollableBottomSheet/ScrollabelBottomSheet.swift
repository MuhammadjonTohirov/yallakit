//
//  ScrollabelBottomSheet.swift
//  TestAppForUI
//
//  Created by applebro on 02/06/25.
//

import Foundation
import SwiftUI

public struct ScrollableBottomSheet: UIViewRepresentable {
    public typealias Content = View
    var body: () -> any Content
    
    public init(content: @escaping () -> any Content) {
        self.body = content
    }
    
    public func makeUIView(context: Context) -> some UIView {
        let view = ScrollableUIBottomSheet(content: body)
        print(#function, "Make")
        return view
    }
    
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        let view = uiView as? ScrollableUIBottomSheet
        view?.setContent(body)
        view?.setNeedsLayout()
        print(#function, "Update")
    }
}

struct ScrollableBottomSheetTestView: View {
    @State var items: [Int] = Array(0...10)
    var body: some View {
        ZStack {
            Button {
                print("Good jobs")
            } label: {
                Text("Tap")
            }

            VStack(spacing: 10) {
                ScrollableBottomSheet {
                    VStack {
                        ForEach(items, id: \.self) { id in
                            Button {
                                print(id)
                            } label: {
                                Text("item \(id)")
                                    .frame(height: 32)
                            }
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.init(uiColor: .systemBackground))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Button {
                    
                } label: {
                    Text("Next")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.init(uiColor: .secondarySystemBackground))
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                items = Array(0..<30)
            }
        }
    }
}

#Preview {
    ScrollableBottomSheetTestView()
}
