//
//  RegionListUseCaseProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//


public protocol DriverRegionListServiceUseCaseProtocol {
    func fetchRegionList() async throws -> [ExecutorRegionServiceListResponse]
}
public final class DriverRegionListServiceUseCase: DriverRegionListServiceUseCaseProtocol {
    
    private let gateway: RegionListGatewayProtocol
    
    init(gateway: RegionListGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = RegionListGateway()
    }
    
    public func fetchRegionList() async throws -> [ExecutorRegionServiceListResponse] {
        
        let result = try await gateway.fetchRegions()
        
        return result.map(ExecutorRegionServiceListResponse.init)
    }
 
}
