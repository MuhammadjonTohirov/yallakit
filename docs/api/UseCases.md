# UseCases API Reference

Complete reference of all UseCases in IldamSDK. UseCases contain business logic and orchestrate gateway calls.

## Overview

UseCases follow a consistent pattern:
- Protocol defines the interface
- Implementation contains business logic
- Depends on Gateway protocols (injected)
- Returns domain models (not network DTOs)
- Called by View/ViewModel layer

## Authentication UseCases

### SendOTPUseCase

Sends OTP code to user's phone number.

**Protocol:** `SendOTPUseCaseProtocol, Sendable`

**Methods:**
- `execute(username: String) async throws -> OTPResponse?`

**Example:**
```swift
let useCase = SendOTPUseCase(gateway: SendOTPGateway())
let result = try await useCase.execute(username: "+1234567890")
print("Session: \(result?.sessionId ?? "")")
```

---

### ValidateOTPUseCase

Validates OTP code and returns authentication token.

**Protocol:** `ValidateOTPUseCaseProtocol`

**Methods:**
- `execute(username: String, code: String) async throws -> ValidationResponse?`
- `create(withResponse res: NetResClient) -> UserInfo`

**Example:**
```swift
let useCase = ValidateOTPUseCase(gateway: ValidateOTPGateway())
let result = try await useCase.execute(username: "+1234567890", code: "1234")
if let token = result?.token {
    // Save token and proceed
}
```

---

### GetMeInfoUseCase

Retrieves current user's profile information.

**Protocol:** `GetMeInfoUseCaseProtocol`

**Methods:**
- `execute() async -> UserInfoResponse?`

**Example:**
```swift
let useCase = GetMeInfoUseCase(gateway: GetMeInfoGateway())
let userInfo = await useCase.execute()
```

---

### RegisterUseCase

Registers a new user profile.

**Protocol:** `RegisterUseCaseProtocol`

**Methods:**
- `execute(request: RegistrationRequest) async -> Bool`

**Example:**
```swift
let request = RegistrationRequest(
    givenNames: "John",
    surName: "Doe",
    birthday: "1990-01-01",
    gender: .male
)
let useCase = RegisterUseCase(gateway: RegisterGateway())
let success = await useCase.execute(request: request)
```

---

### UpdateProfileUseCase

Updates user profile information.

**Protocol:** `UpdateProfileUseCaseProtocol`

**Methods:**
- `execute(request: ProfileUpdateRequest) async -> Bool`

**Example:**
```swift
let request = ProfileUpdateRequest(
    givenNames: "Jane",
    surName: "Smith",
    birthday: nil,
    gender: .female
)
let useCase = UpdateProfileUseCase(gateway: UpdateProfileGateway())
let success = await useCase.execute(request: request)
```

---

### ChangeAvatarUseCase

Changes user's profile avatar.

**Protocol:** `ChangeAvatarUseCaseProtocol`

**Methods:**
- `execute(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?)`

**Example:**
```swift
let imageData = UIImage(named: "avatar")?.jpegData(compressionQuality: 0.8)!
let useCase = ChangeAvatarUseCase(gateway: ChangeAvatarGateway())
let (success, result) = await useCase.execute(profileAvatar: imageData)
if success, let avatarUrl = result?.url {
    // Update UI with new avatar
}
```

---

### LogoutUseCase

Logs out the current user.

**Protocol:** `LogoutUseCaseProtocol`

**Methods:**
- `execute() async -> Bool`

**Example:**
```swift
let useCase = LogoutUseCase(gateway: LogoutGateway())
let success = await useCase.execute()
if success {
    // Clear local data, navigate to login
}
```

---

## Address UseCases

### GetAddressUseCase

Gets address details from coordinates (reverse geocoding).

**Protocol:** `GetAddressUseCaseProtocol`

**Methods:**
- `execute(lat: Double, lng: Double) async -> AddressResponse?`

**Example:**
```swift
let useCase = GetAddressUseCase(gateway: GetAddressGateway())
let address = await useCase.execute(lat: 40.7128, lng: -74.0060)
print("Address: \(address?.fullAddress ?? "")")
```

---

### SearchAddressUseCase

