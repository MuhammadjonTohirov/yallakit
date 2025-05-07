//
//  SendFotoControlGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol SendFotoControlGatewayProtocol {
    func sendPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool
}

struct SendFotoControlGateway: SendFotoControlGatewayProtocol {
    func sendPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool {
        let request = Request(bodyItems: body)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }
    
    struct Request: URLRequestProtocol {
        let bodyItems: [SendFotoControlBodyItem]
        
        var multipartForm: MultipartForm {
            let parts: [MultipartForm.PartFormData] = bodyItems.flatMap { item in
                var fields: [MultipartForm.PartFormData] = []
                
                fields.append(.init(name: "type", value: item.type))
                fields.append(.init(name: "photo_control_id", value: "\(item.photoControlId)"))
                fields.append(.init(name: "file", value: "\(item.file)"))
                
                return fields
            }
            return MultipartForm(parts: parts)
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/photo-control")
        }
        
        var body: Data? {
            multipartForm.bodyData
        }
        
        var method: HTTPMethod { .post }
        
    }
}
