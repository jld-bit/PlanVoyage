import SwiftUI
import SwiftData

struct TripEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 4, to: .now) ?? .now
    @State private var coverImageName = Trip.placeholderImages.first ?? "airplane"

    var body: some View {
        NavigationStack {
            Form {
                Section("Trip") {
                    TextField("Title", text: $title)
                    DatePicker("Start", selection: $startDate, displayedComponents: .date)
                    DatePicker("End", selection: $endDate, in: startDate..., displayedComponents: .date)
                }

                Section("Cover") {
                    Picker("Icon", selection: $coverImageName) {
                        ForEach(Trip.placeholderImages, id: \.self) {
                            Label($0, systemImage: $0).tag($0)
                        }
                    }
                }
            }
            .navigationTitle("New Trip")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        modelContext.insert(Trip(title: title, startDate: startDate, endDate: endDate, coverImageName: coverImageName))
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
