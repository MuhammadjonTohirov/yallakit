//
//  GMapsUIModelProtocol.swift
//  Ildam
//
//  Created by applebro on 01/02/24.
//

import Foundation
import Core
import GoogleMaps

public protocol GMapsDelegate: AnyObject, Sendable {
    func onPickAddress(model: GMapsUIModel, _ location: CLLocation, _ address: String)
    func onEndDragging(model: GMapsUIModel, _ location: CLLocation)
    func onStartDragging(model: GMapsUIModel)
    func onStartMoving(model: GMapsUIModel)
    
    func onFocusToRoute()
}

public extension GMapsDelegate {
    func onEndDragging(model: GMapsUIModel, _ location: CLLocation) {}
    func onStartDragging(model: GMapsUIModel) {}
    func onFocusToRoute() {}
    func onPickAddress(
        model: IMap.GMapsUIModel,
        _ location: CLLocation,
        _ address: String
    ) {
        
    }
    
    func onStartMoving(model: GMapsUIModel) {}
}

public protocol GMapsUIModelProtocol: AnyObject, Sendable {
    var pickedLocation: CLLocation? {get set}
    var pickedAddress: String {get set}
    var hasAddressPicker: Bool {get}
    var hasAddressView: Bool {get}
    var isDragging: Bool {get set}
    var bottomPadding: CGFloat {get}
    var delegate: GMapsDelegate? {get set}
    var pinModel: PinViewModel {get set}
    var isMapEnabled: Bool {get set}
    var state: GMapsUIState {get}
    
    var routeCoordinates: [RouteDataCoordinate]? {get set}
    
    var routeMarkers: [GMSMarker]? {get set}
    
    var executorMarkers: [GMSMarker]? {get set}
    
    func set(hasAddressView: Bool)
    
    func set(hasAddressPicker: Bool)
    
    func set(delegate: GMapsDelegate)
    
    func set(address: String)
    
    func set(routeMarkers: [GMSMarker]?)
    
    func set(pickedLocation: CLLocation)
    
    func set(location: CLLocationCoordinate2D, rotation: CLLocationDegrees, toExecutorId id: String)
    
    func loadPickedAddressDetails()
    
    func focusToCurrentLocation(animate: Bool, lock: Bool)
    
    func focus(toLocation location: CLLocation, maintainZoom: Bool, animate: Bool, lock: Bool)
    
    func set(state: GMapsUIState)
    
    func focusTo(coordinates: [CLLocationCoordinate2D], lock: Bool)
    
    @discardableResult
    func focusToRoute() -> Bool
    
    func clearRouteAndMarkers()
    
    func set(bottomPadding: CGFloat)
}

public protocol GMapsLocationPickerModelProtocol {
    var pickedLocation: CLLocation? {get}
    var pickedAddress: String {get}
    
    func focusToCurrentLocation(animate: Bool, lock: Bool)
}

public extension GMapsUIModelProtocol {
    @MainActor
    func set(location: CLLocationCoordinate2D, rotation: CLLocationDegrees, toExecutorId id: String) {
        self.executorMarkers?.forEach({ marker in
            if marker.accessibilityLabel == id {
                marker.position = location
                marker.rotation = rotation
            }
        })
    }
}
