import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Plan Voyage")
                        .font(.largeTitle.bold())
                    Text("Build original travel plans in minutes. Add places, drag your itinerary by day, and stay on track offline.")
                        .foregroundStyle(.secondary)

                    TextField("First trip title", text: $viewModel.title)
                        .textFieldStyle(.roundedBorder)

                    DatePicker("Start", selection: $viewModel.startDate, displayedComponents: .date)
                    DatePicker("End", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)

                    Text("Pick a cover icon")
                        .font(.headline)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 12) {
                        ForEach(Trip.placeholderImages, id: \.self) { image in
                            Image(systemName: image)
                                .font(.title2)
                                .frame(width: 56, height: 56)
                                .background(viewModel.selectedImage == image ? Color.blue.opacity(0.2) : Color.gray.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .onTapGesture { viewModel.selectedImage = image }
                        }
                    }

                    Button("Create My First Trip") {
                        let trip = Trip(
                            title: viewModel.title,
                            startDate: viewModel.startDate,
                            endDate: viewModel.endDate,
                            coverImageName: viewModel.selectedImage
                        )
                        modelContext.insert(trip)
                        hasCompletedOnboarding = true
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.canContinue)
                }
                .padding()
            }
        }
    }
}