Searches for addresses by text query.

**Protocol:** `SearchAddressUseCaseProtocol`

**Methods:**
- `execute(text: String) async -> [SearchAddressItem]`

**Example:**
```swift
let useCase = SearchAddressUseCase(gateway: SearchAddressGateway())
let results = await useCase.execute(text: "Main Street")
```

---

### LoadNearAddressUseCase

Loads addresses near given coordinates.

**Protocol:** `LoadNearAddressUseCaseProtocol`

**Methods:**
- `execute(lat: Double, lng: Double) async -> [SearchAddressItem]`

**Example:**
```swift
let useCase = LoadNearAddressUseCase(gateway: LoadNearAddressGateway())
let nearby = await useCase.execute(lat: 40.7128, lng: -74.0060)
```

---

### LoadMyPlacesUseCase

Loads user's saved favorite places.

**Protocol:** `LoadMyPlacesUseCaseProtocol`

**Methods:**
- `execute() async -> [MyPlaceItem]`

**Example:**
```swift
let useCase = LoadMyPlacesUseCase(gateway: MyPlacesGateway())
let places = await useCase.execute()
```

---

### AddPlaceUseCase

Adds a new favorite place.

**Protocol:** `AddPlaceUseCaseProtocol`

**Methods:**
- `execute(request: AddPlaceRequest) async -> Bool`

**Example:**
```swift
let request = AddPlaceRequest(
    name: "Home",
    address: "123 Main St",
    latitude: 40.7128,
    longitude: -74.0060,
    type: .home
)
let useCase = AddPlaceUseCase(gateway: AddPlaceGateway())
let success = await useCase.execute(request: request)
```

---

### UpdatePlaceUseCase

Updates an existing favorite place.

**Protocol:** `UpdatePlaceUseCaseProtocol`

**Methods:**
- `execute(request: UpdatePlaceRequest) async -> Bool`

**Example:**
```swift
let request = UpdatePlaceRequest(
    id: 42,
    name: "Office",
    address: "456 Work Ave"
)
let useCase = UpdatePlaceUseCase(gateway: UpdatePlaceGateway())
let success = await useCase.execute(request: request)
```

---

### DeleteAddressUseCase

Deletes a saved favorite place.

**Protocol:** `DeleteAddressUseCaseProtocol`

**Methods:**
- `execute(id: Int) async -> Bool`

**Example:**
```swift
let useCase = DeleteAddressUseCase(gateway: DeleteAddressGateway())
let success = await useCase.execute(id: 42)
```

---

## Card UseCases

### GetCardListUseCase

Retrieves user's payment cards.

**Protocol:** `GetCardListUseCaseProtocol`

**Methods:**
- `execute() async -> [CardItem]`

**Example:**
```swift
let useCase = GetCardListUseCase(gateway: CardListGateway())
let cards = await useCase.execute()
```

---

### AddCardUseCase

Adds a new payment card.

**Protocol:** `AddCardUseCaseProtocol`

**Methods:**
- `execute(request: CardAddRequest) async -> CardAddResponse?`

**Example:**
```swift
let request = CardAddRequest(
    cardNumber: "1234567890123456",
    expiry: "12/25"
)
let useCase = AddCardUseCase(gateway: AddCardGateway())
let result = await useCase.execute(request: request)
if let verificationKey = result?.verificationKey {
    // Proceed to card verification
}
```

---

### VerifyCardUseCase

Verifies a payment card with SMS code.

**Protocol:** `VerifyCardUseCaseProtocol`

**Methods:**
- `execute(request: CardVerifyRequest) async -> Bool`

**Example:**
```swift
let request = CardVerifyRequest(
    verificationKey: "key_123",
    code: "1234"
)
let useCase = VerifyCardUseCase(gateway: VerifyCardGateway())
let success = await useCase.execute(request: request)
```

---

### SetDefaultCardUseCase

Sets a card as the default payment method.

**Protocol:** `SetDefaultCardUseCaseProtocol`

**Methods:**
- `execute(cardId: String) async -> Bool`

**Example:**
```swift
let useCase = SetDefaultCardUseCase(gateway: SelectDefaultCardGateway())
let success = await useCase.execute(cardId: "card_123")
```

