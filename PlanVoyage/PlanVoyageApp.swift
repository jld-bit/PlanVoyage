import SwiftUI
import SwiftData

@main
struct PlanVoyageApp: App {
    @StateObject private var storeManager = StoreManager()
    @StateObject private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(storeManager)
                .environmentObject(notificationManager)
        }
        .modelContainer(for: [Trip.self, Place.self])
    }
}
