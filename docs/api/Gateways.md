# Gateways API Reference

Complete reference of all Gateways in IldamSDK. Gateways abstract data access and communicate with backend APIs.

## Overview

Gateways follow a consistent pattern:
- Protocol defines the interface
- Implementation handles network communication
- Returns network DTOs (not domain models)
- Called by UseCases

## Authentication Gateways

### SendOTPGateway

Sends one-time password to user's phone.

**Protocol:** `SendOTPGatewayProtocol`

**Methods:**
- `sendOTP(username: String) async throws -> NetResSendOTP?`

**Example:**
```swift
let gateway = SendOTPGateway()
let result = try await gateway.sendOTP(username: "+1234567890")
print("Session ID: \(result?.sessionId ?? "")")
```

---

### ValidateOTPGateway

Validates OTP code and authenticates user.

**Protocol:** `ValidateOTPGatewayProtocol`

**Methods:**
- `validate(username: String, code: String) async throws -> NetResValidate?`

**Example:**
```swift
let gateway = ValidateOTPGateway()
let result = try await gateway.validate(username: "+1234567890", code: "1234")
```

---

### GetMeInfoGateway

Retrieves current user information.

**Protocol:** `GetMeInfoGatewayProtocol`

**Methods:**
- `getMeInfo() async -> NetResMeInfo?`

**Example:**
```swift
let gateway = GetMeInfoGateway()
let userInfo = await gateway.getMeInfo()
```

---

### RegisterGateway

Registers new user profile.

**Protocol:** `RegisterGatewayProtocol`

**Methods:**
- `register(req: NetReqRegisterProfile) async -> NetRes<NetResRegisterProfile>?`

**Example:**
```swift
let request = NetReqRegisterProfile(
    givenNames: "John",
    surName: "Doe",
    birthday: "1990-01-01",
    gender: .male
)
let gateway = RegisterGateway()
let result = await gateway.register(req: request)
```

---

### UpdateProfileGateway

Updates user profile information.

**Protocol:** `UpdateProfileGatewayProtocol`

**Methods:**
- `updateProfile(req: NetReqUpdateProfile) async -> Bool`

**Example:**
```swift
let request = NetReqUpdateProfile(
    givenNames: "Jane",
    surName: "Smith",
    birthday: nil,
    gender: .female,
    image: nil
)
let gateway = UpdateProfileGateway()
let success = await gateway.updateProfile(req: request)
```

---

### ChangeAvatarGateway

Updates user profile avatar.

**Protocol:** `ChangeAvatarGatewayProtocol`

**Methods:**
- `changeAvatar(profileAvatar: Data) async -> NetRes<NetResChangeAvatar>?`

**Example:**
```swift
let imageData = UIImage(named: "avatar")?.jpegData(compressionQuality: 0.8)
let gateway = ChangeAvatarGateway()
let result = await gateway.changeAvatar(profileAvatar: imageData!)
```

---

### LogoutGateway

Logs out current user.

**Protocol:** `LogoutGatewayProtocol`

**Methods:**
- `logout() async -> Bool`

**Example:**
```swift
let gateway = LogoutGateway()
let success = await gateway.logout()
```

---

## Address Gateways

### GetAddressGateway

Reverse geocodes coordinates to address.

**Protocol:** `GetAddressGatewayProtocol`

**Methods:**
- `getAddress(lat: Double, lng: Double) async -> NetResGetAddress?`

**Example:**
```swift
let gateway = GetAddressGateway()
let address = await gateway.getAddress(lat: 40.7128, lng: -74.0060)
```

---

### SearchAddressGateway

Searches addresses by text query.

**Protocol:** `SearchAddressGatewayProtocol`

**Methods:**
- `searchAddress(text: String) async -> [NetResAddressItem]?`

**Example:**
```swift
let gateway = SearchAddressGateway()
let results = await gateway.searchAddress(text: "Main Street")
```

---

### LoadNearAddressGateway

Loads nearby addresses for given coordinates.

