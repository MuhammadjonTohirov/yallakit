//
//  HomeMapViewModel.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import SwiftUI
import GoogleMaps
import Core
import Combine

public enum GMapsUIState {
    case view
    case normal
}

open class GMapsUIModel: ObservableObject, @preconcurrency GMapsUIModelProtocol, GMapsLocationPickerModelProtocol, @unchecked Sendable {
    @Published public var currentLocation: CLLocation?
    @Published public var camera: GMapCamera? {
        didSet {
            debugPrint("GMapsUIModel camera did set", camera.debugDescription)
        }
    }
    @Published public var cameraValue: GMapCamera?
    @Published public var isMapEnabled: Bool = true
    private let defaultZoomLevel: Float = 16.5
    
    @Published public private(set) var state: GMapsUIState = .normal
    @Published public private(set) var hasAddressView: Bool = false
    
    var shouldFocusToCurrentLocation: Bool = false
    lazy var options: GMSMapViewOptions = {
        let opt = GMSMapViewOptions()
        if let currentLocation = GLocationManager.shared.currentLocation {
            opt.camera = .init(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: defaultZoomLevel)
        }
        return opt
    }()
    
    @MainActor
    @Published public private(set) var bottomPadding: CGFloat = 0
    
    @Published
    var pinOffsetY: CGFloat = 0
    
    @Published
    public var showMyLocation: Bool = true
    
    @Published public var isDragging: Bool = false {
        didSet {
            if isDragging {
                Task { @MainActor in
                    self.pinModel.set(state: .pinning)
                }
            }
        }
    }
    
    @Published public var pinModel: PinViewModel = .init()
    
    @Published public var pickedAddress: String = ""
    @Published public var hasAddressPicker: Bool = false 
    
    @Published
    var isMapVisible: Bool = false
    
    @Published public var routeCoordinates: [RouteDataCoordinate]? = []
    @Published public var routeMarkers: [GMSMarker]? = []
    @Published public var executorMarkers: [GMSMarker]? = []
    
    public var pickedLocation: CLLocation?
    
    public weak var delegate: GMapsDelegate?
    
    public init() {
        
    }
    
    func onAppear() {
        Task{ @MainActor in
            bottomPadding = 280 + UIApplication.shared.safeArea.bottom
            await GLocationManager.shared.startUpdatingLocation()
            set(pinOffsetY: (pickerShift - bottomPadding) / 2)
            currentLocationChangeHandler()
       }
     }
    
