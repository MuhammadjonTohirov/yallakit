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
    var routePoints: Set<GMSMarker>?
    var executerPoints: Set<GMSMarker>?
    var otherMarkers: Set<GMSMarker>?
    
    public init(inputCamera: GMapCamera? = nil, outCamera: Binding<GMapCamera?>, options: GMSMapViewOptions, bottomPadding: CGFloat, showMyLocation: Bool, onStartDragging: @escaping () -> Void, onStartMoving: @escaping () -> Void, onEndDragging: @escaping (_: CLLocation) -> Void, routeCoordinates: [RouteDataCoordinate]? = nil, routePoints: Set<GMSMarker>? = nil, executerPoints: Set<GMSMarker>? = nil, otherMarkers: Set<GMSMarker>? = nil, markerInfo viewForMarker: MarkerView?) {
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
        self.otherMarkers = otherMarkers
    }

    public func makeUIViewController(context: Context) -> GMapViewController {
        let vc = GMapViewController(option: options)
        vc.delegate = context.coordinator
        vc.map.isBuildingsEnabled = true
        vc.map.isIndoorEnabled = true
        vc.map.isTrafficEnabled = false
        vc.map.settings.allowScrollGesturesDuringRotateOrZoom = false
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
        private var lastCameraPosition: GMSCameraPosition?
        private var isUserInteracting = false
        
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
            isUserInteracting = gesture

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
        
        @MainActor func drawPolyline(onMap mapView: GMSMapView, coordinates: [RouteDataCoordinate]) {
            if isDrawing || hasDrawn {
                return
            }
            
            self.isDrawing = true
            
            // Clear existing polyline
            if let polyline = self.polyline {
                polyline.map = nil
                self.polyline = nil
            }
            
            // Group consecutive segments by line type
            var currentType: RouteLineType?
            var currentSegment: [CLLocationCoordinate2D] = []
            var segments: [(type: RouteLineType, coordinates: [CLLocationCoordinate2D])] = []
            
            for (index, coordinate) in coordinates.enumerated() {
                // If this is a new segment type or the first coordinate
                if currentType != coordinate.lineType || index == 0 {
                    // Save the previous segment if it exists
                    if !currentSegment.isEmpty && currentType != nil {
                        segments.append((type: currentType!, coordinates: currentSegment))
                    }
                    
                    // Start a new segment
                    currentType = coordinate.lineType
                    currentSegment = [coordinate.coordinate]
                } else {
                    // Continue current segment
                    currentSegment.append(coordinate.coordinate)
                }
                
                // If this is the last coordinate, add the current segment
                if index == coordinates.count - 1 && !currentSegment.isEmpty {
                    segments.append((type: currentType!, coordinates: currentSegment))
                }
            }
            
            // Base color determination based on theme
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
            
            // Create dashed line image for walking segments
            let dashImage = createDashedLineImage(with: lineColor)
            
            // Draw each segment with appropriate style
            for segment in segments {
                let path = GMSMutablePath()
                for coordinate in segment.coordinates {
                    path.add(coordinate)
                }
                
                let polyline = GMSPolyline(path: path)
                polyline.strokeWidth = 5.6
                polyline.geodesic = true
                
                if segment.type == .walkLine {
                    // Apply dashed line style for walking segments
                    if let dashImage = dashImage {
                        let dashStyle = GMSStrokeStyle.transparentStroke(withStamp: GMSSpriteStyle(image: dashImage))
                        polyline.spans = [GMSStyleSpan(style: dashStyle)]
                    } else {
                        // Fallback if image creation fails - use solid line but with different color
                        let walkColor = lineColor.withAlphaComponent(0.7)
                        polyline.strokeColor = walkColor
                    }
                } else {
                    // Create solid line style for car segments
                    let solidStyle = GMSStrokeStyle.solidColor(lineColor)
                    polyline.spans = [GMSStyleSpan(style: solidStyle)]
                }
                
                polyline.map = mapView
                
                // Keep track of the last polyline (for cleaning up later)
                self.polyline = polyline
            }
            
            self.isDrawing = false
            self.hasDrawn = true
        }

        // Helper method to create a dashed line image
        @MainActor
        private func createDashedLineImage(with color: UIColor) -> UIImage? {
            let scale = UIScreen.main.scale
            let width: CGFloat = 20.0
            let height: CGFloat = 5.6
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, scale)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            
            // Clear background
            context.clear(CGRect(x: 0, y: 0, width: width, height: height))
            
            // Draw the dashed line
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(height)
            context.setLineDash(phase: 0, lengths: [8, 6])
            
            context.move(to: CGPoint(x: 0, y: height/2))
            context.addLine(to: CGPoint(x: width, y: height/2))
            context.strokePath()
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        }
        
        func populateRouteMarkers(onMap map: GMSMapView, markers: Set<GMSMarker>) {
            for marker in markers {
                marker.map = map
            }
        }
        
        func populateExecutorMarkers(onMap map: GMSMapView, markers: Set<GMSMarker>) {
            for marker in markers {
                marker.map = map
            }
        }
        
        func populateOtherMarkers(onMap map: GMSMapView, markers: Set<GMSMarker>) {
            for marker in markers {
                marker.map = map
            }
        }
        
        @MainActor
        func deleteOtherMarkers() {
            self.parent.otherMarkers?.forEach({ marker in
                marker.map = nil
            })
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
