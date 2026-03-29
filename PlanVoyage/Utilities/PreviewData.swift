import Foundation

enum PreviewData {
    static var sampleTrip: Trip {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 2, to: start) ?? start
        let trip = Trip(title: "Lisbon Escape", startDate: start, endDate: end, coverImageName: "ferry.fill")
        let place1 = Place(name: "Alfama Walk", placeNotes: "Sunset photos", scheduledAt: start.addingTimeInterval(3600 * 4), latitude: 38.711, longitude: -9.129, trip: trip)
        let place2 = Place(name: "Time Out Market", placeNotes: "Dinner", scheduledAt: start.addingTimeInterval(3600 * 8), latitude: 38.707, longitude: -9.146, trip: trip)
        trip.places = [place1, place2]
        return trip
    }
}
