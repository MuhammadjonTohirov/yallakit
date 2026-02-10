# Gateway Pattern Guide

Gateways abstract data access in YallaKit, providing a clean interface between business logic and infrastructure.

## What is a Gateway?

A Gateway is a design pattern that:
- Abstracts data source access (API, database, etc.)
- Provides a protocol-based interface
- Returns network DTOs
- Has no business logic

## Creating a Gateway

### Step 1: Define the Protocol

```swift
protocol GetUserGatewayProtocol {
    func getUser(id: Int) async -> NetResUser?
}
```

### Step 2: Create Request/Response DTOs

```swift
// Request DTO
struct NetReqGetUser: Codable {
    let userId: Int
}

// Response DTO
struct NetResUser: NetResBody {
    let id: Int
    let name: String
    let email: String
}
```

### Step 3: Create Network Route

```swift
enum UserNetworkRoute: URLRequestProtocol {
    case getUser(id: Int)

    var url: URL {
        switch self {
        case .getUser(let id):
            return URL.baseAPI.appendingPath("users/\(id)")
        }
    }

    var body: Data? {
        nil // GET request has no body
    }

    var method: HTTPMethod {
        .get
    }

    func request() -> URLRequest {
        var req = URLRequest.new(url: url)
        req?.httpMethod = method.rawValue
        return req!
    }
}
```

### Step 4: Implement the Gateway

```swift
struct GetUserGateway: GetUserGatewayProtocol {
    func getUser(id: Int) async -> NetResUser? {
        return await Network.send(
            request: UserNetworkRoute.getUser(id: id)
        )?.result
    }
}
```

## Gateway Best Practices

### 1. One Method Per Operation

```swift
// Good
protocol GetUserGateway {
    func getUser(id: Int) async -> NetResUser?
}

protocol UpdateUserGateway {
    func updateUser(id: Int, data: UserData) async -> Bool
}

// Bad - multiple operations
protocol UserGateway {
    func getUser(id: Int) async -> NetResUser?
    func updateUser(id: Int, data: UserData) async -> Bool
    func deleteUser(id: Int) async -> Bool
}
```

### 2. Return Network DTOs, Not Domain Models

```swift
// Good
func getUser(id: Int) async -> NetResUser? { }

// Bad
func getUser(id: Int) async -> UserInfo? { }
```

### 3. No Business Logic

```swift
// Bad - contains business logic
struct GetUserGateway {
    func getUser(id: Int) async -> NetResUser? {
        if id < 0 { // Business logic belongs in UseCase
            return nil
        }
        return await Network.send(...)?.result
    }
}

// Good - pure data access
struct GetUserGateway {
    func getUser(id: Int) async -> NetResUser? {
        return await Network.send(...)?.result
    }
}
```

## Testing Gateways

### Mock for Unit Tests

```swift
class MockGetUserGateway: GetUserGatewayProtocol {
    var mockUser: NetResUser?

    func getUser(id: Int) async -> NetResUser? {
        return mockUser
    }
}

// In tests
let mockGateway = MockGetUserGateway()
mockGateway.mockUser = NetResUser(id: 1, name: "Test", email: "test@example.com")

let useCase = GetUserUseCase(gateway: mockGateway)
let result = await useCase.execute(userId: 1)
```

## See Also

- [Gateways API Reference](../api/Gateways.md)
- [Architecture Guide](Architecture.md)
