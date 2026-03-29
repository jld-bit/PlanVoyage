import Foundation
import SwiftData

@MainActor
final class TripListViewModel: ObservableObject {
    func canCreateTrip(currentTripCount: Int, isPremium: Bool) -> Bool {
        isPremium || currentTripCount < 1
    }

    func createTrip(
        title: String,
        startDate: Date,
        endDate: Date,
        coverImageName: String,
        modelContext: ModelContext
    ) {
        let trip = Trip(title: title, startDate: startDate, endDate: endDate, coverImageName: coverImageName)
        modelContext.insert(trip)
    }
}
