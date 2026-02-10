# IldamSDK Package

IldamSDK is the business logic layer of YallaKit, containing UseCases, Gateways, and Domain Models. It implements the core taxi application functionality while maintaining separation from UI and infrastructure concerns.

## Overview

IldamSDK follows Clean Architecture principles:
- **UseCases**: Business logic and application workflows
- **Gateways**: Data access abstractions (interfaces to backend APIs)
- **Models**: Domain entities and DTOs

## Package Structure

```
IldamSDK/
├── UseCases/           # Business logic layer
│   ├── Auth/
│   ├── Address/
│   ├── Order/
│   ├── Card/
│   └── ...
├── Network/
│   ├── Gateways/       # Data access implementations
│   ├── Router/         # Network route definitions
│   └── Models/         # Request/Response DTOs
└── Domain/
    └── Models/         # Domain entities
```

## Key Features

### 🔐 Authentication
- OTP-based phone authentication
- User profile management
- Session handling

### 📍 Address Management
- Reverse geocoding
- Address search
- Save favorite places
- Load nearby addresses

### 🚕 Order Management
- Create and track orders
- Order history
- Active orders tracking
- Order cancellation with reasons
- Order rating

### 💳 Payment Cards
- Add/remove payment cards
- Card verification
- Set default card
- Card list management

### 🔔 Notifications
- Load notifications
- Mark as read
- Unread count

### 🗺️ Location Services
- Check service availability
- Find nearby executors (drivers)
- Route calculation
- Tariff calculation

## Architecture Layers

### Use Case Layer

UseCases contain the application's business logic. They:
- Define high-level operations
- Orchestrate gateway calls
- Transform gateway responses to domain models
- Contain business rules and validation

#### Example: SendOTPUseCase

```swift
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async throws -> OTPResponse?
}

struct SendOTPUseCase: SendOTPUseCaseProtocol {
    private let gateway: SendOTPGatewayProtocol

    init(gateway: SendOTPGatewayProtocol) {
        self.gateway = gateway
    }

    func execute(username: String) async throws -> OTPResponse? {
        guard let response = try await gateway.sendOTP(username: username) else {
            return nil
        }

        return OTPResponse(
            sessionId: response.sessionId,
            expiresAt: response.expiresAt
        )
    }
}
```

### Gateway Layer

Gateways abstract data access. They:
- Define data operations as protocols
- Implement network calls using NetworkLayer
- Handle request/response mapping
- Return network DTOs to UseCases

#### Example: SendOTPGateway

```swift
protocol SendOTPGatewayProtocol {
    func sendOTP(username: String) async throws -> NetResSendOTP?
}

struct SendOTPGateway: SendOTPGatewayProtocol {
    func sendOTP(username: String) async throws -> NetResSendOTP? {
        let request = NetReqSendOTP(phone: username)
        let response = try await Network.sendThrow(
            request: AuthNetworkRoute.sendOTP(req: request)
        )
        return response?.result
    }
}
```

### Model Layer

Two types of models:

#### Domain Models
Clean, UI-friendly models used by the app:

```swift
struct UserInfo {
    let id: Int
    let phone: String
    let name: String
    let avatar: String?
}
```

#### Network DTOs
Server response/request models:

```swift
struct NetResMeInfo: NetResBody {
    let id: Int
    let phone: String
    let givenNames: String?
    let surName: String?
    let image: String?
}
```

## Usage Patterns

### Basic UseCase Usage

```swift
// 1. Create the gateway
let gateway = SendOTPGateway()

// 2. Initialize the use case
let useCase = SendOTPUseCase(gateway: gateway)

// 3. Execute
do {
    let result = try await useCase.execute(username: "+1234567890")
    print("Session ID: \(result?.sessionId ?? "")")
} catch {
    print("Error: \(error)")
}
```

### Dependency Injection

For better testability, inject dependencies:

```swift
class AuthViewModel {
    private let sendOTPUseCase: SendOTPUseCaseProtocol
    private let validateOTPUseCase: ValidateOTPUseCaseProtocol

    init(
        sendOTPUseCase: SendOTPUseCaseProtocol,
        validateOTPUseCase: ValidateOTPUseCaseProtocol
    ) {
        self.sendOTPUseCase = sendOTPUseCase
        self.validateOTPUseCase = validateOTPUseCase
    }

    func login(phone: String) async {
        do {
            let result = try await sendOTPUseCase.execute(username: phone)
            // Handle success
        } catch {
            // Handle error
        }
    }
}
```

## Common Use Cases

### Authentication Flow

```swift
// 1. Send OTP
let sendOTPUseCase = SendOTPUseCase(gateway: SendOTPGateway())
let otpResult = try await sendOTPUseCase.execute(username: phone)

// 2. Validate OTP
let validateUseCase = ValidateOTPUseCase(gateway: ValidateOTPGateway())
let authResult = try await validateUseCase.execute(
    username: phone,
    code: otpCode
)

// 3. Get user info
let getMeUseCase = GetMeInfoUseCase(gateway: GetMeInfoGateway())
let userInfo = await getMeUseCase.execute()
```

### Order Creation Flow

