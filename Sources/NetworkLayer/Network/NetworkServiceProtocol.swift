//
//  NetworkServiceProtocol.swift
//  NetworkLayer
//
//  Created by applebro on 09/09/24.
//

import Foundation

protocol NetworkServiceProtocol {
    associatedtype S = URLRequestProtocol
}

extension Error {
    static func unknown() -> Error {
        return NSError(domain: "Unknown error", code: -1)
    }
    
    static func create(with message: String, code: Int) -> NSError {
        return NSError(domain: message, code: code)
    }
}

public extension Error {
    var message: String {
        return (self as NSError).domain.nilIfEmpty ?? localizedDescription
    }
    
    var serverMessage: String {
        (self as? NetworkError)?.localizedDescription ?? self.message
    }
}

public enum NetworkError: Error {
    case emptyResponse
    case custom(message: String, code: Int = -1)
    case notFounded
    case unauthorized
    case timeout
    
    var localizedDescription: String {
        switch self {
        case .custom(let message, _):
            return message
        case .unauthorized:
            return "Unauthorized"
        case .timeout:
            return "Timeout"
        case .emptyResponse:
            return "Empty response"
        case .notFounded:
            return "Page not Founded"
        }
    }
    
    var code: Int {
        switch self {
        case .custom(_, let code):
            return code
        case .unauthorized:
            return 401
        case .timeout:
            return -2
        case .emptyResponse:
            return 0
        case .notFounded:
            return 404
        }
    }
}
