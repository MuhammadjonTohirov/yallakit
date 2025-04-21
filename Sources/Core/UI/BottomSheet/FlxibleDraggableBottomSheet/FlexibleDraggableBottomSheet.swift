import Foundation
import SwiftUI

class FlexibleSheetViewModel: ObservableObject {
    
    enum SheetPosition {
        case partial, full
    }

    @Published var contentHeight: CGFloat = .zero
    @Published var dragOffset: CGFloat = 0
    @Published var currentPosition: SheetPosition = .partial
}

public enum PartialHeight {
    case percentage(CGFloat)
    case fixed(CGFloat)
    
    var value: CGFloat {
        switch self {
        case .percentage(let value):
            return value
        case .fixed(let value):
            return value
        }
    }
}

public struct FlexibleBottomSheet<Content: View>: View {
    private let content: Content
    private let bottomButton: (() -> AnyView)?
    private let initiallyPartial: Bool
    private var partialHeight: PartialHeight
    private var partialHeightValue: CGFloat {
        switch partialHeight {
            case .percentage(let value):
            return viewModel.contentHeight * value
        case .fixed(let value):
            return value
        }
    }
    private let isDraggingEnabled: Bool
    private let hasHandle: Bool
    private var backgroundColor: Color
    
    var header: (any View)?
    
    @StateObject private var viewModel = FlexibleSheetViewModel() // 🔹 Use @StateObject
    @State private var didAppear: Bool = false
    // Initializer with dragging toggle
    public init(
        initiallyPartial: Bool = true,
        partialHeightRatio: CGFloat = 0.4,
        isDraggingEnabled: Bool = true,
        hasHandle: Bool = true,
        backgroundColor: Color = .white,
        content: () -> Content,
        @ViewBuilder bottomButton: @escaping () -> some View
    ) {
        self.initiallyPartial = initiallyPartial
        self.partialHeight = .percentage(max(0.1, min(partialHeightRatio, 0.9)))
        self.isDraggingEnabled = isDraggingEnabled
        self.hasHandle = hasHandle
        self.backgroundColor = backgroundColor
        self.content = content()
        self.bottomButton = { AnyView(bottomButton()) }
    }
    
    public init(
        initiallyPartial: Bool = true,
        partialHeightRatio: CGFloat = 0.4,
        isDraggingEnabled: Bool = true,
        hasHandle: Bool = true,
        backgroundColor: Color = .white,
        content: () -> Content
    ) {
        self.initiallyPartial = initiallyPartial
        self.partialHeight = .percentage(max(0.1, min(partialHeightRatio, 0.9)))
        self.isDraggingEnabled = isDraggingEnabled
        self.hasHandle = hasHandle
        self.backgroundColor = backgroundColor
        self.content = content()
        self.bottomButton = nil
    }

    public var body: some View {
        VStack(spacing: 0) {
            if didAppear {
                geometryBody
                
                if let bottomButton = bottomButton {
                    bottomButton()
                }
            }
        }.onAppear {
            viewModel.currentPosition = initiallyPartial ? .partial : .full
            didAppear = true
        }
    }
    
