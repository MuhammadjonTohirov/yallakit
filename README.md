# YallaKit Documentation

Welcome to the official documentation for **YallaKit**, a modular iOS SDK designed for Royal Taxi LLC. This SDK provides comprehensive tools for building taxi-related applications, including networking, core utilities, and business logic.

## 📦 Package Structure

YallaKit is composed of several Swift packages, each with a specific responsibility:

### 1. **YallaKit**
The main umbrella package that aggregates all other dependencies. Developers should primarily import this package to access the full functionality of the SDK.

### 2. **IldamSDK**
The heart of the business logic. It contains:
- **UseCases**: High-level operations (e.g., `LoginUseCase`, `RequestRideUseCase`).
- **Gateways**: Data access layer abstractions that communicate with the backend.
- **Models**: Domain entities.

### 3. **Core**
Contains shared utilities, extensions, base models, and helper classes used across the SDK.

### 4. **NetworkLayer**
A lightweight, low-level networking engine based on `URLSession`. It handles:
- HTTP requests (`GET`, `POST`, `PUT`, etc.).
- Request/Response parsing.
- Error handling.
- Multipart form uploads.

### 5. **IMap** (Reference)
A module containing map-related utilities and UI components (Reference only).

---

## 🏗 Architecture

YallaKit follows a Clean Architecture approach:

1.  **View / ViewModel** (in the App) calls a **UseCase**.
2.  **UseCase** contains the business logic and calls a **Gateway**.
3.  **Gateway** constructs the request and uses the **NetworkLayer** to fetch data.
4.  **NetworkLayer** returns raw data/objects to the **Gateway**.
5.  **Gateway** maps the result to Domain Models and returns it to the **UseCase**.
6.  **UseCase** returns the final result to the **View / ViewModel**.

---

## 🌐 Network Setup

Before using the SDK, you must configure the Network layer.

### 1. Handling Unauthorized Requests (401)
Implement the `NetworkDelegate` to handle session expiration or unauthorized access.

```swift
import NetworkLayer

class MyNetworkDelegate: NetworkDelegate {
    func onAuthRequired() {
        print("Token expired. Navigate to Login.")
        // Perform logout or token refresh logic here
    }

    func onFailureNetwork() {
        print("Network connection failed.")
    }
}

// Set the delegate at app launch
Network.delegate = MyNetworkDelegate()
```

### 2. Custom Error Localization
You can provide a custom error localizer to translate network errors into user-friendly messages.

```swift
Network.setErrorLocalizer { error in
    switch error {
    case .timeout:
        return "The request timed out. Please try again."
    case .unauthorized:
        return "You need to log in."
    default:
        return error.localizedDescription
    }
}
```

---

## 📚 API Reference

Below is a detailed list of available **Gateways** and **UseCases** within `IldamSDK`.

## Gateways

### ActivateBonuseGateway

#### `ActivateBonuseGateway`
- **Conforms to:** `ActivateBonuseGatewayProtocol`
- **Methods:**
  - `activate(promoCode: String) -> ActivateBonuseGateway.Response?`

### Address

#### `AddPlaceGateway`
- **Conforms to:** `AddPlaceGatewayProtocol`
- **Methods:**
  - `addMyPlace(req: NetReqAddAddress) -> Bool`

#### `DeleteAddressGateway`
- **Conforms to:** `DeleteAddressGatewayProtocol`
- **Methods:**
  - `deleteAddress(id: Int) -> Bool`

#### `GetAddressGateway`
- **Conforms to:** `GetAddressGatewayProtocol`
- **Methods:**
  - `getAddress(lat: Double, lng: Double) -> NetResGetAddress?`

#### `LoadNearAddressGateway`
- **Conforms to:** `LoadNearAddressGatewayProtocol`
- **Methods:**
  - `loadNearAddress(lat: Double, lng: Double) -> [NetResAddressItem]`

#### `MyPlacesGateway`
- **Conforms to:** `MyPlacesGatewayProtocol`
- **Methods:**
  - `loadMyPlaces() -> [NetResMyAddressItem]`

#### `SearchAddressGateway`
- **Conforms to:** `SearchAddressGatewayProtocol`
- **Methods:**
  - `searchAddress(text: String) -> [NetResAddressItem]?`

#### `UpdatePlaceGateway`
- **Conforms to:** `UpdatePlaceGatewayProtocol`
- **Methods:**
  - `updateMyPlace(req: NetReqEditAddress, id: Int) -> Bool`

### Auth

