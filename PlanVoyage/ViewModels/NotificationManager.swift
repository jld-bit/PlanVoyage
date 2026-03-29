import Foundation
import UserNotifications

@MainActor
final class NotificationManager: ObservableObject {
    @Published var isAuthorized = false

    func requestPermission() async {
        let center = UNUserNotificationCenter.current()
        do {
            isAuthorized = try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            isAuthorized = false
        }
    }

    func scheduleReminder(for place: Place, in trip: Trip) async {
        guard isAuthorized else { return }
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Upcoming: \(place.name)"
        content.body = "\(trip.title) at \(place.scheduledAt.formattedTime())"
        content.sound = .default

        let triggerDate = Calendar.current.date(byAdding: .minute, value: -30, to: place.scheduledAt) ?? place.scheduledAt
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let request = UNNotificationRequest(identifier: place.id.uuidString, content: content, trigger: UNCalendarNotificationTrigger(dateMatching: components, repeats: false))

        try? await center.add(request)
    }
}