**Protocol:** `LoadNearAddressGatewayProtocol`

**Methods:**
- `loadNearAddress(lat: Double, lng: Double) async -> [NetResAddressItem]`

**Example:**
```swift
let gateway = LoadNearAddressGateway()
let nearby = await gateway.loadNearAddress(lat: 40.7128, lng: -74.0060)
```

---

### MyPlacesGateway

Retrieves user's saved places.

**Protocol:** `MyPlacesGatewayProtocol`

**Methods:**
- `loadMyPlaces() async -> [NetResMyAddressItem]`

**Example:**
```swift
let gateway = MyPlacesGateway()
let places = await gateway.loadMyPlaces()
```

---

### AddPlaceGateway

Adds a new saved place.

**Protocol:** `AddPlaceGatewayProtocol`

**Methods:**
- `addMyPlace(req: NetReqAddAddress) async -> Bool`

**Example:**
```swift
let request = NetReqAddAddress(
    name: "Home",
    address: "123 Main St",
    lat: 40.7128,
    lng: -74.0060,
    type: .home
)
let gateway = AddPlaceGateway()
let success = await gateway.addMyPlace(req: request)
```

---

### UpdatePlaceGateway

Updates an existing saved place.

**Protocol:** `UpdatePlaceGatewayProtocol`

**Methods:**
- `updateMyPlace(req: NetReqEditAddress, id: Int) async -> Bool`

**Example:**
```swift
let request = NetReqEditAddress(name: "Office", address: "456 Work Ave")
let gateway = UpdatePlaceGateway()
let success = await gateway.updateMyPlace(req: request, id: 42)
```

---

### DeleteAddressGateway

Deletes a saved place.

**Protocol:** `DeleteAddressGatewayProtocol`

**Methods:**
- `deleteAddress(id: Int) async -> Bool`

**Example:**
```swift
let gateway = DeleteAddressGateway()
let success = await gateway.deleteAddress(id: 42)
```

---

## Card Gateways

### CardListGateway

Retrieves user's payment cards.

**Protocol:** `CardListGatewayProtocol`

**Methods:**
- `getCardList() async -> [NetResCardItem]?`

**Example:**
```swift
let gateway = CardListGateway()
let cards = await gateway.getCardList()
```

---

### AddCardGateway

Adds a new payment card.

**Protocol:** `AddCardGatewayProtocol`

**Methods:**
- `addCard(cardNumber: String, expiry: String) async -> NetResAddCard?`

**Example:**
```swift
let gateway = AddCardGateway()
let result = await gateway.addCard(cardNumber: "1234567890123456", expiry: "12/25")
```

---

### VerifyCardGateway

Verifies a payment card with SMS code.

**Protocol:** `VerifyCardGatewayProtocol`

**Methods:**
- `verifyCard(key: String, code: String) async -> Bool?`

**Example:**
```swift
let gateway = VerifyCardGateway()
let success = await gateway.verifyCard(key: "verification_key", code: "1234")
```

---

### SelectDefaultCardGateway

Sets a card as default payment method.

**Protocol:** `SelectDefaultCardGatewayProtocol`

**Methods:**
- `selectDefaultCard(cardId: String) async -> Bool`

**Example:**
```swift
let gateway = SelectDefaultCardGateway()
let success = await gateway.selectDefaultCard(cardId: "card_123")
```

---

### DeleteCardGateway

Deletes a payment card.

**Protocol:** `DeleteCardGatewayProtocol`

**Methods:**
- `delete(id: String) async -> Bool?`

**Example:**
```swift
let gateway = DeleteCardGateway()
let success = await gateway.delete(id: "card_123")
```

---

## Order Gateways

### ActiveOrdersGateway

Retrieves user's active orders.

**Protocol:** `ActiveOrdersGatewayProtocol`

**Methods:**
- `getActiveOrders() async -> [NetResOrderDetails]?`

**Example:**
```swift
let gateway = ActiveOrdersGateway()
let orders = await gateway.getActiveOrders()
```