---

### DeleteCardUseCase

Deletes a payment card.

**Protocol:** `DeleteCardUseCaseProtocol`

**Methods:**
- `delete(cardId: String) async -> Bool`

**Example:**
```swift
let useCase = DeleteCardUseCase(gateway: DeleteCardGateway())
let success = await useCase.delete(cardId: "card_123")
```

---

### SyncCardsUseCase

Syncs payment cards between local and server.

**Protocol:** Protocol not specified

**Methods:**
- `syncCards() async -> Void`
- `setDefault(cardId: String) -> Void`
- `set(cards: [CardItem]) -> Void`

**Example:**
```swift
let useCase = SyncCardsUseCaseImpl()
await useCase.syncCards()
```

---

## Order UseCases

### ActiveOrdersUseCase

Retrieves user's active orders.

**Protocol:** `ActiveOrdersUseCaseProtocol`

**Methods:**
- `execute() async -> [OrderDetails]`

**Example:**
```swift
let useCase = ActiveOrdersUseCase(gateway: ActiveOrdersGateway())
let orders = await useCase.execute()
```

---

### ActiveOrdersCountUseCase

Gets count of active orders.

**Protocol:** `ActiveOrdersCountUseCaseProtocol`

**Methods:**
- `execute() async -> Int`

**Example:**
```swift
let useCase = ActiveOrdersCountUseCase(gateway: ActiveOrdersCountGateway())
let count = await useCase.execute()
```

---

### GetOrderDetailsUseCase

Retrieves detailed information for a specific order.

**Protocol:** `GetOrderDetailsUseCaseProtocol`

**Methods:**
- `execute(orderId: Int) async -> OrderDetails?`

**Example:**
```swift
let useCase = GetOrderDetailsUseCase(gateway: GetOrderDetailsGateway())
let order = await useCase.execute(orderId: 12345)
```

---

### LoadOrderHistoryUseCase

Loads paginated order history.

**Protocol:** `LoadOrderHistoryUseCaseProtocol`

**Methods:**
- `execute(page: Int, limit: Int = 8) async -> OrderHistoryResponse?`

**Example:**
```swift
let useCase = LoadOrderHistoryUseCase(gateway: OrderHistoryGateway())
let history = await useCase.execute(page: 1, limit: 10)
```

---

### ArchivedOrderUseCase

Retrieves archived order details.

**Protocol:** `ArchivedOrderUseCaseProtocol`

**Methods:**
- `execute(id: Int) async -> OrderDetails?`

**Example:**
```swift
let useCase = ArchivedOrderUseCase(gateway: ArchivedOrderGateway())
let order = await useCase.execute(id: 12345)
```

---

### CancelOrderUseCase

Cancels an active order.

**Protocol:** `CancelOrderUseCaseProtocol`

**Methods:**
- `execute(id: Int) async -> Bool`

**Example:**
```swift
let useCase = CancelOrderUseCase(gateway: CancelOrderGateway())
let success = await useCase.execute(id: 12345)
```

---

### CancelOrderReasonUseCase

Cancels order with a specific reason.

**Protocol:** `CancelOrderReasonUseCaseProtocol`

**Methods:**
- `execute(orderId: Int, reasonId: Int, reasonComment: String) async -> Bool`

**Example:**
```swift
let useCase = CancelOrderReasonUseCase(gateway: CancelOrderReasonGateway())
let success = await useCase.execute(
    orderId: 12345,
    reasonId: 2,
    reasonComment: "Driver is taking too long"
)
```

---

### RateOrderUseCase

Rates a completed order.

**Protocol:** `RateOrderUseCaseProtocol`

**Methods:**
- `execute(orderId: Int, rate: Int, comment: String) async -> Bool`

**Example:**
```swift
let useCase = RateOrderUseCase(gateway: RateOrderGateway())
let success = await useCase.execute(
    orderId: 12345,
    rate: 5,
    comment: "Excellent service!"
)
```

---

### FasterOrderUseCase

Requests faster order processing (premium service).

**Protocol:** `FasterOrderUseCaseProtocol`

**Methods:**
- `execute(orderId: Int) async -> Bool`

