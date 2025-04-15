//
//  TransitionBottomSheet+Test2.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 07/04/25.
//

import Foundation
import SwiftUI

struct AdvancedDemoView: View {
    @State
    private var sheetState: SheetState = .collapsed
    
    var body: some View {
        ZStack {
            // Main background content
            VStack {
                Text("Advanced Sheet Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 15) {
                    Button("Collapsed") {
                        sheetState = .collapsed
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Middle") {
                        sheetState = .middle
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Expanded") {
                        sheetState = .expanded
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                
                Spacer()
            }
            .padding(.top, 50)
            
            // Advanced bottom sheet
            AdvancedTransitionBottomSheet(
                minHeight: 180,
                midHeight: 400,
                maxTopSpace: 50,
                sheetState: $sheetState,
                showDragIndicator: true,
                cornerRadius: 25,
                content1: {
                    // First view (collapsed state)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Task Overview")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Text("75%")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                )
                            
                            VStack(alignment: .leading) {
                                Text("Weekly Progress")
                                    .font(.headline)
                                
                                Text("You're doing great!")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .padding()
                },
                content2: {
                    // Second view (expanded state)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Detailed Tasks")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(1..<10) { index in
                                    taskItem(
                                        title: "Task \(index)",
                                        description: "This is a detailed description for task \(index)",
                                        progress: Double(index) * 10.0,
                                        isPriority: index % 3 == 0
                                    )
                                }
                            }
                        }
                    }
                    .padding()
                }
            )
        }
    }
    
    private func taskItem(title: String, description: String, progress: Double, isPriority: Bool) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                if isPriority {
                    Text("Priority")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ProgressView(value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .padding(.top, 5)
            
            Text("\(Int(progress))% Complete")
                .font(.caption)
                .foregroundColor(.blue)
                .padding(.top, 2)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    AdvancedDemoView()
}
