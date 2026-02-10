# YallaKit Documentation

Welcome to **YallaKit**, a modular iOS SDK designed for Royal Taxi LLC. This SDK provides comprehensive tools for building taxi-related applications with a clean architecture approach.

## 🚀 Quick Start

```swift
import YallaKit

// Configure network on app launch
Network.delegate = MyNetworkDelegate()

// Use a UseCase
let sendOTPUseCase = SendOTPUseCase(gateway: SendOTPGateway())
let result = await sendOTPUseCase.execute(username: "+1234567890")
```

## 📚 Documentation

### Package Documentation
- [NetworkLayer](docs/packages/NetworkLayer.md) - Low-level networking engine
- [IldamSDK](docs/packages/IldamSDK.md) - Business logic and domain layer
- [Core](docs/packages/Core.md) - Shared utilities and extensions

### Guides
- [Architecture Guide](docs/guides/Architecture.md) - Clean architecture overview and flow
- [Network Setup](docs/guides/NetworkSetup.md) - Configuring the network layer
- [Gateway Pattern](docs/guides/GatewayPattern.md) - Understanding and creating gateways
- [UseCase Pattern](docs/guides/UseCasePattern.md) - Working with use cases

### API Reference
- [Gateways Reference](docs/api/Gateways.md) - Complete list of all gateways
- [UseCases Reference](docs/api/UseCases.md) - Complete list of all use cases

## 📦 Package Structure

YallaKit is composed of several Swift packages:

### YallaKit (Main Package)
The umbrella package that aggregates all dependencies. Import this to access the full SDK functionality.

### IldamSDK
The business logic layer containing:
- **UseCases**: High-level business operations
- **Gateways**: Data access abstractions
- **Models**: Domain entities

### Core
Shared utilities, extensions, and helper classes used across the SDK.

### NetworkLayer
Lightweight networking engine built on URLSession, handling HTTP operations, parsing, and error handling.

## 🏗 Architecture Overview

YallaKit follows Clean Architecture:

```
┌─────────────┐
│ View/       │
│ ViewModel   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  UseCase    │ ◄── Business Logic
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Gateway    │ ◄── Data Access Layer
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ NetworkLayer│ ◄── HTTP/Network Operations
└─────────────┘
```

See the [Architecture Guide](docs/guides/Architecture.md) for detailed information.

## 🔧 Installation

Add YallaKit to your Swift package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/yallakit.git", from: "1.0.0")
]
```

## 📝 License

Copyright © 2025 Royal Taxi LLC. All rights reserved.

## 🤝 Contributing

This is a private SDK for Royal Taxi LLC internal use.
