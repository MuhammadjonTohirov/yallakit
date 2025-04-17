//
//  GMapsViewWrapper.swift
//  Ildam
//
//  Created by applebro on 27/11/23.
//

import Foundation
import GoogleMaps
import SwiftUI
import Core

public struct GMapCamera {
    public var camera: GMSCameraPosition?
    public var cameraUpdate: GMSCameraUpdate?
    public var animate: Bool
    
    public init(camera: GMSCameraPosition? = nil, cameraUpdate: GMSCameraUpdate?, animate: Bool) {
        self.camera = camera
        self.cameraUpdate = cameraUpdate
        self.animate = animate
    }
}

public struct GMapsViewWrapper: UIViewControllerRepresentable, @unchecked Sendable {
    public typealias MarkerView = (_ mapView: GMSMapView, _ marker: GMSMarker) -> UIView?
    
    var inputCamera: GMapCamera?
    @Binding var outCamera: GMapCamera?
    var options: GMSMapViewOptions
    var bottomPadding: CGFloat
    var showMyLocation: Bool
    var onStartDragging: () -> ()
    var onStartMoving: () -> ()
    var onEndDragging: (_ location: CLLocation) -> ()
    var markerInfoView: MarkerView?

    var routeCoordinates: [RouteDataCoordinate]?
    var routePoints: [GMSMarker]?
    var executerPoints: [GMSMarker]?
    
    public init(inputCamera: GMapCamera? = nil, outCamera: Binding<GMapCamera?>, options: GMSMapViewOptions, bottomPadding: CGFloat, showMyLocation: Bool, onStartDragging: @escaping () -> Void, onStartMoving: @escaping () -> Void, onEndDragging: @escaping (_: CLLocation) -> Void, routeCoordinates: [RouteDataCoordinate]? = nil, routePoints: [GMSMarker]? = nil, executerPoints: [GMSMarker]? = nil, markerInfo viewForMarker: MarkerView?) {
        self.inputCamera = inputCamera
        self._outCamera = outCamera
        self.options = options
        self.bottomPadding = bottomPadding
        self.showMyLocation = showMyLocation
        self.onStartDragging = onStartDragging
        self.onStartMoving = onStartMoving
        self.onEndDragging = onEndDragging
        self.routeCoordinates = routeCoordinates
        self.routePoints = routePoints
        self.executerPoints = executerPoints
        self.markerInfoView = viewForMarker
    }

    public func makeUIViewController(context: Context) -> GMapViewController {
        let vc = GMapViewController(option: options)
        vc.delegate = context.coordinator

        return vc
    }
    
    public func updateUIViewController(_ uiViewController: GMapViewController, context: Context) {
        if let camera = self.inputCamera?.camera {
            let animate = self.inputCamera?.animate ?? false
            
            if animate {
                uiViewController.map.animate(to: camera)
            } else {
                uiViewController.map.camera = camera
            }
        }
        
        if let camera = self.inputCamera?.cameraUpdate {
            let animate = self.inputCamera?.animate ?? false
            
            if animate {
                uiViewController.map.animate(with: camera)
            } else {
                uiViewController.map.moveCamera(camera)
            }
        }
        
        uiViewController.setShowsMyCurrentLocation(to: showMyLocation)
        
        UIView.animate(withDuration: 0.33) {
            uiViewController.map.padding = UIEdgeInsets(
                top: 50,
                left: 0,
                bottom: bottomPadding,
                right: 0
            )
        }
        
        if !(self.routeCoordinates?.isEmpty ?? true) {
            // draw polyline
            context.coordinator.drawPolyline(onMap: uiViewController.map, coordinates: self.routeCoordinates ?? [])
        } else {
            // remove polyline
            context.coordinator.deletePolyline()
        }
        
        if !(self.routePoints?.isEmpty ?? true) {
            // draw markers
            context.coordinator.populateRouteMarkers(onMap: uiViewController.map, markers: self.routePoints ?? [])
        } else {
            // remove markers
            context.coordinator.deleteRouteMarkers()
        }

        if !(self.executerPoints?.isEmpty ?? true) {
            context.coordinator.populateExecutorMarkers(onMap: uiViewController.map, markers: self.executerPoints ?? [])
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, @preconcurrency GMSMapViewDelegate, @unchecked Sendable {
        var parent: GMapsViewWrapper
        private(set) var isDrawing: Bool = false
        private(set) var hasDrawn: Bool = false
        private(set) var polyline: GMSPolyline?
        
        init(parent: GMapsViewWrapper) {
            self.parent = parent
        }
        
        @MainActor public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let lat = position.target.latitude
            let lng = position.target.longitude
            
            Logging.l(tag: "MapViewWrapper", "coordinate: \(lat), \(lng)")
            
            mapView.animate(toViewingAngle: GMapStatics.viewAngle)
            self.parent.outCamera = .init(
                camera: position,
                cameraUpdate: nil,
                animate: false
            )
            
            self.parent.onEndDragging(mapView.locationAtCenter)
        }
        
        public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            debugPrint("Will move \(gesture)")
            
            Task {@MainActor in
                if gesture {
                    self.parent.onStartDragging()
                } else {
                    self.parent.onStartMoving()
                }
            }
        }
        
        func deletePolyline() {
            if let polyline = self.polyline {
                polyline.map = nil
                self.polyline = nil
                self.hasDrawn = false
            }
        }
        
        @MainActor func deleteRouteMarkers() {
            self.parent.routePoints?.forEach({ marker in
                marker.map = nil
            })
        }
        
        func drawPolyline(onMap mapView: GMSMapView, coordinates: [RouteDataCoordinate]) {
            if isDrawing || hasDrawn {
                return
            }
            
            let path = GMSMutablePath()

            self.isDrawing = true
            
            for location in coordinates.map({$0.coordinate}) {
                path.add(location)
            }
            
            //Step 5:
            self.polyline = GMSPolyline(path: path)
            
            var lineColor: UIColor = .black
            
            switch UserSettings.shared.theme {
            case .system:
                lineColor = .label
            case .light:
                lineColor = .black
            case .dark:
                lineColor = .white
            default:
                lineColor = .label
            }
            
            let style = GMSStrokeStyle.solidColor(lineColor)
            
            polyline?.strokeColor = lineColor
            polyline?.strokeWidth = 5.6
            polyline?.geodesic = true
            polyline?.spans = [
                GMSStyleSpan(style: style),
            ]
            polyline?.map = mapView

            self.isDrawing = false
            self.hasDrawn = true
        }
        
        func populateRouteMarkers(onMap map: GMSMapView, markers: [GMSMarker]) {
            for marker in markers {
                marker.map = map
            }
        }
        
        func populateExecutorMarkers(onMap map: GMSMapView, markers: [GMSMarker]) {
            for marker in markers {
                marker.map = map
            }
        }
        
        @MainActor public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
            return parent.markerInfoView?(mapView, marker)
        }
    }
}

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