---

### ActiveOrdersCountGateway

Gets count of active orders.

**Protocol:** `ActiveOrdersCountGatewayProtocol`

**Methods:**
- `getActiveOrdersCount() async -> Int?`

**Example:**
```swift
let gateway = ActiveOrdersCountGateway()
let count = await gateway.getActiveOrdersCount()
```

---

### GetOrderDetailsGateway

Retrieves detailed information for a specific order.

**Protocol:** `GetOrderDetailsGatewayProtocol`

**Methods:**
- `getOrderDetails(orderId id: Int) async -> NetResOrderDetails?`

**Example:**
```swift
let gateway = GetOrderDetailsGateway()
let order = await gateway.getOrderDetails(orderId: 12345)
```

---

### OrderHistoryGateway

Loads paginated order history.

**Protocol:** `OrderHistoryGatewayProtocol`

**Methods:**
- `loadHistory(page: Int, limit: Int = 8) async -> NetResOrderHistory?`

**Example:**
```swift
let gateway = OrderHistoryGateway()
let history = await gateway.loadHistory(page: 1, limit: 10)
```

---

### ArchivedOrderGateway

Retrieves archived order details.

**Protocol:** `ArchivedOrderGatewayProtocol`

**Methods:**
- `getArchivedOrder(id: Int) async -> NetResOrderDetails?`

**Example:**
```swift
let gateway = ArchivedOrderGateway()
let order = await gateway.getArchivedOrder(id: 12345)
```

---

### CancelOrderGateway

Cancels an active order.

**Protocol:** `CancelOrderGatewayProtocol`

**Methods:**
- `cancelOrder(id: Int) async -> Bool`

**Example:**
```swift
let gateway = CancelOrderGateway()
let success = await gateway.cancelOrder(id: 12345)
```

---

### CancelOrderReasonGateway

Cancels order with a specific reason.

**Protocol:** `CancelOrderReasonGatewayProtocol`

**Methods:**
- `cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async -> Bool`

**Example:**
```swift
let gateway = CancelOrderReasonGateway()
let success = await gateway.cancelOrderReason(
    orderId: 12345,
    reasonId: 2,
    reasonComment: "Driver is taking too long"
)
```

---

### RateOrderGateway

Rates a completed order.

**Protocol:** `RateOrderGatewayProtocol`

**Methods:**
- `rateOrder(orderId: Int, rate: Int, comment: String) async -> Bool`

**Example:**
```swift
let gateway = RateOrderGateway()
let success = await gateway.rateOrder(
    orderId: 12345,
    rate: 5,
    comment: "Great service!"
)
```

---

### FasterOrderGateway

Requests faster order processing.

**Protocol:** `FasterOrderGateway`

**Methods:**
- `getFasterOrder(orderId: Int) async -> Bool`

**Example:**
```swift
let gateway = FastOrderGatewayImpl()
let success = await gateway.getFasterOrder(orderId: 12345)
```

---

## Main/Routing Gateways

### CheckLocationGateway

Checks if location is within service area.

**Protocol:** `CheckLocationGatewayProtocol`

**Methods:**
- `checkLocation(lat: Double, lng: Double) async -> NetCheckLocationRes`
- `request() -> URLRequest`

**Example:**
```swift
let gateway = CheckLocationGateway()
let result = await gateway.checkLocation(lat: 40.7128, lng: -74.0060)
```

---

### FindExecutorsGateway

Finds available drivers/executors.

**Protocol:** `FindExecutorsGatewayProtocol`

**Methods:**
- `findExecutors(req: NetReqExecutors) async -> NetResExecutors?`

**Example:**
```swift
let request = NetReqExecutors(
    tariffId: 1,
    lat: 40.7128,
    lng: -74.0060,
    options: []
)
let gateway = FindExecutorsGateway()
let executors = await gateway.findExecutors(req: request)
```

---

### GetTaxiTariffsGateway

