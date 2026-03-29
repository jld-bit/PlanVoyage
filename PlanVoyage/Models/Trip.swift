import Foundation
import SwiftData

@Model
final class Trip {
    var id: UUID
    var title: String
    var startDate: Date
    var endDate: Date
    var coverImageName: String
    var createdAt: Date
    var isArchived: Bool

    @Relationship(deleteRule: .cascade, inverse: \Place.trip)
    var places: [Place]

    init(
        id: UUID = UUID(),
        title: String,
        startDate: Date,
        endDate: Date,
        coverImageName: String = "mountain.2.fill",
        createdAt: Date = .now,
        isArchived: Bool = false,
        places: [Place] = []
    ) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.coverImageName = coverImageName
        self.createdAt = createdAt
        self.isArchived = isArchived
        self.places = places
    }
}

extension Trip {
    static var placeholderImages: [String] {
        [
            "sun.max.fill",
            "mountain.2.fill",
            "ferry.fill",
            "building.2.fill",
            "leaf.fill",
            "airplane"
        ]
    }

    var dayBuckets: [Date: [Place]] {
        Dictionary(grouping: places.sorted { $0.scheduledAt < $1.scheduledAt }) { $0.scheduledAt.startOfDay }
    }

    var dayRange: [Date] {
        var dates: [Date] = []
        var current = startDate.startOfDay
        while current <= endDate.startOfDay {
            dates.append(current)
            guard let next = Calendar.current.date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }
        return dates
    }
}