**Example:**
```swift
let useCase = FasterOrderUseCase(gateway: FasterOrderGatewayImpl())
let success = await useCase.execute(orderId: 12345)
```

---

## Main/Routing UseCases

### CheckLocationUseCase

Checks if location is within service area.

**Protocol:** `CheckLocationUseCaseProtocol`

**Methods:**
- `checkLocation(lat: Double, lng: Double) async -> CheckLocationResult`

**Example:**
```swift
let useCase = CheckLocationUseCase(gateway: CheckLocationGateway())
let result = await useCase.checkLocation(lat: 40.7128, lng: -74.0060)
if result.isAvailable {
    print("Service available in this area")
}
```

---

### FindExecutorsUseCase

Finds available drivers/executors near a location.

**Protocol:** `FindExecutorsUseCaseProtocol`

**Methods:**
- `getExecutors(tariffId: Int?, lat: Double, lng: Double, options: [Int]) async -> TaxiExecutors?`

**Example:**
```swift
let useCase = FindExecutorsUseCase(gateway: FindExecutorsGateway())
let executors = await useCase.getExecutors(
    tariffId: 1,
    lat: 40.7128,
    lng: -74.0060,
    options: []
)
```

---

### GetTaxiTariffsUseCase

Gets available taxi tariffs for a route.

**Protocol:** `GetTaxiTariffsUseCaseProtocol`

**Methods:**
- `execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> [TaxiTariff]`

**Example:**
```swift
let useCase = GetTaxiTariffsUseCase(gateway: GetTaxiTariffsGateway())
let tariffs = await useCase.execute(
    coords: [(40.7128, -74.0060), (40.7589, -73.9851)],
    addressId: 1,
    options: []
)
```

---

### RoutingUseCase

Calculates optimal route between coordinates.

**Protocol:** `RoutingUseCaseProtocol`

**Methods:**
- `execute(req: [(lat: Double, lng: Double)]) async -> RoutingResponse?`

**Example:**
```swift
let useCase = RoutingUseCase(gateway: RoutingGateway())
let route = await useCase.execute(req: [
    (40.7128, -74.0060),
    (40.7589, -73.9851)
])
```

---

### RouteTariffCalcUseCase

Calculates tariff for a specific route.

**Protocol:** `RouteTariffCalcUseCaseProtocol`

**Methods:**
- `execute(request: RouteTariffCalcRequest) async -> RouteTariffCalcResponse?`

**Example:**
```swift
let request = RouteTariffCalcRequest(
    route: routeData,
    tariffId: 1,
    options: []
)
let useCase = RouteTariffCalcUseCase(gateway: RouteTariffCalcGateway())
let result = await useCase.execute(request: request)
```

---

## Notification UseCases

### LoadNotificationsUseCase

Loads paginated notifications.

**Protocol:** `LoadNotificationsUseCaseProtocol`

**Methods:**
- `execute(page: Int, perPage: Int) async -> NotificationsResponse?`

**Example:**
```swift
let useCase = LoadNotificationsUseCase(gateway: LoadNotificationsGateway())
let notifications = await useCase.execute(page: 1, perPage: 20)
```

---

### UnreadNotificationsUseCase

Gets count of unread notifications.

**Protocol:** `UnreadNotificationsUseCaseProtocol`

**Methods:**
- `execute() async -> Int?`

**Example:**
```swift
let useCase = UnreadNotificationsUseCase(gateway: UnreadNotificationsGateway())
let count = await useCase.execute()
```

---

### ShowAndReadNotifUseCase

Shows notification details and marks as read.

**Protocol:** `ShowAndReadNotifUseCaseProtocol`

**Methods:**
- `execute(notifId: Int64) async -> NotificationItem?`

**Example:**
```swift
let useCase = ShowAndReadNotifUseCase(gateway: ShowAndReadNotifGatewayImpl())
let notification = await useCase.execute(notifId: 12345)
```

---

### ReadAllNotifsUseCase

Marks all notifications as read.

**Protocol:** `ReadAllNotifsUseCaseProtocol`

**Methods:**
- `execute() async -> Bool`

