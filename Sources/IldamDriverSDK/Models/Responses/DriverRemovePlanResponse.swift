//
//  DriverRemovePlanResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation

public struct DriverRemovePlanResponse: DNetResBody {
    public let condition: Bool
    public let plan: DriverPlan?
    
    public init(condition: Bool, plan: DriverPlan?) {
        self.condition = condition
        self.plan = plan
    }
}
