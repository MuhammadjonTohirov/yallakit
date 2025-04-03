//
//  AuthNetworkRoute.swift
//  Ildam
//
//  Created by applebro on 09/12/23.
//

import Foundation
import Core
import NetworkLayer

enum AuthNetworkRoute: URLRequestProtocol {
    var url: URL {
        switch self {
        case .sendOTP:
            return URL.baseAPICli.appendingPath("client")
        case .validate:
            return URL.baseAPICli.appendingPath("valid")
        case .getMeInfo:
            return URL.baseAPICli.appendingPath("me")
        case .logout:
            return URL.baseAPICli.appendingPath("logout")
        case .register:
            return URL.baseAPICli.appendingPath("register")
        case .changeAvatar:
            return URL.baseAPICli.appendingPath("change-avatar")
        case .updateProfile:
            return URL.baseAPICli.appendingPath("update")
        }
    }
    
    var body: Data? {
        switch self {
        case .sendOTP(let req):
            return req.asData
        case .validate(let req):
            return req.asData
        case .register(let req):
            return req.asData
        case .updateProfile(let givenNames, let surName, let birthday, let gender, let image):
            return NetReqUpdateProfile.init(givenNames: givenNames, surName: surName, birthday: birthday, gender: gender, image: image).asData
        case .changeAvatar(let form):
            return form.bodyData
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .updateProfile:
            return .put
        default:
            return .post
        }
    }
    
    func request() -> URLRequest {
        var request: URLRequest? = URLRequest.new(url: url)

        switch self {
        case let .changeAvatar(form):
            request = URLRequest.fromDataRequest(url: url, boundary: form.boundary, interval: 200)
            request?.addValue("\(form.contentLength)", forHTTPHeaderField: "Content-Length")
        default:
            break
        }
        
        request?.httpMethod = method.rawValue
        request?.httpBody = body
        
        return request!
    }
    
    case sendOTP(req: NetReqSendOTP)
    case validate(req: NetReqValidate)
    case getMeInfo
    case logout
    case register(req: NetReqRegisterProfile)
    case changeAvatar(form: MultipartForm)
    case updateProfile(givenNames: String?, surName: String?, birthday: String?, gender: Gender?, image: String?)
}