    private var geometryBody: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                
                VStack(spacing: 0) {
                    if let header = self.header {
                        AnyView(header)
                    }
                    
                    VStack {
                        if hasHandle {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 40, height: 5)
                                .cornerRadius(2.5)
                                .padding(.top, 4)
                                .padding(.bottom, 12)
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundStyle(backgroundColor)
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .frame(height: 30)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)

                            content
                        }
                        .background(contentGeoReader)
                    }
                    .background(
                        Rectangle()
                            .foregroundStyle(backgroundColor)
                            .cornerRadius(30, corners: [.topLeft, .topRight])
                            .edgesIgnoringSafeArea(.bottom)
                    )
                }
                .offset(y: calculateSheetOffset())
                .gesture(
                    isDraggingEnabled ? dragGesture : nil
                )
            }
            .onAppear {
                viewModel.contentHeight = geometry.size.height
            }
        }
    }
    
    private var contentGeoReader: some View {
        GeometryReader { contentGeometry in
            Color.clear
                .onAppear {
                    DispatchQueue.main.async {
                        viewModel.contentHeight = contentGeometry.size.height + 60
                    }
                }
                .onChange(of: contentGeometry.size.height) { newHeight in
                    DispatchQueue.main.async {
                        withTransaction(Transaction(animation: nil)) {
                            viewModel.contentHeight = newHeight + 60
                        }
                    }
                }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let maxDragUp = viewModel.currentPosition == .partial ? -partialHeightValue : 0
                let maxDragDown = viewModel.currentPosition == .full ? partialHeightValue : 0
                
                let newOffset = min(
                    max(value.translation.height, maxDragUp),
                    maxDragDown
                )
                
                if abs(newOffset - viewModel.dragOffset) > 1 { // Prevent rapid updates causing flicker
                    withTransaction(Transaction(animation: nil)) {
                        viewModel.dragOffset = newOffset
                    }
                }
            }
            .onEnded { _ in
                handleDragEnd()
            }
    }
    
    private func handleDragEnd() {
        let dragThreshold: CGFloat = 50
        
        withAnimation(.linear(duration: 0.2)) {
            if viewModel.currentPosition == .partial {
                if viewModel.dragOffset < -dragThreshold {
                    viewModel.currentPosition = .full
                }
            } else if viewModel.currentPosition == .full {
                if viewModel.dragOffset > dragThreshold {
                    viewModel.currentPosition = .partial
                }
            }
            viewModel.dragOffset = 0
        }
    }
    
    private func calculateSheetOffset() -> CGFloat {
        let partialOffset = viewModel.contentHeight - partialHeightValue
        let baseOffset = viewModel.currentPosition == .partial ? partialOffset : 0
        return max(baseOffset + viewModel.dragOffset, 0)
    }
}

// Example implementation with isDraggingEnabled parameter
struct RideStatusView: View {
    // State to toggle between basic and detailed views
    @State private var showDriverDetails = false
    private var hasButton: Bool = false
    
    // Add control for dragging
    private var isDraggingEnabled: Bool = true
    
    private var partialRatio: CGFloat {
        guard hasButton else {
            return 0.5
        }
        
        return showDriverDetails ? 0.5 : 1
    }
    var body: some View {
        FlexibleBottomSheet(
            initiallyPartial: true,
            partialHeightRatio: partialRatio,
            isDraggingEnabled: isDraggingEnabled, // Use the new parameter
            content: {
                content
            },
            bottomButton: {
                Button(action: {

                }) {
                    Text("button.title")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
            }
        )
        .set(headerView: {Text("come on")})
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Search status
            Text("Поиск автомобиля")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 4)
                .allowsHitTesting(false)

            Text("Оставшееся время ожидания 5 минут")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 4)
                .allowsHitTesting(false)

            // Progress bar
            HStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 20, height: 5)
                    .cornerRadius(2.5)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 5)
                    .cornerRadius(2.5)
            }
            .padding(.bottom, 8)
            .allowsHitTesting(false)

            // Driver details (shown conditionally)
            if showDriverDetails {
                driverDetails
            }
            
            // Ensure enough content for scroll on smaller sheets
            if !showDriverDetails {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 60)
            }
        }
        .padding(.bottom, 60)
        .onAppear {
            // Simulate driver details appearing after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showDriverDetails = true
                }
            }
        }
    }
    @ViewBuilder
    private var driverDetails: some View {
        Divider()
            .padding(.vertical, 8)
        
        Text("ВОДИТЕЛЬ")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.top, 8)
        
        Text("Hikmatulloh OFI K Khakimov Shuhratbekovich")
            .font(.body)
            .padding(.bottom, 8)
        
        // Action buttons
        Button(action: {
            // Cancel action
            debugPrint("Cancel")
        }) {
            HStack {
                Image(systemName: "xmark")
                Text("Отменить заказ")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 12)
        
        Divider()
        
        Button(action: {
            // Order more action
        }) {
            HStack {
                Image(systemName: "plus")
                Text("Заказать ещё")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 12)
        
        Divider()
        
        Button(action: {
            // Trip info action
        }) {
            HStack {
                Image(systemName: "info.circle")
                Text("Информация о поездке")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 12)
    }
}

public extension FlexibleBottomSheet {
    func set(headerView: () -> some View) -> Self {
        var view = self
        view.header = headerView()
        return view
    }
    
    func set(partialHeight: PartialHeight) -> Self {
        var view = self
        view.partialHeight = partialHeight
        return view
    }
}

#Preview {
    RideStatusView()
}
