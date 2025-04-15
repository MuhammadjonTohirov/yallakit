//
//  TransitionBottomSheet+Test.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 07/04/25.
//

import Foundation
import SwiftUI

struct TestTransitionBottomSheet: View {
    var body: some View {
        ZStack {
            // Main background content
            mainContent
            
            // Our custom bottom sheet
            TransitionBottomSheet(
                minHeight: 250,  // Minimum height in collapsed state
                maxTopSpace: 0,  // No space at top when fully expanded
                content1: {
                    collapsedSheetContent()
                },
                content2: {
                    expandedSheetContent()
                }
            )
        }
    }
    
    private var mainContent: some View {
        VStack {
            Text("Main Content")
                .font(.largeTitle)
                .foregroundColor(.primary)
            
            Text("Drag the sheet upward to see it transition")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
            
            Image(systemName: "arrow.down.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .padding()
            
            Spacer()
        }
        .padding(.top, 50)
    }
    
    private func collapsedSheetContent() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Summary")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 12) {
                summaryCard(
                    icon: "thermometer",
                    title: "Temperature",
                    value: "72°F",
                    color: .orange
                )
                
                summaryCard(
                    icon: "humidity.fill",
                    title: "Humidity",
                    value: "45%",
                    color: .blue
                )
            }
            
            Text("Drag up for detailed information")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
        }
        .padding()
    }
    
    private func expandedSheetContent() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Detailed Information")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    detailRow(title: "Temperature", value: "72°F (22°C)", icon: "thermometer")
                    detailRow(title: "Humidity", value: "45%", icon: "humidity.fill")
                    detailRow(title: "Wind", value: "8 mph NE", icon: "wind")
                    detailRow(title: "Precipitation", value: "10% chance", icon: "cloud.rain")
                    detailRow(title: "UV Index", value: "Moderate", icon: "sun.max.fill")
                    detailRow(title: "Visibility", value: "12 miles", icon: "eye.fill")
                    detailRow(title: "Pressure", value: "1012 hPa", icon: "gauge")
                    
                    Text("Hourly Forecast")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(1..<12) { hour in
                                hourlyForecast(
                                    hour: "\(hour + 8):\(hour % 2 == 0 ? "00" : "30")",
                                    icon: hour % 4 == 0 ? "cloud.sun.fill" : (hour % 3 == 0 ? "cloud.fill" : "sun.max.fill"),
                                    temp: "\(60 + hour)°"
                                )
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
    
    private func summaryCard(icon: String, title: String, value: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            Spacer()
        }
        .padding()
        .frame(height: 80)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private func detailRow(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private func hourlyForecast(hour: String, icon: String, temp: String) -> some View {
        VStack(spacing: 8) {
            Text(hour)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.yellow)
            
            Text(temp)
                .font(.callout)
                .fontWeight(.medium)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
    }
}

#Preview {
    TestTransitionBottomSheet()
}
