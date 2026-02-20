# Core Package

The Core package provides shared utilities, extensions, and helper classes used throughout YallaKit. It contains reusable components that support the other packages.

## Overview

Core is a foundational package containing:
- **Extensions**: Swift standard library and UIKit extensions
- **UI Components**: Reusable SwiftUI views and modifiers
- **Utilities**: Helper classes and functions
- **Models**: Shared domain models
- **Storage**: User settings and database configuration
- **Location**: Location management services

## Package Structure

```
Core/
├── Extensions/          # Swift & UIKit extensions
├── UI/                  # Reusable UI components
├── Util/                # Utility classes
├── Models/              # Shared domain models
├── Storage/             # Persistence layer
├── LocationManager/     # Location services
└── Network/             # Core network utilities
```

## Extensions

### Array+Extensions

Useful array utilities:

```swift
// Safe subscript access
let items = [1, 2, 3]
let item = items[safe: 10] // nil instead of crash

// Remove duplicates
let unique = items.unique()
```

### String+Extensions

String manipulation helpers:

```swift
// Phone number formatting
let phone = "+1234567890"
let formatted = phone.formatPhoneNumber() // "+1 (234) 567-8900"

// Validation
let isValidEmail = "user@example.com".isValidEmail

// Encoding
let encoded = "Hello World".urlEncoded
```

### Date+Extensions

Date utilities:

```swift
// Formatting
let dateString = Date().toString(format: "yyyy-MM-dd")

// Relative dates
let isToday = someDate.isToday
let isTomorrow = someDate.isTomorrow

// Date components
let startOfDay = Date().startOfDay
```

### Color+Extension

SwiftUI color utilities:

```swift
// Hex colors
let color = Color(hex: "#FF5733")

// Dynamic colors
let adaptive = Color.adaptiveColor(light: .white, dark: .black)
```

### View+Extensions

SwiftUI view extensions:

```swift
// Conditional modifiers
Text("Hello")
    .if(condition) { view in
        view.bold()
    }

// Corner radius for specific corners
Rectangle()
    .cornerRadius(16, corners: [.topLeft, .topRight])

// Hide keyboard
view.hideKeyboard()
```

### Number+Extension

Numeric extensions:

```swift
// Currency formatting
let price = 12.99
let formatted = price.toCurrency() // "$12.99"

// Distance formatting
let distance = 1500.0
let formatted = distance.toDistanceString() // "1.5 km"
```

### Font+Extensions

Custom fonts:

```swift
Text("Hello")
    .font(.customFont(.bold, size: 18))
```

## UI Components

### Alert System

Global alert management:

```swift
// Show alert
Popup.alert(
    title: "Success",
    message: "Operation completed",
    primaryButton: .default(Text("OK"))
)

// Show bottom sheet
Popup.bottomSheet {
    MyCustomView()
}

// Show confirmation
Popup.confirm(
    title: "Delete Item",
    message: "Are you sure?",
    confirmTitle: "Delete",
    confirmAction: {
        // Delete logic
    }
)
```

### Bottom Sheets

Flexible bottom sheet implementations:

#### FlexibleDraggableBottomSheet

```swift
FlexibleDraggableBottomSheet(
    isPresented: $showSheet,
    maxHeight: 600
) {
    VStack {
        Text("Sheet Content")
    }
}
```

#### SimpleFlexibleBottomSheet

```swift
SimpleFlexibleBottomSheet(
    isPresented: $showSheet,
    heights: [.medium, .large]
) {
    ContentView()
}
```

### Loading Indicators

Multiple loading animation styles:

```swift
// Circle loader
LoadingCircleTrim()

// Pulse animation
LoadingPulse()

// Three balls
LoadingThreeBalls()

// Custom
LoadingIndicator(style: .circleBars, color: .blue)
```

### Scrollable Components

#### PageableScrollView

Horizontal paging scroll view:

```swift
PageableScrollView(currentPage: $currentPage) {
    ForEach(items) { item in
        ItemView(item: item)
            .frame(width: UIScreen.main.bounds.width)
    }
}
```

#### VerticalScrollView

Scroll view with scroll offset tracking:

```swift
VerticalScrollView(scrollOffset: $offset) {
    ContentView()
}
```

## Utilities

### AppMetrics

Device and screen metrics:

```swift
// Screen dimensions
let width = AppMetrics.screenWidth
let height = AppMetrics.screenHeight

// Safe area
let safeAreaTop = AppMetrics.safeAreaTop
let safeAreaBottom = AppMetrics.safeAreaBottom

// Device info
let isIPhone = AppMetrics.isIPhone
let isIPad = AppMetrics.isIPad
```

### Constants

App-wide constants:

```swift
Constants.apiBaseURL
Constants.defaultTimeout
Constants.maxRetryAttempts
```

