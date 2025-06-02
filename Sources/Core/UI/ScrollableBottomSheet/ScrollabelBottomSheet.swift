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
    var expand: Bool = false
    var expanded: () -> Void
    var collapsed: () -> Void
    
    init(
        content: @escaping () -> any Content,
        expanded: @escaping () -> Void = {},
        collapsed: @escaping () -> Void = {}
    ) {
        self.body = content
        self.expanded = expanded
        self.collapsed = collapsed
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = ScrollableUIBottomSheet(content: body)
        print(#function, "Make")
        view.onExpanded = expanded
        view.onCollapsed = collapsed
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let view = uiView as? ScrollableUIBottomSheet else { return }
        view.setContent(body)
        view.setNeedsLayout()
        
        if expand {
            view.isExpanded ? () : view.expand(animate: true)
        } else {
            view.isExpanded ? view.collapse(animate: true) : ()
        }
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
