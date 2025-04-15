//
//  DraggableBottomSheet+Example.swift
//  Core
//
//  Created by applebro on 11/04/25.
//

import Foundation
import SwiftUI

// Example usage
struct DraggableBottomSheetView: View {
    @State private var isSheetExpanded = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            // Title at the top
            VStack {
                Text("\(Date())")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 60)
                
                Toggle("Show Details", isOn: $isSheetExpanded)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Spacer()
            }
            
            // Our custom bottom sheet
            DraggableBottomSheet(
                minHeight: 200,
                maxTopSpace: 0,
                progress: .constant(0),
                isExpanded: $isSheetExpanded,
                firstView: {
                    // First view (collapsed state)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Task Overview")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 65, height: 65)
                                .overlay(
                                    Text("75%")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Weekly Progress")
                                    .font(.headline)
                                Text("You're doing great!")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                },
                secondView: {
                    // Second view (expanded state)
                    VStack(spacing: 16) {
                        ForEach(1...10, id: \.self) { index in
                            taskItem(
                                index: index,
                                description: "This is a detailed description for task \(index)",
                                progress: CGFloat(index * 10),
                                isPriority: index % 3 == 0
                            )
                            .transaction { transaction in
                                transaction.animation = nil
                            }
                            .onTapGesture {
                                print("Come on in! \(index)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                }
            )
        }
    }
    
    // Task item view
    private func taskItem(index: Int, description: String, progress: CGFloat, isPriority: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Task \(index)")
                    .font(.headline)
                
                Spacer()
                
                if isPriority {
                    Text("Priority")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .cornerRadius(12)
                }
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: (UIScreen.main.bounds.width - 48) * progress / 100, height: 6)
                        .cornerRadius(3)
                }
                
                Text("\(Int(progress))% Complete")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}


#Preview {
    DraggableBottomSheetView()
}
