# NetworkLayer Package

The NetworkLayer package provides a lightweight, type-safe networking engine built on top of `URLSession`. It handles HTTP operations, request/response parsing, error handling, and multipart form uploads.

## Overview

NetworkLayer is designed to be:
- **Simple**: Easy-to-use API with minimal configuration
- **Type-safe**: Leverages Swift's type system for compile-time safety
- **Async/await**: Modern concurrency support
- **Extensible**: Easy to add custom request routes

## Core Components

### URLRequestProtocol

The foundation of all network requests in YallaKit. This protocol defines the contract for creating HTTP requests.

#### Protocol Definition

```swift
public protocol URLRequestProtocol {
    var url: URL { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
    func request() -> URLRequest
}
```

#### Properties

- **`url: URL`**: The endpoint URL for the request
- **`body: Data?`**: Optional request body (typically JSON data)
- **`method: HTTPMethod`**: HTTP method (GET, POST, PUT, DELETE)

#### Methods

- **`request() -> URLRequest`**: Constructs and returns a configured `URLRequest`

### HTTPMethod

An enumeration of supported HTTP methods:

```swift
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
```

## Creating Network Routes

Network routes are typically implemented as enums conforming to `URLRequestProtocol`. This pattern provides type-safe, compile-time verified endpoints.

### Example: AuthNetworkRoute

```swift
import NetworkLayer

enum AuthNetworkRoute: URLRequestProtocol {
    case sendOTP(req: NetReqSendOTP)
    case validate(req: NetReqValidate)
    case getMeInfo
    case logout

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
        }
    }

    var body: Data? {
        switch self {
        case .sendOTP(let req):
            return req.asData
        case .validate(let req):
            return req.asData
        default:
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .logout:
            return .post
        case .getMeInfo:
            return .get
        default:
            return .post
        }
    }

    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request?.httpMethod = method.rawValue
        request?.httpBody = body
        return request!
    }
}
```

### Benefits of the Enum Pattern

1. **Type Safety**: Compile-time checking of endpoints
2. **Associated Values**: Pass request parameters type-safely
3. **Centralization**: All endpoints for a feature in one place
4. **Exhaustive Switching**: Compiler ensures all cases are handled

## NetworkClientProtocol

The `NetworkClientProtocol` is the main abstraction for sending requests. `DefaultNetworkClient` provides the default implementation.

### Protocol Definition

```swift
public protocol NetworkClientProtocol: Sendable {
    func send<T: NetResBody>(
        urlSession: URLSession,
        request: URLRequestProtocol
    ) async -> NetRes<T>?

    func sendThrow<T: NetResBody>(
        urlSession: URLSession,
        request: URLRequestProtocol
    ) async throws -> NetRes<T>?

    func upload<T: NetResBody>(
        body: T.Type,
        request: URLRequestProtocol
    ) async throws -> NetRes<T>
}
```

### Sending Requests

#### Basic Request (No Throwing)

```swift
let client: NetworkClientProtocol = DefaultNetworkClient()
let response: NetRes<SomeResponse>? = await client.send(
    request: AuthNetworkRoute.getMeInfo
)
```

#### Throwing Request

```swift
let client: NetworkClientProtocol = DefaultNetworkClient()
do {
    let response: NetRes<SomeResponse>? = try await client.sendThrow(
        request: AuthNetworkRoute.sendOTP(req: otpRequest)
    )
} catch {
    // Handle error
}
```

### Upload Requests

For multipart form data uploads:

```swift
let client: NetworkClientProtocol = DefaultNetworkClient()
let response = try await client.upload(
    body: NetResChangeAvatar.self,
    request: AuthNetworkRoute.changeAvatar(form: multipartForm)
)
```

## Network Configuration

### NetworkDelegate

Implement this protocol to handle authentication and network failures:

```swift
public protocol NetworkDelegate {
    func onAuthRequired()
    func onFailureNetwork()
}
```

#### Setting the Delegate

```swift
class MyNetworkDelegate: NetworkDelegate {
    func onAuthRequired() {
        // Handle 401 unauthorized - clear tokens, navigate to login
        print("Session expired")
    }

    func onFailureNetwork() {
        // Handle network connectivity issues
        print("Network connection failed")
    }
}

// Set at app launch
Network.delegate = MyNetworkDelegate()
```

### Error Localization

Provide custom error messages:

```swift
Network.setErrorLocalizer { error in
    switch error {
    case .timeout:
        return "Request timed out. Please try again."
    case .unauthorized:
        return "You need to log in."
    case .custom(let message, _):
        return message
    default:
        return error.localizedDescription
    }
}
```

## Response Handling

### NetRes<T>

Standard response wrapper:

```swift
public struct NetRes<T: NetResBody>: Codable {
    let success: Bool
    let code: Int?
    let message: String?
    let error: String?
    let result: T?
}
```

### NetResBody

Protocol for response body types:

```swift
public protocol NetResBody: Codable {
    // Your response models conform to this
}
```

### Example Response Handling

