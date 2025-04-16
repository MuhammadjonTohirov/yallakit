//
//  HomeMapView.swift
//  Ildam
//
//  Created by applebro on 04/12/23.
//

import Foundation
import SwiftUI
import Core

let pickerShift: CGFloat = 50

public struct GMapsUI: View {
    @StateObject var viewModel: GMapsUIModel
    
    public init(viewModel: GMapsUIModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            GMapsViewWrapper(
                inputCamera: viewModel.camera,
                outCamera: $viewModel.cameraValue,
                options: viewModel.options,
                bottomPadding: viewModel.bottomPadding,
                showMyLocation: viewModel.showMyLocation,
                onStartDragging: {
                    viewModel.startDragging() 
                },
                onStartMoving: {
                    viewModel.startMoving()
                },
                onEndDragging: { location in
                    Logging.l("End dragging \(location)")
                    viewModel.endDragging(with: location)
                },
                routeCoordinates: viewModel.routeCoordinates,
                routePoints: viewModel.routeMarkers,
                executerPoints: viewModel.executorMarkers
            )
            .allowsHitTesting(viewModel.isMapEnabled)
            .onAppear {
                onAppear()
            }
            .ignoresSafeArea(edges: .all)
            
            addressView
                .visibility(viewModel.hasAddressView)
                .ignoresSafeArea(.keyboard, edges: .all)
            
            PinView(vm: viewModel.pinModel)
                .offset(y: viewModel.pinOffsetY)
                .visibility(viewModel.hasAddressPicker)
                .ignoresSafeArea(.keyboard, edges: .all)
        }
        .opacity(viewModel.isMapVisible ? 1 : 0)
    }
    
    private var addressView: some View {
        Text(viewModel.pickedAddress.isEmpty ? "loading".localize : viewModel.pickedAddress)
            .lineLimit(1)
            .foregroundStyle(Color.white)
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, Padding.small * 1.3)
            .padding(.vertical, Padding.small / 2)
            .background {
                Capsule()
                    .foregroundStyle(Color.iAction)
            }
            .offset(y: -viewModel.bottomPadding / 2 - 80)
            .padding(.horizontal, Padding.medium)
            .allowsHitTesting(false)
            .opacity(viewModel.hasAddressPicker ? 1 : 0)

    }
    
    private func onAppear() {
        self.viewModel.onAppear()
    }
}

#Preview {
    ZStack {
        Text("viewModel.pickedAddress.isEmpty ? loading.localize : viewModel.pickedAddress")
            .lineLimit(1)
            .foregroundStyle(Color.white)
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, Padding.small * 1.3)
            .padding(.vertical, Padding.small / 2)
            .background {
                Capsule()
                    .foregroundStyle(Color.iAction)
            }
            .padding(.horizontal, Padding.medium)
            .allowsHitTesting(false)
            .offset(y: -100)

        ZStack {
            PinView(vm: PinViewModel())
        }
    }
}