#### `ChangeAvatarGateway`
- **Conforms to:** `ChangeAvatarGatewayProtocol`
- **Methods:**
  - `changeAvatar(profileAvatar: Data) -> NetRes<NetResChangeAvatar>?`

#### `GetMeInfoGateway`
- **Conforms to:** `GetMeInfoGatewayProtocol`
- **Methods:**
  - `getMeInfo() -> NetResMeInfo?`

#### `LogoutGateway`
- **Conforms to:** `LogoutGatewayProtocol`
- **Methods:**
  - `logout() -> Bool`

#### `RegisterGateway`
- **Conforms to:** `RegisterGatewayProtocol`
- **Methods:**
  - `register(req: NetReqRegisterProfile) -> NetRes<NetResRegisterProfile>?`

#### `SendOTPGateway`
- **Conforms to:** `SendOTPGatewayProtocol`
- **Methods:**
  - `sendOTP(username: String) -> NetResSendOTP?`

#### `UpdateProfileGateway`
- **Conforms to:** `UpdateProfileGatewayProtocol`
- **Methods:**
  - `updateProfile(req: NetReqUpdateProfile) -> Bool`

#### `ValidateOTPGateway`
- **Conforms to:** `ValidateOTPGatewayProtocol`
- **Methods:**
  - `validate(username: String, code: String) -> NetResValidate?`

### Card

#### `AddCardGateway`
- **Conforms to:** `AddCardGatewayProtocol`
- **Methods:**
  - `addCard(cardNumber: String, expiry: String) -> NetResAddCard?`

#### `CardListGateway`
- **Conforms to:** `CardListGatewayProtocol`
- **Methods:**
  - `getCardList() -> [NetResCardItem]?`

#### `DeleteCardGateway`
- **Conforms to:** `DeleteCardGatewayProtocol`
- **Methods:**
  - `delete(id: String) -> Bool?`

#### `SelectDefaultCardGateway`
- **Conforms to:** `SelectDefaultCardGatewayProtocol`
- **Methods:**
  - `selectDefaultCard(cardId: String) -> Bool`

#### `VerifyCardGateway`
- **Conforms to:** `VerifyCardGatewayProtocol`
- **Methods:**
  - `verifyCard(key: String, code: String) -> Bool?`

### CheckLocation

#### `CheckLocationGateway`
- **Conforms to:** `CheckLocationGatewayProtocol`
- **Methods:**
  - `checkLocation(lat: Double, lng: Double) -> NetCheckLocationRes`
  - `request() -> URLRequest`

### Main

#### `FindExecutorsGateway`
- **Conforms to:** `FindExecutorsGatewayProtocol`
- **Methods:**
  - `findExecutors(req: NetReqExecutors) -> NetResExecutors?`

#### `GetTaxiTariffsGateway`
- **Conforms to:** `GetTaxiTariffsGatewayProtocol`
- **Methods:**
  - `getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) -> NetResTaxiTariffList?`

#### `OrderHistoryGateway`
- **Conforms to:** `OrderHistoryGatewayProtocol`
- **Methods:**
  - `loadHistory(page: Int, limit: Int = 8) -> NetResOrderHistory?`

#### `RouteTariffCalcGateway`
- **Conforms to:** `RouteTariffCalcGatewayProtocol`
- **Methods:**

#### `RoutingGateway`
- **Conforms to:** `RoutingGatewayProtocol`
- **Methods:**
  - `execute(req: [(lat: Double, lng: Double)]) -> RoutingResponse?`

### Notification

#### `LoadNotificationsGateway`
- **Conforms to:** `LoadNotificationsGatewayProtocol`
- **Methods:**
  - `load(page: Int, perPage: Int) -> NetResNotifications?`

#### `ReadAllNotifsGatewayImpl`
- **Conforms to:** `ReadAllNotifsGateway`
- **Methods:**
  - `execute() -> Bool`

#### `ShowAndReadNotifGatewayImpl`
- **Conforms to:** `ShowAndReadNotifGateway`
- **Methods:**
  - `execute(notificationId: Int64) -> NetResNotification?`

#### `UnreadNotificationsGateway`
- **Conforms to:** `UnreadNotificationsGatewayProtocol`
- **Methods:**
  - `execute() -> Int?`

### Order

#### `ActiveOrdersCountGateway`
- **Conforms to:** `ActiveOrdersCountGatewayProtocol`
- **Methods:**
  - `getActiveOrdersCount() -> Int?`

#### `ActiveOrdersGateway`
- **Conforms to:** `ActiveOrdersGatewayProtocol`
- **Methods:**
  - `getActiveOrders() -> [NetResOrderDetails]?`

