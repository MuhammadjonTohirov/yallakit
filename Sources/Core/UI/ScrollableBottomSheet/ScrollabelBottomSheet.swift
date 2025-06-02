//
//  ScrollabelBottomSheet.swift
//  TestAppForUI
//
//  Created by applebro on 02/06/25.
//

import Foundation
import SwiftUI

struct ScrollableBottomSheet: UIViewRepresentable {
    typealias Content = View
    var body: () -> any Content
    var minimumHeight: CGFloat = 200
    var expanded: () -> Void
    var collapsed: () -> Void
    
    init(
        minHeight: CGFloat = 200,
        content: @escaping () -> any Content,
        expanded: @escaping () -> Void = {},
        collapsed: @escaping () -> Void = {}
    ) {
        self.body = content
        self.minimumHeight = minHeight
        self.expanded = expanded
        self.collapsed = collapsed
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = ScrollableUIBottomSheet(content: body)
        print(#function, "Make")
        view.onExpanded = expanded
        view.onCollapsed = collapsed
        view.setMinHeight(minimumHeight)
        return view
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let view = uiView as? ScrollableUIBottomSheet else { return }
        view.setMinHeight(minimumHeight)
        view.setContent(body)
        view.setNeedsLayout()
    }
}

struct ScrollableBottomSheetTestView: View {
    @State var items: [Int] = Array(0...0)
    @State var minHeight: CGFloat = 200
    @State var expanded: Bool = false
    
    var body: some View {
        ZStack {
            Button {
                print("Good jobs")
            } label: {
                Text("Tap")
            }

            VStack(spacing: 10) {
                ScrollableBottomSheet(
                    minHeight: minHeight,
                    content: {
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
                    },
                    expanded: {
                        print("Expanded")
                    },
                    collapsed: {
                        print("Collapsed")
                    }
                )
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
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                items = Array(0..<7)
                minHeight = 300
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    items = Array(0..<20)
                    minHeight = 200
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        items = Array(0..<10)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollableBottomSheetTestView()
}