    private func currentLocationChangeHandler() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onChangeCurrentLocation),
            name: .currentLocation,
            object: nil
        )
    }
    
    @MainActor
    public func set(isMapVisible: Bool) {
        self.isMapVisible = isMapVisible
    }
    
    @objc
    private func onChangeCurrentLocation(_ notification: Notification) {
        guard let _ = notification.object as? CLLocation else {
            return
        }
        
        if self.shouldFocusToCurrentLocation  {
            self.focusToCurrentLocation()
            self.set(shouldFocusToCurrentLocation: false)
        }
        
        if !isMapVisible {
            withAnimation {
                self.isMapVisible = true
            }
        }
    }
    
    open func focusToCurrentLocation(animate: Bool = false, lock: Bool = false) {
        if let loc = GLocationManager.shared.currentLocation {
            focus(toLocation: loc, animate: animate, lock: lock)
        }
    }
    
    open func focus(
        toLocation location: CLLocation,
        maintainZoom: Bool = false,
        animate: Bool = false,
        lock: Bool = false
    ) {
        let currentZoom = cameraValue?.camera?.zoom ?? self.defaultZoomLevel
        Logging.l(tag: "GMapsUIModel", "focus \(location)")
        let camera = GMSCameraPosition.camera(
            withLatitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: maintainZoom ? currentZoom : self.defaultZoomLevel, // Zoom level
            bearing: 0, // Orientation of the camera, 0 means north
            viewingAngle: GMapStatics.viewAngle // Tilt of the camera in degrees
        )
        
        self.camera = .init(
            camera: camera,
            cameraUpdate: nil,
            animate: animate
        )

        self.set(pickedLocation: location)
    }
    
    open func endDragging(with location: CLLocation) {
        self.isDragging = false
        
        if self.hasAddressPicker {
            self.set(pickedLocation: location)
        }

        self.delegate?.onEndDragging(model: self, location)
    }
    
    open func startDragging() {
        self.camera = nil
        
        self.delegate?.onStartDragging(model: self)
        
        DispatchQueue.main.async {
            withAnimation {
                self.isDragging = true
            }
            
            if self.hasAddressPicker {
                self.set(address: "")
            }
        }
    }
    
    open func startMoving() {
        self.delegate?.onStartMoving(model: self)
    }
    
    open func focusTo(coordinates: [CLLocationCoordinate2D], lock: Bool = false) {
        let path = GMSMutablePath()

        for coordinate in coordinates {
            path.add(coordinate)
        }
        
        let bounds = GMSCoordinateBounds(path: path)
        
        self.camera = .init(
            cameraUpdate: GMSCameraUpdate.fit(bounds, withPadding: 50),
            animate: true
        )
        
        Logging.l(tag: "GMapsUIModel", "focus to coordinates")
    }
    
    open func zoomOut() {
        guard let mapCamera = cameraValue?.camera else {
            debugPrint("GMapsUIModel: zoomOut - cameraValue is nil")
            return
        }
        let currentZoom = mapCamera.zoom
        
        guard currentZoom >= 14 else {
            debugPrint(
                "GMapsUIModel: zoomOut - currentZoom (\(currentZoom)) is less than 14"
            )
            return
        }
        
        let update = GMSCameraUpdate.zoom(to: currentZoom - 0.2)
        self.camera = .init(cameraUpdate: update, animate: true)
        
        self.cameraValue = GMapCamera(
            camera: .init(
                latitude: mapCamera.target.latitude,
                longitude: mapCamera.target.longitude,
                zoom: currentZoom - 0.2
            ),
            cameraUpdate: nil,
            animate: false
        )
        
        debugPrint("GMapsUIModel", "zoomOut", currentZoom - 0.2)
    }
    
    @discardableResult
    open func focusToRoute() -> Bool {
        guard let routes = routeCoordinates else {
            return false
        }
        
        // to reduce the number of markers
        // we divide the routes into chunks by `chunkSize` {3}
        
        if !routes.isEmpty {
            focusTo(
                coordinates: routes.chunked(into: 3)
                    .reduce(into: [CLLocationCoordinate2D](), { $0 += $1.map { $0.coordinate } })
            )
            
            return true
        }
        
        return false
    }
    
    open func loadPickedAddressDetails() {
        guard let location = self.pickedLocation else {
            return
        }
        
        Task.detached(priority: .utility) { [weak self] in
            guard let self else {return}
            do {
                if let address = try await MapNetworkService.shared.getAddress(
                    from: location.coordinate.latitude,
                    lng: location.coordinate.longitude)?.name {
                    
                    await MainActor.run {
                        self.set(address: address)
                        
                        self.isDragging = false
                        self.delegate?.onPickAddress(model: self, location, address)
                        self.pinModel.set(state: .initial)
                    }
                }
            } catch {
                
            }
        }
    }
    
    open func set(state: GMapsUIState) {
        self.state = state
        
        switch state {
        case .normal:
            isMapEnabled = true
        case .view:
            isMapEnabled = false
        }
    }
    
    open func set(hasAddressView: Bool) {
        self.hasAddressView = hasAddressView
    }
    
    open func set(hasAddressPicker: Bool) {
        self.hasAddressPicker = hasAddressPicker
    }
    
    @MainActor
    open func set(bottomPadding: CGFloat) {
        self.bottomPadding = bottomPadding
        
        withAnimation(.smooth(duration: 0.2)) {
            self.set(pinOffsetY: (pickerShift - bottomPadding) / 2)
        }
    }
    
    func set(pinOffsetY offset: CGFloat) {
        self.pinOffsetY = offset
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

public extension GRoutePoint {
    static let iconMiddle = UIImage(named: "icon_circle_middle")
    static let iconTo = UIImage(named: "icon_circle_to")
    static let iconFrom = UIImage(named: "icon_circle_from")
    
    /// 0 - from
    /// 1 - middle
    /// 2 - to
    func asMarker(type: Int) -> GMSMarker {
        var icon: UIImage? {
            switch type {
            case 0:
                return GRoutePoint.iconFrom
            case 1:
                return GRoutePoint.iconMiddle
            case 2:
                return GRoutePoint.iconTo
            default:
                return nil
            }
        }
        let marker = GMSMarker()
        let c = self.location.coordinate
        marker.position = CLLocationCoordinate2D(latitude: c.latitude, longitude: c.longitude)
        marker.icon = icon
        marker.map = nil
        return marker
    }
}

public extension GMapsUIModel {
    func set(shouldFocusToCurrentLocation: Bool) {
        self.shouldFocusToCurrentLocation = shouldFocusToCurrentLocation
    }
}

public extension CLLocation {
    func isEqual(to: CLLocation) -> Bool {
        let llat = Int(self.coordinate.latitude * 100000)
        let llong = Int(self.coordinate.longitude * 100000)
        let tlat = Int(to.coordinate.latitude * 100000)
        let tlong = Int(to.coordinate.longitude * 100000)
        
        return llat == tlat && llong == tlong
    }
}
