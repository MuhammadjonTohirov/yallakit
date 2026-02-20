# UseCase Pattern Guide

UseCases contain business logic in YallaKit, orchestrating data access and enforcing business rules.

## What is a UseCase?

A UseCase:
- Contains business logic
- Orchestrates gateway calls
- Transforms DTOs to domain models
- Enforces business rules
- Is protocol-based for testability

## Creating a UseCase

### Step 1: Define the Protocol

```swift
protocol GetUserUseCaseProtocol {
    func execute(userId: Int) async -> UserInfo?
}
```

### Step 2: Create Domain Model

```swift
struct UserInfo {
    let id: Int
    let fullName: String
    let email: String
    let isActive: Bool
}
```

### Step 3: Implement the UseCase

```swift
struct GetUserUseCase: GetUserUseCaseProtocol {
    private let gateway: GetUserGatewayProtocol

    init(gateway: GetUserGatewayProtocol) {
        self.gateway = gateway
    }

    func execute(userId: Int) async -> UserInfo? {
        // Business validation
        guard userId > 0 else {
            return nil
        }

        // Call gateway
        guard let networkUser = await gateway.getUser(id: userId) else {
            return nil
        }

        // Transform to domain model
        return UserInfo(
            id: networkUser.id,
            fullName: "\(networkUser.givenNames ?? "") \(networkUser.surName ?? "")".trimmingCharacters(in: .whitespaces),
            email: networkUser.email ?? "",
            isActive: networkUser.status == "active"
        )
    }
}
```

## UseCase Best Practices

### 1. Single Responsibility

```swift
// Good
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async -> OTPResponse?
}

// Bad - multiple responsibilities
protocol AuthUseCaseProtocol {
    func sendOTP(username: String) async -> OTPResponse?
    func validateOTP(code: String) async -> Bool
    func login(username: String, password: String) async -> Bool
}
```

### 2. Business Logic in UseCases

```swift
struct CreateOrderUseCase {
    func execute(request: CreateOrderRequest) async -> OrderResult? {
        // Validate business rules
        guard request.pickup != request.destination else {
            throw OrderError.samePickupAndDestination
        }

        guard request.scheduledTime > Date() else {
            throw OrderError.pastScheduledTime
        }

        // Check service availability
        let isAvailable = await checkLocationUseCase.execute(
            lat: request.pickup.lat,
            lng: request.pickup.lng
        )

        guard isAvailable else {
            throw OrderError.serviceUnavailable
        }

        // Create order
        return await gateway.createOrder(request: request)
    }
}
```

### 3. Transform at UseCase Level

```swift
struct GetUserUseCase {
    func execute(userId: Int) async -> UserInfo? {
        let networkDTO = await gateway.getUser(id: userId)

        // Transform network DTO to domain model
        return networkDTO.map { dto in
            UserInfo(
                id: dto.id,
                fullName: formatName(dto),
                email: dto.email ?? "N/A",
                isActive: dto.status == "active"
            )
        }
    }

    private func formatName(_ dto: NetResUser) -> String {
        [dto.givenNames, dto.surName]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
```

### 4. Compose UseCases

```swift
struct CreateOrderWithValidationUseCase {
    private let checkLocationUseCase: CheckLocationUseCaseProtocol
    private let getTariffsUseCase: GetTaxiTariffsUseCaseProtocol
    private let createOrderGateway: CreateOrderGatewayProtocol

    func execute(request: OrderRequest) async -> Order? {
        // Use other use cases
        guard await checkLocationUseCase.execute(
            lat: request.pickup.lat,
            lng: request.pickup.lng
        ).isAvailable else {
            throw OrderError.serviceUnavailable
        }

        let tariffs = await getTariffsUseCase.execute(
            coords: [request.pickup, request.destination],
            addressId: request.pickupAddressId,
            options: request.options
        )

        guard !tariffs.isEmpty else {
            throw OrderError.noTariffsAvailable
        }

        // Create order
        return await createOrderGateway.create(request: request)
    }
}
```

## Testing UseCases

### Unit Test with Mocks

```swift
class GetUserUseCaseTests: XCTestCase {
    func testExecute_Success() async {
        // Arrange
        let mockGateway = MockGetUserGateway()
        mockGateway.mockUser = NetResUser(
            id: 1,
            givenNames: "John",
            surName: "Doe",
            email: "john@example.com",
            status: "active"
        )

        let useCase = GetUserUseCase(gateway: mockGateway)

        // Act
        let result = await useCase.execute(userId: 1)

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.fullName, "John Doe")
        XCTAssertEqual(result?.email, "john@example.com")
        XCTAssertTrue(result?.isActive ?? false)
    }

    func testExecute_InvalidUserId() async {
        let mockGateway = MockGetUserGateway()
        let useCase = GetUserUseCase(gateway: mockGateway)

        let result = await useCase.execute(userId: -1)

        XCTAssertNil(result)
    }
}
```

## Common Patterns

### Error Handling

```swift
struct SendOTPUseCase {
    func execute(username: String) async throws -> OTPResponse {
        // Validate input
        guard username.isValidPhoneNumber else {
            throw ValidationError.invalidPhoneNumber
        }

        // Call gateway with error handling
        do {
            let result = try await gateway.sendOTP(username: username)
            return transform(result)
        } catch NetworkError.unauthorized {
            throw AuthError.sessionExpired
        } catch NetworkError.timeout {
            throw AppError.networkTimeout
        } catch {
            throw AppError.unknown(error)
        }
    }
}
```

### Pagination

```swift
struct LoadOrderHistoryUseCase {
    func execute(page: Int, limit: Int = 10) async -> OrderHistoryResult? {
        guard page > 0, limit > 0 else {
            return nil
        }

        let response = await gateway.loadHistory(page: page, limit: limit)

        return response.map { res in
            OrderHistoryResult(
                orders: res.orders.map { transform($0) },
                totalPages: res.totalPages,
                currentPage: page,
                hasMore: page < res.totalPages
            )
        }
    }
}
```

## See Also

- [UseCases API Reference](../api/UseCases.md)
- [Architecture Guide](Architecture.md)
- [Gateway Pattern](GatewayPattern.md)
