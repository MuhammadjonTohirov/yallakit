# ``IldamSDK``

Business logic layer containing UseCases, Gateways, and Domain Models for the Ildam taxi application.

## Overview

IldamSDK follows Clean Architecture principles. UseCases orchestrate business logic, Gateways abstract data access, and Domain Models represent the application's entities.

## Topics

### Authentication

- SendOTPUseCase, ValidateOTPUseCase, RegisterUseCase
- GetMeInfoUseCase, UpdateProfileUseCase, ChangeAvatarUseCase, LogoutUseCase

### Orders

- ActiveOrdersUseCase, ActiveOrdersV2UseCase
- GetOrderDetailsUseCase, GetOrderDetailsV2UseCase
- ArchivedOrderUseCase, ArchivedOrderV2UseCase, ArchivedOrdersV2UseCase
- CancelOrderUseCase, CancelOrderReasonUseCase
- RateOrderUseCase, RateOrderV2UseCase
- DeleteOrderUseCase, FasterOrderUseCase
- UpdateOrderPaymentMethodUseCase, OrderTaxiUseCase, BrandServicesUseCase

### Addresses

- GetAddressUseCase, SearchAddressUseCase, LoadNearAddressUseCase
- MyPlacesUseCase, AddMyPlaceUseCase, UpdatePlaceUseCase, DeleteAddressUseCase

### Cards

- CardListUseCase, AddCardUseCase, VerifyCardUseCase
- DeleteCardUseCase, SetDefaultCardUseCase, SyncCardsUseCase

### Notifications

- LoadNotificationsUseCase, UnreadNotificationsUseCase
- ShowAndReadNotifUseCase, ReadAllNotificationsUseCase

### Configuration

- AppConfigUseCase, SettingsConfigUseCase, FetchSecondaryAddressesUseCase

### Other

- CheckLocationUseCase, FindExecutorsUseCase, RoutingUseCase
- BecomeDriverUseCase, DistrictsUseCase, RatingReasonUseCase
- ActivateBonuseUseCase, SyncFCMUseCase
