import SwiftUI

struct PremiumPaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storeManager: StoreManager
    @State private var isPurchasing = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 18) {
                Text("Plan Voyage Premium")
                    .font(.largeTitle.bold())

                Label("Unlimited active trips", systemImage: "infinity")
                Label("Offline map packs", systemImage: "map")
                Label("Export itinerary to PDF", systemImage: "doc.richtext")

                Button {
                    Task {
                        isPurchasing = true
                        defer { isPurchasing = false }
                        try? await storeManager.purchasePremium()
                        dismiss()
                    }
                } label: {
                    Text(isPurchasing ? "Purchasing..." : "Start Premium")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(isPurchasing)

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
