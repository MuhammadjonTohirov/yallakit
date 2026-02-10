# Architecture Guide

YallaKit follows Clean Architecture principles to maintain separation of concerns, testability, and scalability.

## Overview

Clean Architecture organizes code into layers with clear dependencies:

```
┌──────────────────────────────────────────┐
│         Presentation Layer               │
│    (View, ViewModel, SwiftUI)            │
└────────────────┬─────────────────────────┘
                 │
                 ▼
┌──────────────────────────────────────────┐
│         Business Logic Layer             │
│          (UseCases)                      │
└────────────────┬─────────────────────────┘
                 │
                 ▼
┌──────────────────────────────────────────┐
│         Data Access Layer                │
│          (Gateways)                      │
└────────────────┬─────────────────────────┘
                 │
                 ▼
┌──────────────────────────────────────────┐
│         Infrastructure Layer             │
│     (NetworkLayer, Database)             │
└──────────────────────────────────────────┘
```

## The Dependency Rule

Dependencies point inward:
- **Presentation** depends on **Business Logic**
- **Business Logic** depends on **Data Access**
- **Data Access** depends on **Infrastructure**
- **Never the reverse**

## Complete Flow Example: Login

Let's walk through a complete login flow to see how all layers interact.

### 1. User Interaction (Presentation Layer)

```swift
// LoginView.swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var phone = ""
    @State private var otpCode = ""

    var body: some View {
        VStack {
            TextField("Phone", text: $phone)
            Button("Send OTP") {
                Task {
                    await viewModel.sendOTP(phone: phone)
                }
            }

            if viewModel.otpSent {
                TextField("OTP Code", text: $otpCode)
                Button("Login") {
                    Task {
                        await viewModel.validateOTP(phone: phone, code: otpCode)
                    }
                }
            }

            if viewModel.isLoading {
                LoadingIndicator()
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
```

### 2. ViewModel (Presentation Layer)

```swift
// LoginViewModel.swift
@MainActor
class LoginViewModel: ObservableObject {
    @Published var otpSent = false
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""

    private let sendOTPUseCase: SendOTPUseCaseProtocol
    private let validateOTPUseCase: ValidateOTPUseCaseProtocol

    init(
        sendOTPUseCase: SendOTPUseCaseProtocol = SendOTPUseCase(gateway: SendOTPGateway()),
        validateOTPUseCase: ValidateOTPUseCaseProtocol = ValidateOTPUseCase(gateway: ValidateOTPGateway())
    ) {
        self.sendOTPUseCase = sendOTPUseCase
        self.validateOTPUseCase = validateOTPUseCase
    }

    func sendOTP(phone: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await sendOTPUseCase.execute(username: phone)
            if result != nil {
                otpSent = true
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }

    func validateOTP(phone: String, code: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await validateOTPUseCase.execute(username: phone, code: code)
            if let token = result?.token {
                UserSettings.shared.token = token
                // Navigate to main screen
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
```

### 3. UseCase (Business Logic Layer)

```swift
// SendOTPUseCase.swift
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async throws -> OTPResponse?
}

struct SendOTPUseCase: SendOTPUseCaseProtocol {
    private let gateway: SendOTPGatewayProtocol

    init(gateway: SendOTPGatewayProtocol) {
        self.gateway = gateway
    }

    func execute(username: String) async throws -> OTPResponse? {
        // Business logic: validate phone format
        guard username.isValidPhoneNumber else {
            throw ValidationError.invalidPhoneNumber
        }

        // Call gateway
        guard let response = try await gateway.sendOTP(username: username) else {
            throw NetworkError.noData
        }

        // Transform to domain model
        return OTPResponse(
            sessionId: response.sessionId,
            expiresAt: response.expiresAt
        )
    }
}
```

### 4. Gateway (Data Access Layer)

```swift
// SendOTPGateway.swift
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

### 5. Network Route (Infrastructure Layer)

```swift
// AuthNetworkRoute.swift
enum AuthNetworkRoute: URLRequestProtocol {
    case sendOTP(req: NetReqSendOTP)
    case validate(req: NetReqValidate)

    var url: URL {
        switch self {
        case .sendOTP:
            return URL.baseAPICli.appendingPath("client")
        case .validate:
            return URL.baseAPICli.appendingPath("valid")
        }
    }

    var body: Data? {
        switch self {
        case .sendOTP(let req):
            return req.asData
        case .validate(let req):
            return req.asData
        }
    }

    var method: HTTPMethod {
        .post
    }

    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request?.httpMethod = method.rawValue
        request?.httpBody = body
        return request!
    }
}
```

### 6. Models at Each Layer

#### Domain Model (Used by UseCase & ViewModel)
```swift
struct OTPResponse {
    let sessionId: String
    let expiresAt: Date
}
```

#### Network DTO (Used by Gateway)
```swift
struct NetReqSendOTP: Codable {
    let phone: String
}

struct NetResSendOTP: NetResBody {
    let sessionId: String
    let expiresAt: Date
}
```

## Layer Responsibilities

### Presentation Layer
**Responsibility:** Display UI and handle user interactions

**Contains:**
- SwiftUI Views
- ViewModels
- UI State

**Rules:**
- Never directly calls Gateways
- Never imports NetworkLayer
- Only knows about UseCases and Domain Models

### Business Logic Layer
**Responsibility:** Application business rules

**Contains:**
- UseCases
- Business validation logic
- Domain models

**Rules:**
- No UI code
- No direct network calls
- Depends on Gateway protocols, not implementations
- Transforms network DTOs to domain models

### Data Access Layer
**Responsibility:** Data fetching and storage

**Contains:**
- Gateway protocols
- Gateway implementations
- Network DTOs

**Rules:**
- No business logic
- No UI code
- Returns network DTOs, not domain models
- One gateway per data operation

### Infrastructure Layer
**Responsibility:** External concerns (network, database, etc.)

**Contains:**
- NetworkLayer
- Database
- Third-party integrations

**Rules:**
- No business logic
- No domain models
- Reusable across projects

## Benefits of This Architecture

### 1. Testability

Each layer can be tested independently:

```swift
// Test UseCase with mock gateway
class MockSendOTPGateway: SendOTPGatewayProtocol {
    var mockResponse: NetResSendOTP?