Retrieves available taxi tariffs for a route.

**Protocol:** `GetTaxiTariffsGatewayProtocol`

**Methods:**
- `getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> NetResTaxiTariffList?`

**Example:**
```swift
let gateway = GetTaxiTariffsGateway()
let tariffs = await gateway.getTaxiTariffs(
    coords: [(40.7128, -74.0060), (40.7589, -73.9851)],
    addressId: 1,
    options: []
)
```

---

### RoutingGateway

Calculates route between coordinates.

**Protocol:** `RoutingGatewayProtocol`

**Methods:**
- `execute(req: [(lat: Double, lng: Double)]) async -> RoutingResponse?`

**Example:**
```swift
let gateway = RoutingGateway()
let route = await gateway.execute(req: [
    (40.7128, -74.0060),
    (40.7589, -73.9851)
])
```

---

### RouteTariffCalcGateway

Calculates tariff for a specific route.

**Protocol:** `RouteTariffCalcGatewayProtocol`

**Methods:**
- Methods not specified in original documentation

---

## Notification Gateways

### LoadNotificationsGateway

Loads paginated notifications.

**Protocol:** `LoadNotificationsGatewayProtocol`

**Methods:**
- `load(page: Int, perPage: Int) async -> NetResNotifications?`

**Example:**
```swift
let gateway = LoadNotificationsGateway()
let notifications = await gateway.load(page: 1, perPage: 20)
```

---

### UnreadNotificationsGateway

Gets count of unread notifications.

**Protocol:** `UnreadNotificationsGatewayProtocol`

**Methods:**
- `execute() async -> Int?`

**Example:**
```swift
let gateway = UnreadNotificationsGateway()
let count = await gateway.execute()
```

---

### ShowAndReadNotifGateway

Shows and marks notification as read.

**Protocol:** `ShowAndReadNotifGateway`

**Methods:**
- `execute(notificationId: Int64) async -> NetResNotification?`

**Example:**
```swift
let gateway = ShowAndReadNotifGatewayImpl()
let notification = await gateway.execute(notificationId: 12345)
```

---

### ReadAllNotifsGateway

Marks all notifications as read.

**Protocol:** `ReadAllNotifsGateway`

**Methods:**
- `execute() async -> Bool`

**Example:**
```swift
let gateway = ReadAllNotifsGatewayImpl()
let success = await gateway.execute()
```

---

### ActiveOrdersV2Gateway

Retrieves user's active orders using the V2 API.

**Protocol:** `ActiveOrdersV2GatewayProtocol`

**Methods:**
- `getActiveOrders() async throws -> [NetResOrderDetails]?`

**Example:**
```swift
let gateway = ActiveOrdersV2Gateway()
let orders = try await gateway.getActiveOrders()
```

---

### GetOrderDetailsV2Gateway

Retrieves order details using the V2 API.

**Protocol:** `GetOrderDetailsV2GatewayProtocol`

**Methods:**
- `getOrderDetails(orderId: Int) async throws -> NetResOrderDetails?`

**Example:**
```swift
let gateway = GetOrderDetailsV2Gateway()
let order = try await gateway.getOrderDetails(orderId: 12345)
```

---

### ArchivedOrderV2Gateway

Retrieves a single archived order using the V2 API.

**Protocol:** `ArchivedOrderV2GatewayProtocol`

**Methods:**
- `getArchivedOrder(id: Int) async throws -> NetResOrderDetails?`

**Example:**
```swift
let gateway = ArchivedOrderV2Gateway()
let order = try await gateway.getArchivedOrder(id: 12345)
```

---

### ArchivedOrdersV2Gateway

Loads paginated archived orders using the V2 API with brand service filtering.

**Protocol:** `ArchivedOrdersV2GatewayProtocol`

**Methods:**
- `loadHistory(page: Int, limit: Int, brandServiceId: Int?) async -> NetResOrderHistory?`

**Example:**
```swift
let gateway = ArchivedOrdersV2Gateway()
let history = await gateway.loadHistory(page: 1, limit: 8, brandServiceId: nil)
```

