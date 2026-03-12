//
//  SSLPinning.swift
//  NetworkLayer
//
//  Created by YallaKit on 12/03/26.
//

import Foundation
import Security
import CommonCrypto

// MARK: - Configuration Types

/// A domain with its expected SHA-256 public key hashes for certificate pinning.
public struct PinnedDomain: Sendable {
    public let domain: String
    public let publicKeyHashes: [String]

    public init(domain: String, publicKeyHashes: [String]) {
        self.domain = domain
        self.publicKeyHashes = publicKeyHashes
    }
}

/// Configuration holding all pinned domains for SSL certificate pinning.
public struct SSLPinningConfiguration: Sendable {
    public let pinnedDomains: [PinnedDomain]

    public init(pinnedDomains: [PinnedDomain]) {
        self.pinnedDomains = pinnedDomains
    }
}

// MARK: - SSL Pinning Delegate

/// URLSession delegate that validates server public keys against pinned hashes.
final class SSLPinningDelegate: NSObject, URLSessionDelegate, Sendable {
    private let configuration: SSLPinningConfiguration

    init(configuration: SSLPinningConfiguration) {
        self.configuration = configuration
    }

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        let host = challenge.protectionSpace.host

        guard let pinnedDomain = configuration.pinnedDomains.first(where: { host.hasSuffix($0.domain) }) else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        guard validatePublicKey(serverTrust: serverTrust, pinnedDomain: pinnedDomain) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }

    private func validatePublicKey(serverTrust: SecTrust, pinnedDomain: PinnedDomain) -> Bool {
        guard #available(macOS 10.14, iOS 12.0, *) else { return true }

        let certificateCount = SecTrustGetCertificateCount(serverTrust)

        for index in 0..<certificateCount {
            guard let certificate = SecTrustGetCertificateAtIndex(serverTrust, index),
                  let publicKeyHash = publicKeyHashForCertificate(certificate) else {
                continue
            }

            if pinnedDomain.publicKeyHashes.contains(publicKeyHash) {
                return true
            }
        }

        return false
    }

    @available(macOS 10.14, iOS 12.0, *)
    private func publicKeyHashForCertificate(_ certificate: SecCertificate) -> String? {
        guard let publicKey = SecCertificateCopyKey(certificate),
              let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) as? Data else {
            return nil
        }

        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        publicKeyData.withUnsafeBytes { buffer in
            _ = CC_SHA256(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }

        return Data(hash).base64EncodedString()
    }
}

// MARK: - Pinned Session Factory

enum SSLPinnedSession {
    /// Returns `.shared` in DEBUG builds (for proxy tools), pinned session in RELEASE.
    static func makeSession(configuration: SSLPinningConfiguration) -> URLSession {
        #if DEBUG
        return .shared
        #else
        let delegate = SSLPinningDelegate(configuration: configuration)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
        #endif
    }
}
