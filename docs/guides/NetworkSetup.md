# Network Setup Guide

This guide covers configuring and using the NetworkLayer in YallaKit.

## Quick Setup

Configure the network layer at app launch:

```swift
@main
struct MyApp: App {
    init() {
        configureNetwork()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func configureNetwork() {
        // Set delegate for auth/network failures
        Network.delegate = AppNetworkDelegate()

        // Set custom error localizer
        Network.setErrorLocalizer { error in
            switch error {
            case .timeout:
                return NSLocalizedString("error.timeout", comment: "")
            case .unauthorized:
                return NSLocalizedString("error.unauthorized", comment: "")
            case .custom(let message, _):
                return message
            default:
                return error.localizedDescription
            }
        }
    }
}
```

## NetworkDelegate

Implement `NetworkDelegate` to handle global network events:

```swift
class AppNetworkDelegate: NetworkDelegate {
    func onAuthRequired() {
        // Called when server returns 401 Unauthorized
        DispatchQueue.main.async {
            // Clear tokens
            UserSettings.shared.token = nil

            // Navigate to login
            NotificationCenter.default.post(
                name: .userSessionExpired,
                object: nil
            )
        }
    }

    func onFailureNetwork() {
        // Called on network connectivity issues
        DispatchQueue.main.async {
            Popup.alert(
                title: "No Connection",
                message: "Please check your internet connection"
            )
        }
    }
}
```

## Error Localization

Provide user-friendly error messages:

```swift
Network.setErrorLocalizer { error in
    switch error {
    case .timeout:
        return "The request took too long. Please try again."

    case .unauthorized:
        return "Your session has expired. Please log in again."

    case .custom(let message, let code):
        // Handle specific error codes
        switch code {
        case 400:
            return "Invalid request: \(message)"
        case 404:
            return "Resource not found"
        case 500:
            return "Server error. Please try again later."
        default:
            return message
        }

    default:
        return "An unexpected error occurred"
    }
}
```

## Base URL Configuration

Configure base URLs for your API:

```swift
extension URL {
    static var baseAPICli: URL {
        #if DEBUG
        return URL(string: "https://staging-api.example.com/v1/")!
        #else
        return URL(string: "https://api.example.com/v1/")!
        #endif
    }

    static var baseAPI: URL {
        baseAPICli
    }
}
```

## Request Headers

Add default headers to all requests:

```swift
extension URLRequest {
    static func new(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)

        // Add common headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // Add auth token if available
        if let token = UserSettings.shared.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Add app version
        if let version = Bundle.main.appVersion {
            request.addValue(version, forHTTPHeaderField: "App-Version")
        }

        // Add device ID
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            request.addValue(deviceId, forHTTPHeaderField: "Device-ID")
        }

        return request
    }
}
```

## SSL Pinning (Optional)

For enhanced security, implement SSL pinning:

```swift
class NetworkSessionManager: NSObject, URLSessionDelegate {
    static let shared = NetworkSessionManager()

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: nil
        )
    }()

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        // Implement certificate pinning here
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}
```

## See Also

- [NetworkLayer Package](../packages/NetworkLayer.md)
- [Architecture Guide](Architecture.md)
