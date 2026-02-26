//
//  SelectableList.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 09/04/25.
//

import Foundation
import SwiftUI
import Combine

// Model for our list items
struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool
}

// View model to hold our data
class ListViewModel: ObservableObject {
    @Published var items: [ListItem]
    private var cancellables: Set<AnyCancellable> = []
    init() {
        // Initialize with some sample data
        self.items = [
            ListItem(title: "Item 1", isSelected: false),
            ListItem(title: "Item 2", isSelected: true),
            ListItem(title: "Item 3", isSelected: false),
            ListItem(title: "Item 4", isSelected: false),
            ListItem(title: "Item 5", isSelected: true)
        ]
        
        setupSubscription()
    }
    
    // Function to toggle an item's selection state
    func toggleItem(at index: Int) {
        items[index].isSelected.toggle()
    }
    
    private func setupSubscription() {
        $items
            .sink { _ in }
            .store(in: &cancellables)
    }
}

// Row view for each item
struct ItemRow: View {
    let item: ListItem
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(item.title)
                .font(.headline)
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { item.isSelected },
                set: { _ in onToggle() }
            ))
            .labelsHidden()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.secondarySystemBackground))
        )
    }
}

// Main view with the list
struct SelectableListView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                        ItemRow(item: item, onToggle: {
                            viewModel.toggleItem(at: index)
                        })
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
                
                // Display the selected items
                VStack(alignment: .leading) {
                    Text("Selected Items:")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    ForEach(viewModel.items.filter { $0.isSelected }) { item in
                        Text("• \(item.title)")
                    }
                    
                    if viewModel.items.filter({ $0.isSelected }).isEmpty {
                        Text("None selected")
                            .italic()
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
                .padding()
            }
            .navigationTitle("Selectable List")
        }
    }
}

#Preview {
    SelectableListView()
}
