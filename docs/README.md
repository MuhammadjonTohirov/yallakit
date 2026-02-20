# YallaKit Documentation

This directory contains comprehensive documentation for the YallaKit SDK.

## 📂 Documentation Structure

```
docs/
├── packages/          # Package-specific documentation
│   ├── NetworkLayer.md
│   ├── IldamSDK.md
│   └── Core.md
├── guides/            # How-to guides and tutorials
│   ├── Architecture.md
│   ├── NetworkSetup.md
│   ├── GatewayPattern.md
│   └── UseCasePattern.md
└── api/               # API reference documentation
    ├── Gateways.md
    └── UseCases.md
```

## 📚 Documentation Index

### Package Documentation

Detailed documentation for each package in YallaKit:

- **[NetworkLayer](packages/NetworkLayer.md)** - Low-level networking engine
  - URLRequestProtocol explained in detail
  - Network configuration
  - Request/response handling
  - Error handling
  - Multipart uploads

- **[IldamSDK](packages/IldamSDK.md)** - Business logic layer
  - UseCases overview
  - Gateways overview
  - Domain models
  - Usage patterns

- **[Core](packages/Core.md)** - Shared utilities
  - Extensions
  - UI components
  - Location services
  - Storage utilities

### Guides

Step-by-step guides for common tasks:

- **[Architecture Guide](guides/Architecture.md)** - Clean architecture overview
  - Complete flow examples
  - Layer responsibilities
  - Best practices
  - Anti-patterns

- **[Network Setup](guides/NetworkSetup.md)** - Configuring the network layer
  - NetworkDelegate setup
  - Error localization
  - Base URL configuration
  - Custom headers

- **[Gateway Pattern](guides/GatewayPattern.md)** - Understanding and creating gateways
  - What is a gateway
  - Creating custom gateways
  - Best practices
  - Testing strategies

- **[UseCase Pattern](guides/UseCasePattern.md)** - Working with use cases
  - What is a use case
  - Creating custom use cases
  - Business logic placement
  - Testing strategies

### API Reference

Complete API documentation:

- **[Gateways Reference](api/Gateways.md)** - All available gateways
  - Authentication gateways
  - Address gateways
  - Card gateways
  - Order gateways
  - Notification gateways

- **[UseCases Reference](api/UseCases.md)** - All available use cases
  - Authentication use cases
  - Address use cases
  - Card use cases
  - Order use cases
  - Notification use cases

## 🚀 Quick Links

### For Beginners

1. Start with [Architecture Guide](guides/Architecture.md) to understand the overall structure
2. Read [Network Setup](guides/NetworkSetup.md) to configure the SDK
3. Explore [IldamSDK](packages/IldamSDK.md) to see available features

### For Developers

1. [Gateway Pattern](guides/GatewayPattern.md) - Learn to create custom gateways
2. [UseCase Pattern](guides/UseCasePattern.md) - Learn to create custom use cases
3. [NetworkLayer](packages/NetworkLayer.md) - Deep dive into URLRequestProtocol

### For Reference

1. [Gateways API](api/Gateways.md) - Complete list of all gateways
2. [UseCases API](api/UseCases.md) - Complete list of all use cases
3. [Core](packages/Core.md) - Available utilities and extensions

## 📝 Key Topics

### URLRequestProtocol

The `URLRequestProtocol` is the foundation of all network requests in YallaKit. It provides a type-safe way to define API endpoints.

```swift
public protocol URLRequestProtocol {
    var url: URL { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
    func request() -> URLRequest
}
```

Learn more in [NetworkLayer Documentation](packages/NetworkLayer.md#urlrequestprotocol).

### Gateway Pattern

Gateways abstract data access and provide a clean interface between business logic and infrastructure:

```swift
protocol SendOTPGatewayProtocol {
    func sendOTP(username: String) async throws -> NetResSendOTP?
}
```

Learn more in [Gateway Pattern Guide](guides/GatewayPattern.md).

### UseCase Pattern

UseCases contain business logic and orchestrate gateway calls:

```swift
protocol SendOTPUseCaseProtocol {
    func execute(username: String) async throws -> OTPResponse?
}
```

Learn more in [UseCase Pattern Guide](guides/UseCasePattern.md).

## 🔍 Search by Topic

### Authentication
- [SendOTPUseCase](api/UseCases.md#sendotpusecase)
- [ValidateOTPUseCase](api/UseCases.md#validateotpusecase)
- [LoginFlow Example](guides/Architecture.md#complete-flow-example-login)

### Orders
- [ActiveOrdersUseCase](api/UseCases.md#activeordersusecase)
- [CancelOrderUseCase](api/UseCases.md#cancelorderusecase)
- [Order Gateways](api/Gateways.md#order-gateways)

### Addresses
- [SearchAddressUseCase](api/UseCases.md#searchaddressusecase)
- [GetAddressUseCase](api/UseCases.md#getaddressusecase)
- [Address Gateways](api/Gateways.md#address-gateways)

### Payment Cards
- [AddCardUseCase](api/UseCases.md#addcardusecase)
- [VerifyCardUseCase](api/UseCases.md#verifycardusecase)
- [Card Gateways](api/Gateways.md#card-gateways)

## 📖 Documentation Conventions

### Code Examples

All code examples in this documentation are:
- Written in Swift 5.9+
- Use async/await concurrency
- Follow YallaKit's architecture patterns
- Tested and verified

### Terminology

- **UseCase**: Business logic layer component
- **Gateway**: Data access layer component
- **DTO**: Data Transfer Object (network models)
- **Domain Model**: Business entity used in the app
- **NetworkRoute**: Implementation of URLRequestProtocol

## 🤝 Contributing

This is internal documentation for Royal Taxi LLC. For updates or corrections, contact the development team.

## 📄 License

Copyright © 2025 Royal Taxi LLC. All rights reserved.
