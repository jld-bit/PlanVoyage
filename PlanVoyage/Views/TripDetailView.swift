import SwiftUI
import SwiftData

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var storeManager: StoreManager
    @EnvironmentObject private var notificationManager: NotificationManager

    @StateObject private var viewModel = TripDetailViewModel()
    @State private var isShowingPlaceEditor = false
    @State private var exportFile: ExportFile?

    let trip: Trip

    var body: some View {
        List {
            Section {
                NavigationLink("View all places on map") {
                    MapPlacesView(trip: trip)
                }
            }

            ForEach(trip.dayRange, id: \.self) { day in
                ItineraryDaySectionView(day: day, places: trip.dayBuckets[day] ?? [], resolvePlace: { id in
                    trip.places.first(where: { $0.id == id })
                }) { place in
                    viewModel.move(place: place, to: day)
                }
            }
        }
        .navigationTitle(trip.title)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    isShowingPlaceEditor = true
                } label: {
                    Image(systemName: "plus")
                }

                if storeManager.isPremium {
                    Button {
                        if let url = viewModel.exportPDF(for: trip) {
                            exportFile = ExportFile(url: url)
                        }
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingPlaceEditor) {
            PlaceEditorView(trip: trip) { name, notes, date, lat, lon in
                viewModel.addPlace(to: trip, name: name, notes: notes, scheduledAt: date, latitude: lat, longitude: lon, modelContext: modelContext)
                if let created = trip.places.sorted(by: { $0.scheduledAt < $1.scheduledAt }).last {
                    Task { await notificationManager.scheduleReminder(for: created, in: trip) }
                }
            }
        }
        .sheet(item: $exportFile) { file in
            ShareLink(item: file.url)
                .padding()
        }
        .task { await notificationManager.requestPermission() }
    }
}

struct ExportFile: Identifiable {
    let id = UUID()
    let url: URL
}
