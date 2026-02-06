//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 06/02/26.
//

import Foundation
import NetworkLayer

protocol RatingReasonGatewayProtocol: Sendable {
    func load() async throws -> [NetResRatingReasonsItem]
}

struct RatingReasonGateway: RatingReasonGatewayProtocol {
    func load() async throws -> [NetResRatingReasonsItem] {
        let result: NetRes<[NetResRatingReasonsItem]>? = try await Network.sendThrow(request: Request())
        return result?.result ?? []
    }
}

extension RatingReasonGateway {
    struct Request: URLRequestProtocol {
        var body: Data? = nil
        var method: HTTPMethod = .get
        
        var url: URL {
            .baseAPI.appending(component: "/list/rating-reasons")
        }
    }
}

