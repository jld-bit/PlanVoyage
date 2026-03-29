import SwiftUI

struct PlaceEditorView: View {
    @Environment(\.dismiss) private var dismiss

    let trip: Trip
    let onSave: (String, String, Date, Double, Double) -> Void

    @State private var name = ""
    @State private var notes = ""
    @State private var date = Date()
    @State private var latitude = "37.7749"
    @State private var longitude = "-122.4194"

    var body: some View {
        NavigationStack {
            Form {
                TextField("Place name", text: $name)
                TextField("Notes", text: $notes, axis: .vertical)
                DatePicker("Date & time", selection: $date)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Place")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(name, notes, date, Double(latitude) ?? 0, Double(longitude) ?? 0)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
