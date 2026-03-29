import SwiftUI
import SwiftData

struct TripListView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var storeManager: StoreManager

    @Query(sort: \Trip.createdAt, order: .reverse) private var trips: [Trip]

    @StateObject private var viewModel = TripListViewModel()
    @State private var isShowingCreate = false
    @State private var isShowingPaywall = false

    var activeTrips: [Trip] { trips.filter { !$0.isArchived } }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(Array(activeTrips.enumerated()), id: \.element.id) { idx, trip in
                        NavigationLink {
                            TripDetailView(trip: trip)
                        } label: {
                            TripCardView(trip: trip, gradient: VoyageTheme.gradients[idx % VoyageTheme.gradients.count])
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Your Trips")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !storeManager.isPremium {
                        Button("Upgrade") { isShowingPaywall = true }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if viewModel.canCreateTrip(currentTripCount: activeTrips.count, isPremium: storeManager.isPremium) {
                            isShowingCreate = true
                        } else {
                            isShowingPaywall = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingCreate) {
                TripEditorView()
            }
            .sheet(isPresented: $isShowingPaywall) {
                PremiumPaywallView()
            }
            .task { await storeManager.refreshEntitlements() }
        }
    }
}
