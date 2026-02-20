//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/02/26.
//

import Foundation
import NetworkLayer

struct NetResBrandServiceItem: NetResBody, Sendable, Identifiable {
    var id: Int?
    var name: String?
    var photo: String?
}

struct NetReqBrandServices: URLRequestProtocol {
    var body: Data?
    
    var method: NetworkLayer.HTTPMethod = .get
    
    var url: URL {
        URL.goIldamV2API.appending(path: "/list/brand-services")
    }
}

protocol BrandServicesGatewayProtocol: Sendable {
    func load() async throws -> [NetResBrandServiceItem]
}

struct BrandServicesGateway: BrandServicesGatewayProtocol {
    func load() async throws -> [NetResBrandServiceItem] {
        let result: NetRes<[NetResBrandServiceItem]>? = try await Network.sendThrow(request: NetReqBrandServices())
        return result?.result ?? []
    }
}