```swift
let response = await Network.send(
    request: AuthNetworkRoute.getMeInfo
)

if let userInfo = response?.result {
    print("User: \(userInfo.name)")
} else if let error = response?.error {
    print("Error: \(error)")
}
```

## Error Handling

### NetworkError

```swift
enum NetworkError: Error {
    case timeout
    case unauthorized
    case custom(message: String, code: Int)
    case sslPinningFailed
}
```

### Automatic Error Handling

The Network layer automatically:
- Detects 401 responses and calls `NetworkDelegate.onAuthRequired()`
- Wraps URLSession errors into `NetworkError.timeout`
- Parses server error messages into `NetworkError.custom`

## Multipart Form Upload

### Creating a MultipartForm

```swift
let form = MultipartForm()
form.add(
    data: imageData,
    name: "avatar",
    fileName: "profile.jpg",
    mimeType: "image/jpeg"
)

let response = try await Network.upload(
    body: NetResChangeAvatar.self,
    request: AuthNetworkRoute.changeAvatar(form: form)
)
```

## Best Practices

### 1. One Route Enum Per Domain

Create separate route enums for different domains:
- `AuthNetworkRoute` - Authentication endpoints
- `OrderNetworkRoute` - Order management
- `AddressNetworkRoute` - Address/location services

### 2. Use Associated Values

Pass parameters through associated values:

```swift
enum OrderRoute: URLRequestProtocol {
    case getOrder(id: Int)
    case cancelOrder(orderId: Int, reason: String)
}
```

### 3. Leverage Type Safety

Use strongly-typed request/response models:

```swift
struct NetReqSendOTP: Codable {
    let phone: String
}

struct NetResSendOTP: NetResBody {
    let sessionId: String
    let expiresAt: Date
}
```

### 4. Handle Errors Gracefully

Always handle potential nil responses:

```swift
guard let result = response?.result else {
    let errorMessage = response?.error ?? "Unknown error"
    // Show error to user
    return
}
// Use result
```

## Advanced Usage

### Custom Headers

Add custom headers in the `request()` method:

```swift
func request() -> URLRequest {
    var req = URLRequest.new(url: url)
    req?.httpMethod = method.rawValue
    req?.httpBody = body

    // Add custom headers
    req?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    req?.addValue("application/json", forHTTPHeaderField: "Content-Type")

    return req!
}
```

### Request Timeouts

```swift
func request() -> URLRequest {
    var req = URLRequest.new(url: url)
    req?.timeoutInterval = 30 // 30 seconds
    req?.httpMethod = method.rawValue
    req?.httpBody = body
    return req!
}
```

## SSL Certificate Pinning

NetworkLayer supports public key pinning to prevent man-in-the-middle attacks. When configured, the library validates server public keys against pinned SHA-256 hashes before allowing connections.

### Why Public Key Pinning?

Certificate pinning breaks when certificates are renewed. Public key pinning survives renewal as long as the same key pair is used, making it more robust for production use.

### Setup

Call `configureSSLPinning()` once at app launch, before any network requests:

```swift
import NetworkLayer

Network.configureSSLPinning(.init(pinnedDomains: [
    PinnedDomain(domain: "api2.ildam.uz", publicKeyHashes: ["<hash1>", "<hash2>"]),
    PinnedDomain(domain: "api.ildam.uz", publicKeyHashes: ["<hash1>"]),
]))
```

### Extracting Public Key Hashes

Use OpenSSL to extract the SHA-256 hash of a server's public key:

```bash
openssl s_client -connect api2.ildam.uz:443 </dev/null 2>/dev/null \
  | openssl x509 -pubkey -noout \
  | openssl pkey -pubin -outform DER \
  | openssl dgst -sha256 -binary \
  | base64
```

### Behavior

- **DEBUG builds**: Pinning is skipped (`URLSession.shared` is used) so proxy tools like Proxyman and Charles continue to work during development
- **RELEASE builds**: A pinned `URLSession` is created that validates server public keys against configured hashes
- **Backup pins**: `publicKeyHashes` accepts an array to support key rotation — include both current and next key hashes
- **Domain matching**: Uses suffix matching so `"api2.ildam.uz"` also covers subdomains

### Error Handling

When SSL pinning validation fails, `NetworkError.sslPinningFailed` is thrown:

```swift
do {
    let response: NetRes<SomeResponse>? = try await client.sendThrow(
        request: SomeRoute.endpoint
    )
} catch let error as NetworkError where error.code == -3 {
    // SSL pinning failed — possible MITM attack
}
```

## Debugging

### Logging

NetworkLayer includes built-in logging (DEBUG builds only):

```
--- --- REQUEST --- ---
https://api.example.com/client
{
  "phone": "+1234567890"
}
--- --- RESPONSE --- ---
{
  "success": true,
  "result": {
    "sessionId": "abc123"
  }
}
```

### Custom Logging

Access request/response data in your delegate methods for custom logging or analytics.

## See Also

- [Network Setup Guide](../guides/NetworkSetup.md)
- [Gateway Pattern](../guides/GatewayPattern.md)
- [IldamSDK Package](IldamSDK.md)
