//
//  URL+Extensions.swift
//  YuzPay
//
//  Created by applebro on 11/02/23.
//

import Foundation
import UniformTypeIdentifiers


public extension URL {
    
    nonisolated(unsafe) static var baseAPI: URL {
        .init(string: ConstantsProvider.shared.constants.baseGoApi)!
    }
    
    nonisolated(unsafe) static var baseAPICli: URL {
        .init(string: ConstantsProvider.shared.constants.basePhpApi + ConstantsProvider.shared.constants.phpBaseEndpoint)!
    }
    
    /// https://api2.ildam.uz/client
    static var goIldamAPI: URL {
        .init(string: ConstantsProvider.shared.constants.baseGoApi + ConstantsProvider.shared.constants.goBaseEndpoint)!
    }
    
    static var keyHeader: (key: String, value: String) {
        ("secret-key", "2f52434c-3068-460d-8dbc-5c80599f2db4")
    }
    
    static var langHeader: (key: String, value: String) {
        ("lang", (UserSettings.shared.language ?? .russian).smallCode)
    }
    
    // not in use for now
    nonisolated(unsafe) static var brandHeader: (key: String, value: String) {
        ("brand-id", "2")
    }
    
    //"AIzaSyD0uKSmSaabl3CJRrBeQ_wpJ0uowlhqylE" - old
    //"AIzaSyC_dHd88uaz8yUlmxKbvXo7n-a7mPhgaWI" - mine
    //"AIzaSyAkRnWYc4T9mCqk7GFIdXWYmwGs9f3X-6Q" - new
    static let googleMapsApiKey = "AIzaSyAkRnWYc4T9mCqk7GFIdXWYmwGs9f3X-6Q"
 
    func appendingPath(_ pathList: Any...) -> URL {
        var url = self
        pathList.forEach { path in
            if #available(iOS 16.0, *) {
                url = url.appending(component: "\(path)")
            } else {
                url = url.appendingPathComponent("\(path)")
            }
        }
        
        return url
    }
    
    static func googleRoutingAPI(from: String, to: String) -> URL? {
        return URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(from)&destination=\(to)&key=\(URL.googleMapsApiKey)")
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch {
            
        }
        return nil
    }
    
    var exists: Bool {
        FileManager.default.fileExists(atPath: self.path)
    }
    
    var fileSizeBeautifiedString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var mimeType: String {
        mimeTypeForPath(pathExtension: self.pathExtension)
    }

    private func mimeTypeForPath(pathExtension: String) -> String {
        return UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? ""
    }
    
    func queries(_ queries: URLQueryItem...) -> URL {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = Array(queries)
        return components?.url ?? self
    }
}

extension Language {
    fileprivate var smallCode: String {
        switch self {
        case .uzbek:
            return "uz"

        case .russian:
            return "ru"

        case .english:
            return "en"
        }
    }
}