**Example:**
```swift
let useCase = ReadAllNotifsUseCase(gateway: ReadAllNotifsGatewayImpl())
let success = await useCase.execute()
```

---

### ActiveOrdersV2UseCase

Retrieves user's active orders using the V2 API.

**Protocol:** `ActiveOrdersV2UseCaseProtocol`

**Methods:**
- `execute() async throws -> [OrderDetails]?`

**Example:**
```swift
let useCase = ActiveOrdersV2UseCase()
let orders = try await useCase.execute()
```

---

### GetOrderDetailsV2UseCase

Retrieves order details using the V2 API.

**Protocol:** `GetOrderDetailsV2UseCaseProtocol`

**Methods:**
- `execute(orderId: Int) async throws -> OrderDetails?`

**Example:**
```swift
let useCase = GetOrderDetailsV2UseCase()
let order = try await useCase.execute(orderId: 12345)
```

---

### ArchivedOrderV2UseCase

Retrieves a single archived order using the V2 API.

**Protocol:** `ArchivedOrderV2UseCaseProtocol`

**Methods:**
- `execute(id: Int) async throws -> OrderDetails?`

**Example:**
```swift
let useCase = ArchivedOrderV2UseCase()
let order = try await useCase.execute(id: 12345)
```

---

### ArchivedOrdersV2UseCase

Loads paginated archived orders with brand service filtering.

**Protocol:** `ArchivedOrdersV2UseCaseProtocol`

**Methods:**
- `execute(page: Int, limit: Int, brandServiceId: Int?) async -> OrderHistoryResponse?`

**Example:**
```swift
let useCase = ArchivedOrdersV2UseCase()
let history = await useCase.execute(page: 1, limit: 8, brandServiceId: nil)
```

---

### DeleteOrderUseCase

Deletes an archived order.

**Protocol:** `DeleteOrderUseCaseProtocol`

**Methods:**
- `execute(id: Int) async throws -> Bool`

**Example:**
```swift
let useCase = DeleteOrderUseCase()
let success = try await useCase.execute(id: 12345)
```

---

### UpdateOrderPaymentMethodUseCase

Updates the payment method for an active order.

**Protocol:** `UpdateOrderPaymentMethodUseCaseProtocol`

**Methods:**
- `execute(orderId: Int, cardId: String?, type: String) async throws -> Bool`
- `updateToCash(orderId: Int) async throws -> Bool`
- `updateToCard(orderId: Int, cardId: String) async throws -> Bool`

**Example:**
```swift
let useCase = UpdateOrderPaymentMethodUseCase()

// Switch to cash
let success = try await useCase.updateToCash(orderId: 12345)

// Switch to card
let success = try await useCase.updateToCard(orderId: 12345, cardId: "card_123")
```

---

### RateOrderV2UseCase

Rates a completed order with comment or rating reasons.

**Protocol:** `RateOrderV2UseCaseProtocol`

**Methods:**
- `execute(orderId: Int, rate: Int, comment: String) async throws -> Bool`
- `execute(orderId: Int, rate: Int, reasons: [Int]) async throws -> Bool`

**Example:**
```swift
let useCase = RateOrderV2UseCase()
let success = try await useCase.execute(orderId: 12345, rate: 5, comment: "Great!")
// or with reasons
let success = try await useCase.execute(orderId: 12345, rate: 4, reasons: [1, 3])
```

---

## Service UseCases

### OrderTaxiUseCase

Creates a taxi order.

**Protocol:** `OrderTaxiUseCaseProtocol`

**Methods:**
- `orderTaxi(req: OrderTaxiRequest) async throws -> Int?`

**Example:**
```swift
let useCase = OrderTaxiUseCase()
let orderId = try await useCase.orderTaxi(req: orderRequest)
```

---

### AppConfigUseCase

Fetches and caches application configuration.

**Protocol:** `AppConfigUseCase`

**Properties:**
- `appConfig: AppConfig?` - Cached app configuration

**Methods:**
- `fetchAppConfig() async throws -> Bool`

**Example:**
```swift
let useCase = AppConfigUseCaseImpl()
let success = try await useCase.fetchAppConfig()
if let config = useCase.appConfig {
    // Use config
}
```

