//
//  FetchSecondaryAddressesUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 06/03/25.
//

import Foundation
import NetworkLayer

public protocol FetchSecondaryAddressesUseCase {
    func fetch(lat: Double, lng: Double) async throws -> [SecondaryAddressItem]
}

public struct FetchSecondaryAddressUseCaseImpl: FetchSecondaryAddressesUseCase {
    public init() {
        
    }
    
    public func fetch(lat: Double, lng: Double) async throws -> [SecondaryAddressItem] {
        let result: NetRes<[NetResSecondaryAddressItem]>? = try await Network.sendThrow(
            request: Request(
                lat: lat,
                lng: lng
            )
        )
        
        return result?.result?.compactMap {SecondaryAddressItem.init(res: $0)} ?? []
    }
}

extension FetchSecondaryAddressUseCaseImpl {
    struct Request: URLRequestProtocol, Codable {
        let lat: Double
        let lng: Double
        
        enum CodingKeys: CodingKey {
            case lat
            case lng
        }
        
        var url: URL {
            URL.goIldamAPI.appending(path: "/order/secondary-addresses")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: NetworkLayer.HTTPMethod = .post
    }
}

extension URLRequestProtocol {
    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
