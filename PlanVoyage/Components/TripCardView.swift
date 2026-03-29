import SwiftUI

struct TripCardView: View {
    let trip: Trip
    let gradient: LinearGradient

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                Image(systemName: trip.coverImageName)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            .frame(width: 74, height: 74)

            VStack(alignment: .leading, spacing: 6) {
                Text(trip.title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("\(trip.startDate.formattedDay()) → \(trip.endDate.formattedDay())")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                Text("\(trip.places.count) saved stops")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
            }
            Spacer()
        }
        .padding()
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