#### `ArchivedOrderGateway`
- **Conforms to:** `ArchivedOrderGatewayProtocol`
- **Methods:**
  - `getArchivedOrder(id: Int) -> NetResOrderDetails?`

#### `CancelOrderGateway`
- **Conforms to:** `CancelOrderGatewayProtocol`
- **Methods:**
  - `cancelOrder(id: Int) -> Bool`

#### `CancelOrderReasonGateway`
- **Conforms to:** `CancelOrderReasonGatewayProtocol`
- **Methods:**
  - `cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) -> Bool`

#### `FastOrderGatewayImpl`
- **Conforms to:** `FasterOrderGateway`
- **Methods:**
  - `getFasterOrder(orderId: Int) -> Bool`

#### `GetOrderDetailsGateway`
- **Conforms to:** `GetOrderDetailsGatewayProtocol`
- **Methods:**
  - `getOrderDetails(orderId id: Int) -> NetResOrderDetails?`

#### `RateOrderGateway`
- **Conforms to:** `RateOrderGatewayProtocol`
- **Methods:**
  - `rateOrder(orderId: Int, rate: Int, comment: String) -> Bool`


---

## Use Cases

### ActiveBonus

#### `ActivateBonuseUseCase`
- **Conforms to:** `ActivateBonuseUseCaseProtocol`
- **Methods:**
  - `activate(promoCode: String) -> ActivatePromocodeResult?`

### Address

#### `AddPlaceUseCase`
- **Conforms to:** `AddPlaceUseCaseProtocol`
- **Methods:**
  - `execute(request: AddPlaceRequest) -> Bool`

#### `DeleteAddressUseCase`
- **Conforms to:** `DeleteAddressUseCaseProtocol`
- **Methods:**
  - `execute(id: Int) -> Bool`

#### `GetAddressUseCase`
- **Conforms to:** `GetAddressUseCaseProtocol`
- **Methods:**
  - `execute(lat: Double, lng: Double) -> AddressResponse?`

#### `LoadMyPlacesUseCase`
- **Conforms to:** `LoadMyPlacesUseCaseProtocol`
- **Methods:**
  - `execute() -> [MyPlaceItem]`

#### `LoadNearAddressUseCase`
- **Conforms to:** `LoadNearAddressUseCaseProtocol`
- **Methods:**
  - `execute(lat: Double, lng: Double) -> [SearchAddressItem]`

#### `SearchAddressUseCase`
- **Conforms to:** `SearchAddressUseCaseProtocol`
- **Methods:**
  - `execute(text: String) -> [SearchAddressItem]`

#### `UpdatePlaceUseCase`
- **Conforms to:** `UpdatePlaceUseCaseProtocol`
- **Methods:**
  - `execute(request: UpdatePlaceRequest) -> Bool`

### Auth

#### `ChangeAvatarUseCase`
- **Conforms to:** `ChangeAvatarUseCaseProtocol`
- **Methods:**
  - `execute(profileAvatar: Data) -> (success: Bool, result: AvatarResponse?)`

#### `GetMeInfoUseCase`
- **Conforms to:** `GetMeInfoUseCaseProtocol`
- **Methods:**
  - `execute() -> UserInfoResponse?`

#### `LogoutUseCase`
- **Conforms to:** `LogoutUseCaseProtocol`
- **Methods:**
  - `execute() -> Bool`

#### `RegisterUseCase`
- **Conforms to:** `RegisterUseCaseProtocol`
- **Methods:**
  - `execute(request: RegistrationRequest) -> Bool`

#### `SendOTPUseCase`
- **Conforms to:** `SendOTPUseCaseProtocol, Sendable`
- **Methods:**
  - `execute(username: String) -> OTPResponse?`

#### `UpdateProfileUseCase`
- **Conforms to:** `UpdateProfileUseCaseProtocol`
- **Methods:**
  - `execute(request: ProfileUpdateRequest) -> Bool`

#### `ValidateOTPUseCase`
- **Conforms to:** `ValidateOTPUseCaseProtocol`
- **Methods:**
  - `execute(username: String, code: String) -> ValidationResponse?`
  - `create(withResponse res: NetResClient) -> UserInfo`

### Card

#### `AddCardUseCase`
- **Conforms to:** `AddCardUseCaseProtocol`
- **Methods:**
  - `execute(request: CardAddRequest) -> CardAddResponse?`

#### `DeleteCardUseCase`
- **Conforms to:** `DeleteCardUseCaseProtocol`
- **Methods:**
  - `delete(cardId: String) -> Bool`

