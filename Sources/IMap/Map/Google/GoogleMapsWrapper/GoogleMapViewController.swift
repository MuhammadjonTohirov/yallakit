//
//  MapViewController.swift
//  Ildam
//
//  Created by applebro on 27/11/23.
//

import Foundation
import UIKit
import GoogleMaps
import Core

public class GoogleMapViewController: UIViewController {
    private var options: GoogleMaps.GMSMapViewOptions
    lazy var map = {
        GMSServicesConfig.setupAPIKey()
        Logging.l("GMaps \(GMSServices.sdkVersion())")
        return GMSMapView.init(options: options)
    }()
    
    var isAnimating: Bool = false
    
    weak var delegate: GMSMapViewDelegate? {
        didSet {
            map.delegate = delegate
        }
    }
    
    public init(option: GoogleMaps.GMSMapViewOptions) {
        self.options = option
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(map)
        map.settings.rotateGestures = true
        map.settings.tiltGestures = false
        
        changeMapStyle(by: traitCollection.userInterfaceStyle)
        
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin]
        map.isBuildingsEnabled = true
        
        map.isMyLocationEnabled = true
        
        map.animate(toViewingAngle: GMapStatics.viewAngle)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            changeMapStyle(by: traitCollection.userInterfaceStyle)
        }
    }
    
    private func changeMapStyle(by interface: UIUserInterfaceStyle) {
        switch interface {
        case .unspecified:
            map.mapStyle = try! GMSMapStyle.init(jsonString: GMapStyles.default)
        case .light:
            map.mapStyle = try! GMSMapStyle.init(jsonString: GMapStyles.default)
        case .dark:
            map.mapStyle = try! GMSMapStyle.init(jsonString: GMapStyles.night)
        @unknown default:
            break
        }
    }
    
    open func focus(toLocation location: CLLocation) {
        map.animate(toLocation: location.coordinate)
        map.animate(toViewingAngle: GMapStatics.viewAngle)
    }
    
    open func setShowsMyCurrentLocation(to value: Bool) {
        map.isMyLocationEnabled = value
    }
}
