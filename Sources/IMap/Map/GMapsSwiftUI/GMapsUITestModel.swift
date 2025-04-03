//
//  GMapsUITestModel.swift
//  Ildam
//
//  Created by applebro on 01/02/24.
//

import Foundation
import CoreLocation

public class GMapsUITestModel: GMapsUIModel {
    public override var pickedLocation: CLLocation? {
        set {
            
        }

        get {
            return .init(latitude: 40.382156117497, longitude: 71.782481968403)
        }
    }
}
