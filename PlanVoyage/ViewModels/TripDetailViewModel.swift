import Foundation
import SwiftData
import PDFKit
import UIKit

@MainActor
final class TripDetailViewModel: ObservableObject {
    func addPlace(
        to trip: Trip,
        name: String,
        notes: String,
        scheduledAt: Date,
        latitude: Double,
        longitude: Double,
        modelContext: ModelContext
    ) {
        let nextOrder = (trip.places.map(\.sortOrder).max() ?? -1) + 1
        let place = Place(
            name: name,
            placeNotes: notes,
            scheduledAt: scheduledAt,
            latitude: latitude,
            longitude: longitude,
            sortOrder: nextOrder,
            trip: trip
        )
        trip.places.append(place)
        modelContext.insert(place)
    }

    func move(place: Place, to day: Date) {
        let original = place.scheduledAt
        if let shifted = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: original), minute: Calendar.current.component(.minute, from: original), second: 0, of: day) {
            place.scheduledAt = shifted
        }
    }

    func exportPDF(for trip: Trip) -> URL? {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(trip.title)-itinerary.pdf")
        let lines = trip.places.sorted { $0.scheduledAt < $1.scheduledAt }.map {
            "• \($0.scheduledAt.formattedDay()) \($0.scheduledAt.formattedTime()) - \($0.name)"
        }.joined(separator: "\n")

        let text = "Plan Voyage\n\n\(trip.title)\n\(trip.startDate.formattedDay()) - \(trip.endDate.formattedDay())\n\nItinerary\n\(lines)"
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        let attributed = NSAttributedString(string: text, attributes: attributes)

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        do {
            try renderer.writePDF(to: tempURL) { context in
                context.beginPage()
                attributed.draw(in: CGRect(x: 32, y: 32, width: 548, height: 728))
            }
            return tempURL
        } catch {
            return nil
        }
    }
}
