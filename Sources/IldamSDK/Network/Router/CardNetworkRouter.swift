//
//  CardNetworkRouter.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 23/11/24.
//

import Foundation
import Core
import NetworkLayer

enum CardNetworkRouter: URLRequestProtocol {
    var url: URL {
        switch self {
        case .addCard:
            return URL.goIldamAPI.appendingPath("my", "card", "add")
        case .validateCard:
            return URL.goIldamAPI.appendingPath("card", "verify")
        case .cardList:
            return URL.goIldamAPI.appendingPath("my", "card", "list")
            
        // MARK: Depricated
        case .selectDefaultCard(let cardId):
            return URL.goIldamAPI.appendingPath("select", "default", "card", "\(cardId)")
        }
    }
    
    var body: Data? {
        switch self {
        case let .addCard(number, expiry):
            return NetReqAddCard.init(number: number, expiry: expiry).asData
        case let .validateCard(key, code):
            return NetReqCardVerify.init(key: key, confirmCode: code).asData
        case .cardList:
            return nil
            
        // MARK: Depricated
        case .selectDefaultCard:
            return nil
        }
    }
    
    var method: NetworkLayer.HTTPMethod {
        switch self {
        case .addCard, .validateCard:
            return .post
        case .cardList:
            return .get
        case .selectDefaultCard:
            return .put
        }
    }
    
    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
    
    case addCard(number: String, expiry: String)
    case validateCard(key: String, code: String)
    case cardList
    case selectDefaultCard(id: String)
}
