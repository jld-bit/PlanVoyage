import SwiftUI
import MapKit

struct MapPlacesView: View {
    @EnvironmentObject private var storeManager: StoreManager
    let trip: Trip

    @State private var position: MapCameraPosition = .automatic
    @State private var offlineRegionSaved = false

    var body: some View {
        VStack(spacing: 12) {
            if storeManager.isPremium {
                Toggle("Offline map pack for this trip", isOn: $offlineRegionSaved)
                    .padding(.horizontal)
            }

            Map(position: $position) {
                ForEach(trip.places, id: \.id) { place in
                    Marker(place.name, coordinate: place.coordinate)
                        .tint(.orange)
                }
            }
            .mapStyle(.standard(elevation: .realistic))
        }
        .navigationTitle("Trip Map")
        .navigationBarTitleDisplayMode(.inline)
    }
}
