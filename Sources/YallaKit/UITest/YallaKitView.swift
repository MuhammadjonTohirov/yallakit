//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 16/04/25.
//

import Foundation
import SwiftUI

struct YallaKitView: View {
    @StateObject var viewModel = YallaKitViewModel()
    @State
    private var isKeySetup: Bool = false
    var body: some View {
        Group {
            if isKeySetup {
                GMapsUI(viewModel: viewModel.mapViewModel)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            // Initialize Google Maps
//            GMSServicesConfig.setupAPIKey()
//            isKeySetup = true
        }
    }
}

#if DEBUG
#Preview {
    YallaKitView()
}
#endif
