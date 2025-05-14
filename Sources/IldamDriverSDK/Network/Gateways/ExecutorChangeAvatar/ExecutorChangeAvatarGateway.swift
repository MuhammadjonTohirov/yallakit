//
//  ExecutorChangeAvatarGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation
import NetworkLayer

protocol ExecutorAvatarGatewayProtocol {
    func uploadAvatar(photo: Data, fileName: String) async throws -> DNetExecutorAvatarResponse
}

struct ExecutorAvatarGateway: ExecutorAvatarGatewayProtocol {
    func uploadAvatar(photo: Data, fileName: String) async throws -> DNetExecutorAvatarResponse {
        let part = MultipartForm.PartFormData(
            name: "file",
            data: photo,
            filename: fileName,
            contentType: "image/jpeg"
        )
        let form = MultipartForm(parts: [part])
        
        let request = Request(form: form)
        let response: NetRes<DNetExecutorAvatarResponse>? = try await Network.sendThrow(request: request)
        
        guard let result = response?.result else {
            throw NSError(domain: "Upload avatar failed", code: -1)
        }
        
        return result
    }

    struct Request: URLRequestProtocol {
        let form: MultipartForm

        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/avatar")
        }

        var body: Data? { form.bodyData }

        var method: HTTPMethod { .post }
    }
}
