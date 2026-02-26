//
//  FindExecutorsUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 03/01/25.
//

import Foundation

public protocol FindExecutorsUseCaseProtocol: Sendable {
    func getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors?
}

public struct FindExecutorsUseCase: FindExecutorsUseCaseProtocol, Sendable {
    public static let shared: FindExecutorsUseCaseProtocol = FindExecutorsUseCase()

    private let gateway: FindExecutorsGatewayProtocol

    public init() {
        self.gateway = FindExecutorsGateway()
    }

    init(gateway: FindExecutorsGatewayProtocol) {
        self.gateway = gateway
    }

    public func getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors? {
        debugPrint("GetExecutors", "Real")

        guard let result = await gateway.findExecutors(req: .init(tariffOptions: options, tariffId: tariffId, lat: lat, lng: lng)) else {
            return nil
        }

        return .init(timeout: result.timeout, executors: result.executors?.map({.init(id: $0.id, heading: $0.heading, lat: $0.lat, lng: $0.lng, distance: $0.distance)}) ?? [])
    }
}