```swift
// 1. Check location availability
let checkLocationUseCase = CheckLocationUseCase(gateway: CheckLocationGateway())
let locationCheck = await checkLocationUseCase.checkLocation(
    lat: pickup.lat,
    lng: pickup.lng
)

// 2. Get available tariffs
let tariffsUseCase = GetTaxiTariffsUseCase(gateway: GetTaxiTariffsGateway())
let tariffs = tariffsUseCase.execute(
    coords: [pickup, destination],
    addressId: pickupAddressId,
    options: selectedOptions
)

// 3. Create order (implementation in your app)
// ...
```

### Address Management

```swift
// Search addresses
let searchUseCase = SearchAddressUseCase(gateway: SearchAddressGateway())
let addresses = searchUseCase.execute(text: "Main Street")

// Get address from coordinates
let getAddressUseCase = GetAddressUseCase(gateway: GetAddressGateway())
let address = await getAddressUseCase.execute(lat: 40.7128, lng: -74.0060)

// Save favorite place
let addPlaceUseCase = AddPlaceUseCase(gateway: AddPlaceGateway())
let request = AddPlaceRequest(
    name: "Home",
    address: address.fullAddress,
    latitude: 40.7128,
    longitude: -74.0060,
    type: .home
)
let success = addPlaceUseCase.execute(request: request)
```

## Gateway Configuration

### Creating Custom Gateways

If you need to extend the SDK with new endpoints:

#### 1. Define the Protocol

```swift
protocol CustomGatewayProtocol {
    func customOperation(param: String) async -> CustomResponse?
}
```

#### 2. Create the Network Route

```swift
enum CustomNetworkRoute: URLRequestProtocol {
    case customEndpoint(param: String)

    var url: URL {
        URL.baseAPI.appendingPath("custom")
    }

    var body: Data? {
        switch self {
        case .customEndpoint(let param):
            return ["param": param].asData
        }
    }

    var method: HTTPMethod {
        .post
    }

    func request() -> URLRequest {
        var req = URLRequest.new(url: url)
        req?.httpMethod = method.rawValue
        req?.httpBody = body
        return req!
    }
}
```

#### 3. Implement the Gateway

```swift
struct CustomGateway: CustomGatewayProtocol {
    func customOperation(param: String) async -> CustomResponse? {
        return await Network.send(
            request: CustomNetworkRoute.customEndpoint(param: param)
        )?.result
    }
}
```

## Testing

### Mocking Gateways

```swift
class MockSendOTPGateway: SendOTPGatewayProtocol {
    var mockResponse: NetResSendOTP?
    var shouldThrow = false

    func sendOTP(username: String) async throws -> NetResSendOTP? {
        if shouldThrow {
            throw NetworkError.custom(message: "Mock error", code: -1)
        }
        return mockResponse
    }
}

// In tests
let mockGateway = MockSendOTPGateway()
mockGateway.mockResponse = NetResSendOTP(sessionId: "test123")

let useCase = SendOTPUseCase(gateway: mockGateway)
let result = try await useCase.execute(username: "+1234567890")

XCTAssertEqual(result?.sessionId, "test123")
```

## Best Practices

### 1. Protocol-Oriented Design

Always define protocols for UseCases and Gateways:

```swift
// Good
protocol LoginUseCaseProtocol {
    func execute(username: String, password: String) async -> Bool
}

// Bad - no protocol, hard to test
class LoginUseCase {
    func execute(username: String, password: String) async -> Bool
}
```

### 2. Single Responsibility

Each UseCase should have one clear purpose:

```swift
// Good
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async -> OTPResponse?
}

// Bad - doing too much
protocol AuthUseCaseProtocol {
    func sendOTP(username: String) async -> OTPResponse?
    func validateOTP(code: String) async -> Bool
    func login() async -> UserInfo?
}
```

### 3. Transform at UseCase Level

Gateways return network DTOs, UseCases transform to domain models:

```swift
struct GetMeInfoUseCase: GetMeInfoUseCaseProtocol {
    func execute() async -> UserInfo? {
        guard let netResponse = await gateway.getMeInfo() else {
            return nil
        }

        // Transform network DTO to domain model
        return UserInfo(
            id: netResponse.id,
            phone: netResponse.phone,
            name: "\(netResponse.givenNames ?? "") \(netResponse.surName ?? "")",
            avatar: netResponse.image
        )
    }
}
```

### 4. Error Handling

Handle errors appropriately at each layer:

```swift
// Gateway - let errors propagate
func sendOTP(username: String) async throws -> NetResSendOTP? {
    try await Network.sendThrow(request: route)?.result
}

// UseCase - handle or transform errors
func execute(username: String) async throws -> OTPResponse? {
    do {
        let result = try await gateway.sendOTP(username: username)
        return transform(result)
    } catch NetworkError.unauthorized {
        // Handle specifically
        throw AuthError.sessionExpired
    } catch {
        // Re-throw or wrap
        throw error
    }
}
```

## See Also

- [Gateway Pattern Guide](../guides/GatewayPattern.md)
- [UseCase Pattern Guide](../guides/UseCasePattern.md)
- [Gateways API Reference](../api/Gateways.md)
- [UseCases API Reference](../api/UseCases.md)
- [NetworkLayer Package](NetworkLayer.md)
