//
//  ExecutorChangeAvatarUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol UploadExecutorAvatarUseCaseProtocol {
    func execute(photoData: Data, fileName: String) async throws -> ExecutorAvatarResponse
}
public final class UploadExecutorAvatarUseCase: UploadExecutorAvatarUseCaseProtocol {
    
    private let gateway: ExecutorAvatarGatewayProtocol
    
    init(gateway: ExecutorAvatarGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorAvatarGateway()
    }
    
    public func execute(photoData: Data, fileName: String) async throws -> ExecutorAvatarResponse {
        
        let response = try await gateway.uploadAvatar(photo: photoData, fileName: fileName)
        
        return ExecutorAvatarResponse(from: response)
    }
}
