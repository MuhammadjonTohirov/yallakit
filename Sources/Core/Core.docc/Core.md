# ``Core``

Shared utilities, extensions, UI components, and helper classes used across YallaKit.

## Overview

Core is a foundational package providing reusable components that support other packages in YallaKit. It includes Swift extensions, SwiftUI views, storage utilities, and location services.

## Topics

### Extensions

- Array, String, Date, Color, Font, Number, View, URL, and more
- Codable helpers (asDictionary, asString, asData)

### UI Components

- Alert system (Popup, WindowAlertManager)
- Bottom sheets (FlexibleDraggableBottomSheet, SimpleFlexibleBottomSheet)
- Loading animations (20+ animation styles via LoadingIndicator)
- Scrollable components (PageableScrollView, VerticalScrollView)

### Storage

- ``UserSettings`` — Persistent user preferences using @codableWrapper
- ``Language`` — Localization support
- ``DatabaseConfig`` — Database configuration

### Utilities

- ``Constants`` — App-wide configuration (API URLs, endpoints)
- ``AppMetrics`` — Device and screen metrics
- ``Padding`` — Consistent spacing values
- ``SoundEffect`` — System sound playback
