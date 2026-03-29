import Foundation

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var title = ""
    @Published var startDate = Date()
    @Published var endDate = Calendar.current.date(byAdding: .day, value: 3, to: .now) ?? .now
    @Published var selectedImage = Trip.placeholderImages.first ?? "airplane"

    var canContinue: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && endDate >= startDate
    }
}
