//
//  FindExecutorsUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 03/01/25.
//

import Foundation

public protocol FindExecutorsUseCaseProtocol {
    func getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors?
}

public struct FindExecutorsUseCase: FindExecutorsUseCaseProtocol {
    
    public func getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors? {
        debugPrint("GetExecutors", "Real")
        
        guard let result = await FindExecutorsGateway().findExecutors(req: .init(tariffOptions: options, tariffId: tariffId, lat: lat, lng: lng)) else {
            return nil
        }
        
        return .init(timeout: result.timeout, executors: result.executors?.map({.init(id: $0.id, heading: $0.heading, lat: $0.lat, lng: $0.lng, distance: $0.distance)}) ?? [])
    }
}

public struct FindExecutorsMockUseCase: FindExecutorsUseCaseProtocol {
    public init() {
        
    }
    public func getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors? {
        debugPrint("GetExecutors", "Mock")
        return .init(timeout: 50, executors: [
            .init(
                id: 0,
                heading: 10,
                lat: 40.3838485874778,
                lng: 71.78310088813305,
                distance: 1
            )
        ])
    }
}
