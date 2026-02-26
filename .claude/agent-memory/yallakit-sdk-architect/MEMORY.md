# YallaKit SDK Architect Memory

## Project Structure
- Swift Package with 3 modules: Core, NetworkLayer, IldamSDK
- iOS-only (uses UIKit/SwiftUI) -- `swift build` on macOS fails due to missing UIKit; use `xcodebuild` for real builds
- Gateway files live under `Sources/IldamSDK/Network/Gateways/` organized by domain: Order/, Notification/, Other/, Auth/, Address/, etc.

## Gateway DI Pattern (NetworkClientProtocol)
All gateway structs use dependency injection via `NetworkClientProtocol`:
```swift
struct SomeGateway: SomeGatewayProtocol {
    private let client: NetworkClientProtocol
    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }
    // methods use client.send(...) or client.sendThrow(...)
}
```
- Protocols are NOT modified -- only the struct implementations
- `NetworkClientProtocol` and `DefaultNetworkClient` are in NetworkLayer module
- Two call variants: `client.send(request:)` (non-throwing) and `client.sendThrow(request:)` (throwing)
- Some gateways use `Network.send`/`Network.sendThrow` static calls (legacy); these should be migrated to the injected `client`

## Naming Conventions
- Gateway structs: `SomeGateway` or `SomeGatewayImpl` (inconsistent -- some use `Impl` suffix)
- Gateway protocols: `SomeGatewayProtocol` or just `SomeGateway` (when impl uses `Impl` suffix)
- Request types: nested `struct Request: URLRequestProtocol` inside gateway, or route enums like `OrderNetworkRoute`
- Response types: `NetRes<T>`, `NetResBody` protocol, prefixed with `NetRes`
- Request DTOs: prefixed with `NetReq`

## Key Types (NetworkLayer)
- `Network` -- static class with `send`/`sendThrow` (legacy, being replaced by `NetworkClientProtocol`)
- `NetworkClientProtocol` / `DefaultNetworkClient` -- injectable network client
- `NetRes<T>` -- generic response wrapper (has `.success`, `.result` properties)
- `URLRequestProtocol` -- protocol for request types (url, body, method)
- `HTTPMethod` -- enum in NetworkLayer

## Network Services Architecture (Sources/IldamSDK/Network/Services/)
- `MainNetworkService` -- composite facade delegating to sub-services:
  - `AddressNetworkService` (6 address use cases: search, nearAddress, myPlaces, add, update, delete)
  - `TariffNetworkService` (getTaxiTariffs, calculateRouteAndTariffs via RouteTariffCalcUseCase)
  - `ExecutorNetworkService` (findExecutors via FindExecutorsUseCase)
  - Keeps `loadHistory` and `getOrderDetails` directly (LoadOrderHistoryUseCase, GetOrderDetailsUseCase)
- `OrderNetworkService` -- split into focused sub-protocols:
  - `OrderQueryServiceProtocol` (activeOrders, order, archivedOrder, activeOrdersCount)
  - `OrderMutationServiceProtocol` (cancelOrder, cancelOrderReason, orderTaxi)
  - `OrderRatingServiceProtocol` (rateOrder)
  - `OrderNetworkServiceProtocol` inherits all 3 + adds `orderSettings`
- All service protocols are `: Sendable`; all service structs are `Sendable`
- `OrderNetworkMockService` extends `OrderNetworkService` class (in MockServices/)

## Directories Fully Migrated to NetworkClientProtocol DI
- Order/ (16 files): CancelOrder, CancelOrderReason, DeleteOrder, RateOrder, RateOrderV2, FasterOrder, UpdateOrderPaymentMethod, Active/ActiveOrders, Active/ActiveOrdersV2, Active/ActiveOrdersCount, Active/GetOrderDetails, Active/GetOrderDetailsV2, Archives/ArchivedOrder, Archives/ArchivedOrderV2, Archives/ArchivedOrdersV2, Archives/OrderHistory
- Notification/ (4 files): LoadNotifications, ReadAllNotifs, UnreadNotifications, ShowAndReadNotif
- Other/ (4 files): BecomeDriver, BrandServices, Districts, RatingReason

## Use Case Standardized Init Pattern (Dual Init)
Use cases use a dual-init pattern to avoid exposing internal gateway types in public API:
```swift
public struct SomeUseCase: SomeUseCaseProtocol, Sendable {
    private let gateway: SomeGatewayProtocol
    public init() {
        self.gateway = SomeGateway()
    }
    init(gateway: SomeGatewayProtocol) {
        self.gateway = gateway
    }
}
```
- `public init()` for external consumers (hides internal gateway type)
- `init(gateway:)` internal for package-level testing/DI
- `struct` over `final class` when no mutable state
- Both use case protocols and gateway protocols have `: Sendable`
- Exception: `SyncCardsUseCaseImpl` stays `final class` with `@unchecked Sendable` (has mutable `var cards`, uses singleton)

### Domains migrated to dual-init pattern
- Auth/ (7 files): GetMeInfo, Logout, ChangeAvatar, SendOTP, ValidateOTP, Register, ProfileUpdate
- Address/ (7 files): AddMyPlace, UpdatePlace, DeleteAddress, GetAddress, LoadNearAddress, SearchAddress, MyPlaces
- Order/ (16 files): ActiveOrdersCount, ActiveOrders, ActiveOrdersV2, ArchivedOrderV2, ArchivedOrders, ArchivedOrdersV2, BrandServices, CancelOrderReason, CancelOrder, DeleteOrder, FasterOrder, GetOrderDetails, GetOrderDetailsV2, RateOrder, RateOrderV2, UpdateOrderPaymentMethod
- Notification/ (4 files): LoadNotifications, ReadAllNotifs, ShowAndReadNotif, UnreadNotifications
- Other/ (3 files): BecomeDriver, Districts, RatingReason
- Main/ (5 files): RouteTariffCalc, Routing, FindExecutors, GetTaxiTariffs, LoadOrderHistory
- Card/ (5 files): AddCard, CardList, DeleteCard, VerifyCard, SetDefaultCard
- ActiveBonus/ (1 file): ActivateBonusUseCase
- CheckLocation/ (1 file): CheckLocationUseCase

### Domains still on old single-init pattern (need migration)
- Other/ (1 file): SyncFCM

## Domains Fully Standardized (Use Case Init + Sendable)
- Auth/ (7 files): SendOTP, ValidateOTP, Register, GetMeInfo, Logout, ProfileUpdate, ChangeAvatar
- Card/ (5 files): AddCard, CardList, DeleteCard, VerifyCard, SetDefaultCard (SyncCards excluded)
- Address/ (7 files): AddMyPlace, UpdatePlace, DeleteAddress, GetAddress, LoadNearAddress, SearchAddress, MyPlaces
- Order/ (16 files): ActiveOrders, ActiveOrdersV2, ActiveOrdersCount, GetOrderDetails, GetOrderDetailsV2, ArchivedOrder, ArchivedOrderV2, ArchivedOrdersV2, RateOrder, RateOrderV2, CancelOrder, CancelOrderReason, DeleteOrder, UpdateOrderPaymentMethod, FasterOrder, BrandServices
- Notification/ (4 files): LoadNotifications, ReadAllNotifs, UnreadNotifications, ShowAndReadNotif
- Other/ (4 files): BecomeDriver, Districts, RatingReason, SyncFCM
- Main/ (5 files): FindExecutors, GetTaxiTariffs, LoadOrderHistory, RouteTariffCalc, Routing
- ActiveBonus/ (1 file): ActivateBonusUseCase
- CheckLocation/ (1 file): CheckLocationUseCase
