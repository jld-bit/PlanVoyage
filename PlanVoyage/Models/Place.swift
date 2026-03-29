import Foundation
import SwiftData
import CoreLocation

@Model
final class Place {
    var id: UUID
    var name: String
    var placeNotes: String
    var scheduledAt: Date
    var latitude: Double
    var longitude: Double
    var sortOrder: Int

    var trip: Trip?

    init(
        id: UUID = UUID(),
        name: String,
        placeNotes: String = "",
        scheduledAt: Date,
        latitude: Double,
        longitude: Double,
        sortOrder: Int = 0,
        trip: Trip? = nil
    ) {
        self.id = id
        self.name = name
        self.placeNotes = placeNotes
        self.scheduledAt = scheduledAt
        self.latitude = latitude
        self.longitude = longitude
        self.sortOrder = sortOrder
        self.trip = trip
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