#### `GetCardListUseCase`
- **Conforms to:** `GetCardListUseCaseProtocol`
- **Methods:**
  - `execute() -> [CardItem]`

#### `SetDefaultCardUseCase`
- **Conforms to:** `SetDefaultCardUseCaseProtocol`
- **Methods:**
  - `execute(cardId: String) -> Bool`

#### `SyncCardsUseCaseImpl`
- **Conforms to:** ``
- **Methods:**
  - `syncCards() -> Void`
  - `setDefault(cardId: String) -> Void`
  - `set(cards: [CardItem]) -> Void`

#### `VerifyCardUseCase`
- **Conforms to:** `VerifyCardUseCaseProtocol`
- **Methods:**
  - `execute(request: CardVerifyRequest) -> Bool`

### CheckLocation

#### `CheckLocationUseCase`
- **Conforms to:** `CheckLocationUseCaseProtocol`
- **Methods:**
  - `checkLocation(lat: Double, lng: Double) -> CheckLocationResult`

### Main

#### `FindExecutorsUseCase`
- **Conforms to:** `FindExecutorsUseCaseProtocol,`
- **Methods:**
  - `getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) -> TaxiExecutors?`

#### `GetTaxiTariffsUseCase`
- **Conforms to:** `GetTaxiTariffsUseCaseProtocol`
- **Methods:**
  - `execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) -> [TaxiTariff]`

#### `LoadOrderHistoryUseCase`
- **Conforms to:** `LoadOrderHistoryUseCaseProtocol`
- **Methods:**
  - `execute(page: Int, limit: Int = 8) -> OrderHistoryResponse?`

#### `RouteTariffCalcUseCase`
- **Conforms to:** `RouteTariffCalcUseCaseProtocol`
- **Methods:**
  - `execute(request: RouteTariffCalcRequest) -> RouteTariffCalcResponse?`

#### `RoutingUseCase`
- **Conforms to:** `RoutingUseCaseProtocol`
- **Methods:**
  - `execute(req: [(lat: Double, lng: Double)]) -> RoutingResponse?`

### Notification

#### `LoadNotificationsUseCase`
- **Conforms to:** `LoadNotificationsUseCaseProtocol`
- **Methods:**
  - `execute(page: Int, perPage: Int) -> NotificationsResponse?`

#### `ReadAllNotifsUseCase`
- **Conforms to:** `ReadAllNotifsUseCaseProtocol`
- **Methods:**
  - `execute() -> Bool`

#### `ShowAndReadNotifUseCase`
- **Conforms to:** `ShowAndReadNotifUseCaseProtocol`
- **Methods:**
  - `execute(notifId: Int64) -> NotificationItem?`

#### `UnreadNotificationsUseCase`
- **Conforms to:** `UnreadNotificationsUseCaseProtocol`
- **Methods:**
  - `execute() -> Int?`

### Order

#### `ActiveOrdersCountUseCase`
- **Conforms to:** `ActiveOrdersCountUseCaseProtocol`
- **Methods:**
  - `execute() -> Int`

#### `ActiveOrdersUseCase`
- **Conforms to:** `ActiveOrdersUseCaseProtocol`
- **Methods:**
  - `execute() -> [OrderDetails]`

#### `ArchivedOrderUseCase`
- **Conforms to:** `ArchivedOrderUseCaseProtocol`
- **Methods:**
  - `execute(id: Int) -> OrderDetails?`

#### `CancelOrderReasonUseCase`
- **Conforms to:** `CancelOrderReasonUseCaseProtocol`
- **Methods:**
  - `execute(orderId: Int, reasonId: Int, reasonComment: String) -> Bool`

#### `CancelOrderUseCase`
- **Conforms to:** `CancelOrderUseCaseProtocol`
- **Methods:**
  - `execute(id: Int) -> Bool`

#### `FasterOrderUseCase`
- **Conforms to:** `FasterOrderUseCaseProtocol`
- **Methods:**
  - `execute(orderId: Int) -> Bool`

#### `GetOrderDetailsUseCase`
- **Conforms to:** `GetOrderDetailsUseCaseProtocol`
- **Methods:**
  - `execute(orderId: Int) -> OrderDetails?`

#### `RateOrderUseCase`
- **Conforms to:** `RateOrderUseCaseProtocol`
- **Methods:**
  - `execute(orderId: Int, rate: Int, comment: String) -> Bool`

### Other

#### `SyncFCMUseCaseImpl`
- **Conforms to:** `SyncFCMUseCase`
- **Methods:**
  - `request() -> URLRequest`
  - `sendFCMToken(token: String) -> Bool`
  - `syncFCMtoken() -> Bool`