    func sendOTP(username: String) async throws -> NetResSendOTP? {
        return mockResponse
    }
}

// In tests
let mockGateway = MockSendOTPGateway()
mockGateway.mockResponse = NetResSendOTP(sessionId: "test123", expiresAt: Date())

let useCase = SendOTPUseCase(gateway: mockGateway)
let result = try await useCase.execute(username: "+1234567890")

XCTAssertEqual(result?.sessionId, "test123")
```

### 2. Flexibility

Easy to swap implementations:

```swift
// Use real gateway in production
let useCase = SendOTPUseCase(gateway: SendOTPGateway())

// Use mock gateway in previews
let useCase = SendOTPUseCase(gateway: MockSendOTPGateway())

// Use alternative implementation
let useCase = SendOTPUseCase(gateway: AlternativeSendOTPGateway())
```

### 3. Maintainability

Changes are isolated:

- UI changes → Only Presentation layer
- Business rule changes → Only UseCase layer
- API changes → Only Gateway & Network layers
- Infrastructure changes → Only Infrastructure layer

### 4. Scalability

Easy to add new features:

```swift
// Add new feature: Password reset
// 1. Add UseCase
struct ResetPasswordUseCase: ResetPasswordUseCaseProtocol { }

// 2. Add Gateway
struct ResetPasswordGateway: ResetPasswordGatewayProtocol { }

// 3. Add Route
enum AuthNetworkRoute {
    case resetPassword(req: NetReqResetPassword)
}

// 4. Add ViewModel
class ResetPasswordViewModel { }

// 5. Add View
struct ResetPasswordView: View { }
```

## Common Patterns

### Error Handling

Each layer handles errors appropriately:

```swift
// Gateway - propagate network errors
func sendOTP(username: String) async throws -> NetResSendOTP? {
    try await Network.sendThrow(request: route)?.result
}

// UseCase - transform errors
func execute(username: String) async throws -> OTPResponse? {
    do {
        return try await gateway.sendOTP(username: username)
    } catch NetworkError.unauthorized {
        throw AuthError.sessionExpired
    } catch {
        throw AuthError.unknown(error)
    }
}

// ViewModel - handle errors for UI
func sendOTP(phone: String) async {
    do {
        try await useCase.execute(username: phone)
    } catch {
        errorMessage = error.localizedDescription
        showError = true
    }
}
```

### Data Flow

#### From UI to Server
```
User Action → View → ViewModel → UseCase → Gateway → Network → Server
```

#### From Server to UI
```
Server → Network → Gateway → UseCase → ViewModel → View → UI Update
```

## Best Practices

### 1. One UseCase Per Operation

```swift
// Good
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async -> OTPResponse?
}

// Bad - doing too much
protocol AuthUseCaseProtocol {
    func sendOTP(username: String) async -> OTPResponse?
    func validateOTP(code: String) async -> Bool
    func resetPassword(email: String) async -> Bool
}
```

### 2. Protocol-Oriented Design

Always use protocols for testability:

```swift
// Good
protocol LoginUseCaseProtocol {
    func execute(username: String, password: String) async -> Bool
}

class LoginViewModel {
    let useCase: LoginUseCaseProtocol // Can be mocked
}

// Bad
class LoginViewModel {
    let useCase = LoginUseCase() // Hard to test
}
```

### 3. Dependency Injection

Inject dependencies through initializers:

```swift
// Good
class MyViewModel {
    private let useCase: MyUseCaseProtocol

    init(useCase: MyUseCaseProtocol) {
        self.useCase = useCase
    }
}

// Bad
class MyViewModel {
    private let useCase = MyUseCase(gateway: MyGateway())
}
```

### 4. Transform at the Right Layer

```swift
// Gateway returns network DTOs
struct SendOTPGateway {
    func sendOTP() -> NetResSendOTP? { }
}

// UseCase transforms to domain models
struct SendOTPUseCase {
    func execute() -> OTPResponse? {
        let networkDTO = gateway.sendOTP()
        return OTPResponse(from: networkDTO) // Transform here
    }
}
```

## Anti-Patterns to Avoid

### ❌ Skipping Layers

```swift
// Bad - View directly calls Gateway
class MyView: View {
    let gateway = MyGateway()

    func action() {
        gateway.operation() // Skip UseCase layer
    }
}
```

### ❌ Business Logic in Gateway

```swift
// Bad - Gateway contains business logic
struct MyGateway {
    func operation(param: String) -> Result {
        if param.count < 5 { // Business logic doesn't belong here
            return nil
        }
        return network.send()
    }
}
```

### ❌ Domain Models in Gateway

```swift
// Bad - Gateway returns domain model
func sendOTP() -> OTPResponse { } // Should return NetResSendOTP

// Good - Gateway returns network DTO
func sendOTP() -> NetResSendOTP { }
```

## See Also

- [UseCase Pattern Guide](UseCasePattern.md)
- [Gateway Pattern Guide](GatewayPattern.md)
- [Network Setup Guide](NetworkSetup.md)
- [IldamSDK Package](../packages/IldamSDK.md)
