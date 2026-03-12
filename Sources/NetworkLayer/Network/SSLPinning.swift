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

        // SecKeyCopyExternalRepresentation returns raw key bytes.
        // OpenSSL hashes the full DER-encoded SubjectPublicKeyInfo (SPKI),
        // which includes an ASN.1 header. We must prepend it to match.
        let spkiHeader = Self.spkiHeader(for: publicKey)
        var spkiData = Data(spkiHeader)
        spkiData.append(publicKeyData)

        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        spkiData.withUnsafeBytes { buffer in
            _ = CC_SHA256(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }

        return Data(hash).base64EncodedString()
    }

    // MARK: - SPKI ASN.1 Headers

    private static func spkiHeader(for key: SecKey) -> [UInt8] {
        guard let attributes = SecKeyCopyAttributes(key) as? [CFString: Any],
              let keyType = attributes[kSecAttrKeyType] as? String,
              let keySize = attributes[kSecAttrKeySizeInBits] as? Int else {
            return ecP256Header
        }

        if keyType == (kSecAttrKeyTypeRSA as String) {
            switch keySize {
            case 4096: return rsa4096Header
            default: return rsa2048Header
            }
        } else {
            switch keySize {
            case 384: return ecP384Header
            default: return ecP256Header
            }
        }
    }

    private static let ecP256Header: [UInt8] = [
        0x30, 0x59, 0x30, 0x13, 0x06, 0x07, 0x2A, 0x86,
        0x48, 0xCE, 0x3D, 0x02, 0x01, 0x06, 0x08, 0x2A,
        0x86, 0x48, 0xCE, 0x3D, 0x03, 0x01, 0x07, 0x03,
        0x42, 0x00
    ]

    private static let ecP384Header: [UInt8] = [
        0x30, 0x76, 0x30, 0x10, 0x06, 0x07, 0x2A, 0x86,
        0x48, 0xCE, 0x3D, 0x02, 0x01, 0x06, 0x05, 0x2B,
        0x81, 0x04, 0x00, 0x22, 0x03, 0x62, 0x00
    ]

    private static let rsa2048Header: [UInt8] = [
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0D, 0x06, 0x09,
        0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01,
        0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0F, 0x00
    ]

    private static let rsa4096Header: [UInt8] = [
        0x30, 0x82, 0x02, 0x22, 0x30, 0x0D, 0x06, 0x09,
        0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01,
        0x01, 0x05, 0x00, 0x03, 0x82, 0x02, 0x0F, 0x00
    ]
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