---

### DeleteOrderGateway

Deletes an archived order.

**Protocol:** `DeleteOrderGatewayProtocol`

**Methods:**
- `delete(id: Int) async throws -> Bool`

**Example:**
```swift
let gateway = DeleteOrderGateway()
let success = try await gateway.delete(id: 12345)
```

---

### UpdateOrderPaymentMethodGateway

Updates the payment method for an active order.

**Protocol:** `UpdateOrderPaymentMethodGatewayProtocol`

**Methods:**
- `update(orderId: Int, cardId: String?, type: String) async throws -> Bool`

**Example:**
```swift
let gateway = UpdateOrderPaymentMethodGateway()
let success = try await gateway.update(orderId: 12345, cardId: "card_123", type: "card")
```

---

### RateOrderV2Gateway

Rates a completed order with optional rating reasons.

**Protocol:** `RateOrderV2GatewayProtocol`

**Methods:**
- `rateOrder(orderId: Int, rate: Int, comment: String, ratingReasonIds: [Int]) async throws -> Bool`

**Example:**
```swift
let gateway = RateOrderV2Gateway()
let success = try await gateway.rateOrder(
    orderId: 12345,
    rate: 5,
    comment: "Great service!",
    ratingReasonIds: [1, 3]
)
```

---

## Other Gateways

### ActivateBonuseGateway

Activates a promotional bonus code.

**Protocol:** `ActivateBonuseGatewayProtocol`

**Methods:**
- `activate(promoCode: String) async -> ActivateBonuseGateway.Response?`

**Example:**
```swift
let gateway = ActivateBonuseGateway()
let result = await gateway.activate(promoCode: "SAVE20")
```

---

### BecomeDriverGateway

Submits a request to become a driver.

**Protocol:** `BecomeDriverGatewayProtocol`

**Methods:**
- `execute(req: NetReqBeDriver) async throws -> Bool`

**Example:**
```swift
let gateway = BecomeDriverGateway()
let success = try await gateway.execute(req: driverRequest)
```

---

### DistrictsGateway

Loads available districts/addresses.

**Protocol:** `DistrictsGatewayProtocol`

**Methods:**
- `execute() async throws -> [NetResDistrictItem]`

**Example:**
```swift
let gateway = DistrictsGateway()
let districts = try await gateway.execute()
```

---

### RatingReasonGateway

Loads available rating reasons for order feedback.

**Protocol:** `RatingReasonGatewayProtocol`

**Methods:**
- `load() async throws -> [NetResRatingReasonsItem]`

**Example:**
```swift
let gateway = RatingReasonGateway()
let reasons = try await gateway.load()
```

---

### BrandServicesGateway

Loads available brand services.

**Protocol:** `BrandServicesGatewayProtocol`

**Methods:**
- `load() async throws -> [NetResBrandServiceItem]`

**Example:**
```swift
let gateway = BrandServicesGateway()
let services = try await gateway.load()
```

---

## Gateway Patterns

### Common Pattern

All gateways follow this pattern:

```swift
// 1. Define protocol
protocol MyGatewayProtocol {
    func operation(param: String) async -> Response?
}

// 2. Implement gateway
struct MyGateway: MyGatewayProtocol {
    func operation(param: String) async -> Response? {
        return await Network.send(
            request: MyNetworkRoute.endpoint(param: param)
        )?.result
    }
}

// 3. Use in UseCase
struct MyUseCase {
    private let gateway: MyGatewayProtocol

    func execute(param: String) async -> DomainModel? {
        guard let response = await gateway.operation(param: param) else {
            return nil
        }
        return transform(response)
    }
}
```

## See Also

- [UseCases Reference](UseCases.md)
- [Gateway Pattern Guide](../guides/GatewayPattern.md)
- [IldamSDK Package](../packages/IldamSDK.md)
- [NetworkLayer Package](../packages/NetworkLayer.md)