### Padding

Consistent spacing:

```swift
Padding.small    // 8
Padding.medium   // 16
Padding.large    // 24
Padding.xLarge   // 32
```

### SoundEffect

Play system sounds:

```swift
SoundEffect.play(.success)
SoundEffect.play(.error)
SoundEffect.play(.notification)
```

## Models

### Coordinate Models

#### Coord

```swift
struct Coord: Codable {
    let latitude: Double
    let longitude: Double
}
```

#### CoordinateAddress

```swift
struct CoordinateAddress {
    let coordinate: Coord
    let address: String
    let city: String?
    let country: String?
}
```

### User Models

#### UserInfo

```swift
struct UserInfo: Codable {
    let id: Int
    let phone: String
    let name: String
    let email: String?
    let avatar: String?
    let gender: Gender?
}
```

#### Gender

```swift
enum Gender: String, Codable {
    case male
    case female
    case other
}
```

### Card Models

#### CardItem

```swift
struct CardItem: Codable {
    let id: String
    let number: String // Masked: "**** 1234"
    let expiry: String
    let isDefault: Bool
}
```

### Route Models

#### RouteData

```swift
struct RouteData {
    let points: [Coord]
    let distance: Double // meters
    let duration: Double // seconds
}
```

## Storage

### UserSettings

Persistent user preferences:

```swift
// Save
UserSettings.shared.token = "abc123"
UserSettings.shared.userId = 42

// Read
let token = UserSettings.shared.token
let userId = UserSettings.shared.userId

// Clear
UserSettings.shared.clearAll()
```

### Language

Localization support:

```swift
// Current language
let current = Language.current

// Available languages
let available = Language.available

// Change language
Language.set(.en)
Language.set(.ru)
```

### DatabaseConfig

Database configuration:

```swift
DatabaseConfig.shared.setup()
DatabaseConfig.shared.clear()
```

## Location Manager

### GLocationManager

Comprehensive location services:

```swift
let locationManager = GLocationManager.shared

// Request permissions
locationManager.requestPermission()

// Get current location
locationManager.currentLocation { location in
    print("Lat: \(location.latitude), Lng: \(location.longitude)")
}

// Start tracking
locationManager.startTracking { location in
    // Updated location
}

// Stop tracking
locationManager.stopTracking()

// Check authorization
if locationManager.isAuthorized {
    // Location access granted
}
```

## View Modifiers

### Corner Radius

```swift
Rectangle()
    .cornerRadius(20, corners: [.topLeft, .topRight])
```

### Read Size/Rect

Measure view dimensions:

```swift
Text("Hello")
    .readSize { size in
        print("Width: \(size.width), Height: \(size.height)")
    }
    .readRect { rect in
        print("Frame: \(rect)")
    }
```

### Sheet Menu

Custom sheet presentation:

```swift
Text("Show Menu")
    .sheetMenu(isPresented: $showMenu) {
        MenuView()
    }
```

## Network Utilities

### Polygon Service

Check if coordinates are within service polygons:

```swift
let polygonService = PolygonService()

let isInServiceArea = await polygonService.check(
    lat: 40.7128,
    lng: -74.0060
)
```

## Best Practices

### 1. Use Extensions for Readability

```swift
// Good
let formatted = price.toCurrency()

// Bad
let formatted = NumberFormatter.currency.string(from: price)
```

### 2. Leverage Shared Utilities

```swift
// Good - use AppMetrics
let topPadding = AppMetrics.safeAreaTop

// Bad - hardcode
let topPadding = 44.0
```

### 3. Consistent Spacing

```swift
// Good - use Padding
VStack(spacing: Padding.medium) {
    // Content
}

// Bad - magic numbers
VStack(spacing: 16) {
    // Content
}
```

### 4. Type-Safe Models

```swift
// Good - use Gender enum
let gender: Gender = .male

// Bad - use strings
let gender = "male"
```

## Common Patterns

### Alert with Action

```swift
Popup.alert(
    title: "Confirm",
    message: "Delete this item?",
    primaryButton: .destructive(Text("Delete")) {
        deleteItem()
    },
    secondaryButton: .cancel()
)
```

### Loading State

```swift
struct MyView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            ContentView()

            if isLoading {
                LoadingIndicator()
            }
        }
    }
}
```

### Location-Based Feature

```swift
GLocationManager.shared.currentLocation { location in
    let address = CoordinateAddress(
        coordinate: Coord(
            latitude: location.latitude,
            longitude: location.longitude
        ),
        address: "",
        city: nil,
        country: nil
    )

    // Use address
}
```

## See Also

- [IldamSDK Package](IldamSDK.md)
- [NetworkLayer Package](NetworkLayer.md)
- [Architecture Guide](../guides/Architecture.md)