---

### SettingsConfigUseCase

Fetches order settings configuration.

**Protocol:** `SettingsConfigUseCase`

**Properties:**
- `config: OrderConfigSettings?` (static) - Cached settings

**Methods:**
- `fetch() async throws -> OrderConfigSettings?`

**Example:**
```swift
let useCase = SettingsConfigUseCaseImpl()
let settings = try await useCase.fetch()
```

---

### FetchSecondaryAddressesUseCase

Fetches secondary address options for an order based on coordinates.

**Protocol:** `FetchSecondaryAddressesUseCase`

**Methods:**
- `fetch(lat: Double, lng: Double) async throws -> [SecondaryAddressItem]`

**Example:**
```swift
let useCase = FetchSecondaryAddressUseCaseImpl()
let addresses = try await useCase.fetch(lat: 41.311, lng: 69.279)
```

---

## Other UseCases

### BecomeDriverUseCase

Submits a request to become a driver.

**Protocol:** `BecomeDriverUseCaseProtocol`

**Methods:**
- `execute(request: BecomeDriverRequest) async throws -> Bool`

**Example:**
```swift
let useCase = BecomeDriverUseCase()
let success = try await useCase.execute(request: driverRequest)
```

---

### DistrictsUseCase

Loads available districts.

**Protocol:** `DistrictsUseCaseProtocol`

**Methods:**
- `execute() async throws -> [DistrictItem]`

**Example:**
```swift
let useCase = DistrictsUseCase()
let districts = try await useCase.execute()
```

---

### RatingReasonUseCase

Loads available rating reasons for order feedback.

**Protocol:** `RatingReasonUseCaseProtocol`

**Methods:**
- `execute() async throws -> [RatingReasonItem]`

**Example:**
```swift
let useCase = RatingReasonUseCase()
let reasons = try await useCase.execute()
```

---

### BrandServicesUseCase

Loads available brand services.

**Protocol:** `BrandServicesUseCaseProtocol`

**Methods:**
- `execute() async throws -> [BrandServiceItem]`

**Example:**
```swift
let useCase = BrandServicesUseCase()
let services = try await useCase.execute()
```

---

### ActivateBonuseUseCase

Activates a promotional bonus code.

**Protocol:** `ActivateBonuseUseCaseProtocol`

**Methods:**
- `activate(promoCode: String) async -> ActivatePromocodeResult?`

**Example:**
```swift
let useCase = ActivateBonuseUseCase(gateway: ActivateBonuseGateway())
let result = await useCase.activate(promoCode: "SAVE20")
```

---

### SyncFCMUseCase

Syncs Firebase Cloud Messaging token.

**Protocol:** `SyncFCMUseCase`

**Methods:**
- `request() -> URLRequest`
- `sendFCMToken(token: String) async -> Bool`
- `syncFCMtoken() async -> Bool`

**Example:**
```swift
let useCase = SyncFCMUseCaseImpl()
let success = await useCase.sendFCMToken(token: "fcm_token_123")
```

---

## UseCase Patterns

### Standard Pattern

```swift
// 1. Define protocol
protocol MyUseCaseProtocol {
    func execute(param: String) async -> DomainModel?
}

// 2. Implement use case
struct MyUseCase: MyUseCaseProtocol {
    private let gateway: MyGatewayProtocol

    init(gateway: MyGatewayProtocol) {
        self.gateway = gateway
    }

    func execute(param: String) async -> DomainModel? {
        // Business logic
        guard let networkDTO = await gateway.operation(param: param) else {
            return nil
        }

        // Transform to domain model
        return DomainModel(from: networkDTO)
    }
}

// 3. Use in ViewModel
class MyViewModel {
    private let useCase: MyUseCaseProtocol

    init(useCase: MyUseCaseProtocol) {
        self.useCase = useCase
    }

    func performAction() async {
        let result = await useCase.execute(param: "value")
        // Update UI
    }
}
```

## See Also

- [Gateways Reference](Gateways.md)
- [UseCase Pattern Guide](../guides/UseCasePattern.md)
- [IldamSDK Package](../packages/IldamSDK.md)
- [Architecture Guide](../guides/Architecture.md)
