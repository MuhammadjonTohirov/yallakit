//
//  ExecutorNetworkService.swift
//  IldamSDK
//
//  Created on 26/02/26.
//

import Foundation
import Core
import NetworkLayer

public protocol ExecutorNetworkServiceProtocol: Sendable {
    func findExecutors(tariffId: Int?, options: [Int], coord: Coord) async -> TaxiExecutors?
}

public struct ExecutorNetworkService: ExecutorNetworkServiceProtocol, Sendable {
    public static let shared: ExecutorNetworkServiceProtocol = ExecutorNetworkService()

    private let findExecutorsUseCase: FindExecutorsUseCaseProtocol

    public init(
        findExecutorsUseCase: FindExecutorsUseCaseProtocol = FindExecutorsUseCase()
    ) {
        self.findExecutorsUseCase = findExecutorsUseCase
    }

    public func findExecutors(tariffId: Int?, options: [Int], coord: Coord) async -> TaxiExecutors? {
        await findExecutorsUseCase.getExecutors(
            tariffId: tariffId,
            lat: coord.lat,
            lng: coord.lng,
            options: options
        )
    }
}
