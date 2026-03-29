# Plan Voyage (SwiftUI)

Plan Voyage is an original travel planning concept app built with SwiftUI, SwiftData, MVVM, MapKit, local notifications, and StoreKit 2.

## Legal / Design disclaimer
This project intentionally avoids copying protected branding, copyrighted assets, trade dress, and exact UX patterns from existing travel apps.

## Feature set
- Onboarding flow to create a first trip quickly
- Trips with title, dates, and cover symbol image
- Places with notes, date/time, and coordinates
- Drag-and-drop itinerary between day buckets
- MapKit screen with all saved trip places
- Offline persistence via SwiftData
- Freemium logic (1 free active trip, premium unlocks unlimited)
- Premium extras: offline map pack toggle and PDF export
- Local notifications for upcoming activities
- Reusable cards, clean colorful gradients, preview seed data

## Architecture
- MVVM and reusable views/components
- `Models/` for SwiftData entities
- `ViewModels/` for business logic and StoreKit/notifications
- `Views/` and `Components/` for UI
- `Utilities/` for theme and helpers
