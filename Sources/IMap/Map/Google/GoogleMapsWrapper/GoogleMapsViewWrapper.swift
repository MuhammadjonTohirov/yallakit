//
//  GMapsViewWrapper.swift
//  Ildam
//
//  Created by applebro on 27/11/23.
//

import Foundation
import GoogleMaps
import SwiftUI

public struct GoogleMapsViewWrapper: UIViewControllerRepresentable, @unchecked Sendable {
    public typealias MarkerView = (_ mapView: GMSMapView, _ marker: GMSMarker) -> UIView?
    @ObservedObject var viewModel: GoogleMapsViewWrapperModel
    var options: GMSMapViewOptions

    public init(viewModel: GoogleMapsViewWrapperModel, options: GMSMapViewOptions) {
        self.viewModel = viewModel
        self.options = options
    }

    public func makeUIViewController(context: Context) -> GoogleMapViewController {
        let vc = GoogleMapViewController(option: options)
        vc.delegate = viewModel
        vc.map.isBuildingsEnabled = true
        vc.map.isIndoorEnabled = true
        vc.map.isTrafficEnabled = false
        vc.map.settings.allowScrollGesturesDuringRotateOrZoom = false
        viewModel.set(map: vc.map)
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: GoogleMapViewController, context: Context) {

    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, @unchecked Sendable {
        var parent: GoogleMapsViewWrapper

        init(parent: GoogleMapsViewWrapper) {
            self.parent = parent
        }
    }
}
