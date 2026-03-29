import SwiftUI

struct ItineraryDaySectionView: View {
    let day: Date
    let places: [Place]
    let resolvePlace: (UUID) -> Place?
    let onDroppedPlace: (Place) -> Void

    var body: some View {
        Section(day.formattedDay()) {
            ForEach(places.sorted { $0.scheduledAt < $1.scheduledAt }, id: \.id) { place in
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(.headline)
                    Text(place.scheduledAt.formattedTime())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if !place.placeNotes.isEmpty {
                        Text(place.placeNotes)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
                .draggable(place.id.uuidString)
            }
        }
        .dropDestination(for: String.self) { items, _ in
            guard let idString = items.first,
                  let id = UUID(uuidString: idString),
                  let match = resolvePlace(id) else { return false }
            onDroppedPlace(match)
            return true
        }
    }
}
